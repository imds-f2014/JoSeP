include "console.iol"
include "file.iol"
include "file_utils.iol"
include "runtime.iol"
include "string_utils.iol"
include "protocols/http.iol"

include "josep.iol"
include "page_interface.iol"
include "config.iol"

execution { concurrent }

interface HTTPInterface {
	RequestResponse:
		default(undefined)(undefined)
}

inputPort HTTPInput {
	Protocol: http {
		.keepAlive = true;
		.debug = DebugHttp; 
		.debug.showContent = DebugHttpContent;
		.format -> format;
		.contentType -> mime;

		.default = "default"
	}
	Location: ServerLocation
	Interfaces: HTTPInterface
}

outputPort Page {
	Interfaces: PageInterface
}

define buildService {
	isUpdated = false;

	exists@File(ServicesDirectory + path)(serviceExists);
	if(serviceExists) {
		getLastModified@FileUtils(ContentDirectory + path)(pageModified);
		getLastModified@FileUtils(ServicesDirectory + path)(serviceModified);

		if(serviceModified >= pageModified) {
			isUpdated = true
		}
	};

	if(isUpdated == false) {
		synchronized(compile) {
			println@Console("Recompiling " + path)();
			file.filename = ContentDirectory + path;
			readFile@File(file)(contents);
			compile@Josep(contents)(code);

			writefile.content = code;
			writefile.filename = ServicesDirectory + path;
			writeFile@File(writefile)()
		}
	}
}

main {
	[ default(request)(response) {
		scope(s) {
			install(FileNotFound =>
				println@Console("File not found: " + file.filename)()
			);
			
			s = request.operation;
			s.regex = "\\?";
			split@StringUtils(s)(s);
			
			// Default page
			path = s.result[0];
			if (path == "") {
				path = DefaultPage
			};

			// Check file ending
			endsWithReq = path;
			endsWithReq.suffix = ".ol";
			endsWith@StringUtils(endsWithReq)(isService);

			if(isService) {
				buildService;

				service.type = "jolie";
				service.filepath = ServicesDirectory + path;
				loadEmbeddedService@Runtime(service)(Page.location);

				getDocument@Page(request.data)(response);
				format = "html"
			} else {
				file.filename = ContentDirectory + path;

				getMimeType@File(file.filename)(mime);
				mime.regex = "/";
				split@StringUtils(mime)(s);
				if (s.result[0] == "text") {
					file.format = "text";
					format = "html"
				} else {
					file.format = format = "binary"
				};

				readFile@File(file)(response)
			}
		}
	} ] { nullProcess }
}

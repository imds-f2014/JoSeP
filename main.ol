include "console.iol"
include "file.iol"
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

init {
	buildPages
}

/**
 * Compiles all .ol files in ContentDirectory into Jolie services
 * with same path in ServicesDirectory.
 */
define buildPages {
	listreq.directory = ContentDirectory;
	list@File(listreq)(listres);
	for(i = 0, i < #listres.result, i++) {
		endsWithReq = listres.result[i];
		endsWithReq.suffix = ".ol";
		endsWith@StringUtils(endsWithReq)(isService);

		if(isService) {
			file.filename = ContentDirectory + listres.result[i];
			readFile@File(file)(contents);
			compile@Josep(contents)(code);

			writefile.content = code;
			writefile.filename = ServicesDirectory + listres.result[i];
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
			if (s.result[0] == "") {
				s.result[0] = DefaultPage
			};

			// Check file ending
			endsWithReq = s.result[0];
			endsWithReq.suffix = ".ol";
			endsWith@StringUtils(endsWithReq)(isService);

			if(isService) {
				service.type = "jolie";
				service.filepath = ServicesDirectory + s.result[0];
				loadEmbeddedService@Runtime(service)(Page.location);

				getDocument@Page(request)(response);
				format = "html"
			} else {
				file.filename = ContentDirectory + s.result[0];

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

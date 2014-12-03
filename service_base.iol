include "runtime.iol"
include "page_interface.iol"

execution { concurrent }

inputPort Local {
	Location: "local"
	Interfaces: PageInterface
}

outputPort Page {
	Interfaces: PageInterface
}

init {
	getLocalLocation@Runtime()(Page.location);
	global.content = ""
}

main {
	[ println(text)() {
		global.content += text+"\n"	}
	] { nullProcess }

	[ getDocument(request)(response) {
		operations;
		response = global.content
	} ] { nullProcess }
}

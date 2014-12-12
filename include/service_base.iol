include "runtime.iol"
// include "page_interface.iol"

execution { single }

inputPort Local {
	Location: "local"
	Interfaces: PageInterface
}

outputPort Page {
	Interfaces: PageInterface
}

init {
	getLocalLocation@Runtime()(Page.location);
	document = ""
}

main {
	getDocument(request)(response) {
		operations;
		response = document
	}
}

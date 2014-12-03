constants {
	// The deployment location for reaching the Leonardo web server
	ServerLocation = "socket://localhost:8000/",

	// The root directory in which Leonardo will look for content to serve to clients
	ContentDirectory = "www/",
	ServicesDirectory = "services/",

	// The default page to serve in case clients do not specify one
	DefaultPage = "index.ol",

	// Print debug messages for all exchanged HTTP messages
	DebugHttp = false,

	// Add the content of every HTTP message to their debug messages
	DebugHttpContent = false
}

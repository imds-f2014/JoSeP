interface JosepInterface {
	RequestResponse: compile(string)(string)
}

outputPort Josep {
	Interfaces: JosepInterface
}

embedded {
	Java: "josep.Josep" in Josep
}

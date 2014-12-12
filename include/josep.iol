interface JosepInterface {
	RequestResponse: compile(string)(string)
}

outputPort Josep {
	Interfaces: JosepInterface
}

embedded {
	Java: "josep.runtime.Compiler" in Josep
}

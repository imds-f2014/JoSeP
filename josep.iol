interface JosepInterface {
	RequestResponse: compile(string)(string)
}

outputPort Josep {
	Interfaces: JosepInterface
}

embedded {
	Java: "io.github.simonlarsen.josep.Josep" in Josep
}

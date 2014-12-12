type CompileRequest:undefined

interface TemplateInterface {
	RequestResponse: compile( CompileRequest )( string )
}

outputPort Template {
	Interfaces: TemplateInterface
}

embedded {
	Java: "io.github.simonlarsen.template.Template" in Template
}

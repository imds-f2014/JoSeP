interface FileUtilsInterface {
	RequestResponse: getLastModified(string)(long)
}

outputPort FileUtils {
	Interfaces: FileUtilsInterface
}

embedded {
	Java: "io.FileUtils" in FileUtils
}

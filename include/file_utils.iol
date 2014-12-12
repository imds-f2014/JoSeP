interface FileUtilsInterface {
	RequestResponse: getLastModified(string)(long)
}

outputPort FileUtils {
	Interfaces: FileUtilsInterface
}

embedded {
	Java: "josep.io.FileUtils" in FileUtils
}

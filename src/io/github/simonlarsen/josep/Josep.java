package io.github.simonlarsen.josep;

import jolie.runtime.JavaService;
import jolie.runtime.Value;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class Josep extends JavaService {
	private static final String TAG_PATTERN = "\\<\\?jolie\\s*([^\\?]*?)\\s*\\?\\>";
	private static final String HEADER = "include \"service_base.iol\"\ndefine operations {\n";
	private static final String FOOTER = "\tnullProcess\n}";

	private void addHTML(String text, StringBuilder builder) {
		builder.append("\tprintln@Page(\"");
		text = text.replaceAll("\\n", "\\\\n");
		builder.append(text);
		builder.append("\t\")();\n");
	}

	public String compile(Value request) {
		String contents = request.strValue();
		StringBuilder builder = new StringBuilder();

		builder.append(HEADER);

		Pattern pattern = Pattern.compile(TAG_PATTERN);
		Matcher matcher = pattern.matcher(contents);

		int i = 0;
		while(matcher.find()) {
			String code = matcher.group(1);
			addHTML(contents.substring(i, matcher.start()), builder);
			builder.append(code);
			builder.append("\n");
			i = matcher.end();
		}
		addHTML(contents.substring(i, contents.length()), builder);

		builder.append(FOOTER);

		return builder.toString();
	}
}

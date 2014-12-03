package io.github.simonlarsen.josep;

import jolie.runtime.JavaService;
import jolie.runtime.Value;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.ArrayList;

public class Josep extends JavaService {
	private static final String TAG_PATTERN = "\\s*\\<%\\s*([^%]*?)\\s*%\\>\\s*";
	private static final String HEADER = "include \"service_base.iol\"\ndefine operations {\n";
	private static final String FOOTER = "\tnullProcess\n}";

	private void addHTML(String text, StringBuilder builder) {
		if(text.length() == 0) return;

		builder.append("\tprintln@Page(\"");
		text = text.replaceAll("\\n", "\\\\n");
		text = text.replaceAll("\\t", "\\\\t");
		text = text.replaceAll("\"", "\\\\\"");
		builder.append(text);
		builder.append("\t\")();\n");
	}

	public String compile(Value request) {
		ArrayList<String> includes = new ArrayList<String>();

		String contents = request.strValue();
		StringBuilder output = new StringBuilder();
		StringBuilder code = new StringBuilder();

		Pattern pattern = Pattern.compile(TAG_PATTERN);
		Matcher matcher = pattern.matcher(contents);

		// Parse <% ... %> blocks
		int i = 0;
		while(matcher.find()) {
			String block = matcher.group(1);
			addHTML(contents.substring(i, matcher.start()), code);

			// Include statement
			if(block.startsWith("@include")) {
				String[] parts = block.split("\"");
				includes.add(parts[1]);
			}
			// Regular code segment
			else {
				code.append(block);
				code.append("\n");
			}
			i = matcher.end();
		}
		addHTML(contents.substring(i, contents.length()), code);

		// Assemble service
		for(String include : includes) {
			output.append(String.format("include \"%s\"\n", include));
		}
		output.append(HEADER);
		output.append(code.toString());
		output.append(FOOTER);

		return output.toString();
	}
}

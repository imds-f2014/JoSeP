<!DOCTYPE html>
<html>
	<head></head>
	<body>
		<%
			@include "template.iol"

			template = "<h1>${title}</h1>${content}";
			if(request.id == 1) {
				template.title = "Post title";
				template.content = "<p>This is the contents of the page.</p>"
			} else {
				template.title = "Another title";
				template.content = "<p>This is some other stuff.</p>"
			};
			compile@Template(template)(post);
			@print post;
		%>
	</body>
</html>

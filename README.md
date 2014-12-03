JoSeP
=====

Jolie server pages

## Example ##

```html
<% @include "time.iol" %>
<!DOCTYPE html>
<html>
	<head></head>
	<body>
		<%
			getCurrentDateTime@Time()(datetime);
			println@Page("<p>Current time: " + datetime + "</p>")();
		%>
	</body>
</html>
```

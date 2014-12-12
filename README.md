JoSeP
=====

Jolie server pages

## Example ##

```html
<%
	@include "time.iol"
%>
<!DOCTYPE html>
<html>
	<head></head>
	<body>
		<%
			getCurrentDateTime@Time()(datetime);
			@print <p>Current time: " + datetime + "</p>";
		%>
	</body>
</html>
```

<% @include "time.iol" %>

<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="style.css" />
	</head>
	<body>
		<%
			getCurrentDateTime@Time()(datetime);
			document += "<p>Current time: " + datetime + "</p>\n";
			document += "<p>x = " + request.x + "</p>\n";
		%>
	</body>
</html>

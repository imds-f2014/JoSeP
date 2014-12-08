<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="style.css" />
	</head>
	<body>
		<%
			@include "time.iol"
			getCurrentDateTime@Time()(datetime);
			@print "<p>Current time: " + datetime + "</p>\n";
			@print "<p>x = " + request.x + "</p>\n";
		%>
	</body>
</html>

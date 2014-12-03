<% @include "time.iol" %>

<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="style.css" />
	</head>
	<body>
		<%
			getCurrentDateTime@Time()(datetime);
			println@Page("<p>Current time: " + datetime + "</p>")();
		%>
	</body>
</html>

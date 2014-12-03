<!DOCTYPE html>
<html>
	<head>
	</head>
	<body>
		<?jolie 
			println@Page("<h1>Heading</h1>")();
		?>
		<p>This is static.</p>
		<?jolie
			println@Page("<p>Hello, World!")();
		?>
	</body>
</html>

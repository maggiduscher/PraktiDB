<?php
	if(isset($_POST['submit']))
	{
		checkLogin($_POST['username'],$_POST['password'])
	}
?>
<html>
	<head>
		<title></title>
	</head>
	<body>
	<h1>Login</h1>
		<div id="content">
			<form method="POST" action=<?php echo $_SERVER['PHP_SELF'];?> id="login_form">
				<label>Benutzername: </label>
				<input id="username" placeholder="Benutzername / Email" name="username" type="text"/><br/>
				<label>Passwort: </label>
				<input id="password" placeholder="Passwort" name="password" type="text"/><br/>
				<input id="submit" name="submit" type="submit" value="Log mich hart rein!"/>
			</form>
		</div>
	</body>
</html>
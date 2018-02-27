<?php
	include_once "login_utils.php";
	include_once "../utils/site_utils.php";
        
	session_start();
        logout();
        

	
?>
<html>
    <?php            
        CreateHead("Login");
    ?>
    <body>
        <?php
            CreateNav();
            if(isset($_GET['nosession']))
            {
                CreateError("Es gab einen Fehler mit deiner Session. Bitte logge dich erneut ein.");
            }

            if(isset($_GET['nologin']))
            {
               CreateWarning("Bitte logge dich ein.");
            }
            if(isset($_POST['submit']))
            {
                checkLogin($_POST['username'],$_POST['password']);

            }
            if(isset($_SESSION['id']))
            {
                header("Location: ../overview/");
            }
        ?>
        <div id="content">
            <h1>Login</h1>
            <h2>Bitte logge dich mit deinem PraktiDB Konto ein!</h2>
            <div id="login_form">
                <form method="POST" action=<?php echo $_SERVER['PHP_SELF'];?>>
                    <label>Benutzername: </label>
                    <input id="username" placeholder="Benutzername / Email" name="username" type="text"/><br/>
                    <label>Passwort: </label>
                    <input id="password" placeholder="Passwort" name="password" type="password"/><br/>
                    <input id="submit" name="submit" type="submit" value="Log mich hart rein!"/>
                </form>
            </div>
            <br/>
            <div id="small">
                <a href="../regis/">Du hast noch kein PraktiDB Konto? Jetzt Registrieren!</a>
            </div>
        </div>
		<?php
			CreateFooter();
		?>
    </body>
</html>
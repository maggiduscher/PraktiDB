<?php
	include_once "login_utils.php";
	include_once "../utils/site_utils.php";
        
	session_start(['gc_maxlifetime'=>0]);
        logout();

?>
<html>
    <?php            
        	echo "</head>";
			CreateHead("Login"); 
			echo "</head>";
    ?>
    <body>
        <?php
            if(isset($_GET['nosession']))
            {
                echo "<div id='error_box'>Es gab einen Fehler mit deiner Session. Bitte logge dich erneut ein.</div>";
            }

            if(isset($_GET['nologin']))
            {
                echo "<div id='warning_box'>Bitte logge dich ein.</div>";
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
        <div id="main">
            <h1>Login</h1>
            <h2>Bitte logge dich mit deinem PraktiDB Konto ein!</h2>
            <div id="login_form">
                <form method="POST" action=<?php echo $_SERVER['PHP_SELF'];?>>
                    <div id="Benutzername">
						<label>Benutzername: </label>
						<input id="username" placeholder="Benutzername / Email" name="username" type="text"/><br/>
                    </div>
					<div id="Passwort">
						<label>Passwort: </label>
						<input id="password" placeholder="Passwort" name="password" type="password"/><br/>
					</div>

					<div id="submit">
						<label> </label>
						<input id="submit" name="submit" type="submit" value="Einloggen"/>
					</div>
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
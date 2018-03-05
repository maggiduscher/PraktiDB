<?php
    include_once "../utils/database.php";

    function checkLogin($username,$password)
    {
        $username = trim($username);
        $password = trim($password);
        if($username != "" && $password != "")
        {
            $sqlresult = databaseQuery("CALL CheckUser('".$username."','".hash("sha256",$password)."')");
            if($sqlresult == null)
            {
                CreateError("Dein Benutzername/Email oder Passwort ist falsch. Bitte versuche es erneut.");
            }else
            {
                logout();
                session_start();
                $_SESSION['id']=$sqlresult->fetch_array()['biUserID'];
            }
        }
    }

    function logout()
    {
        session_unset();
        session_destroy();
        $_SESSION['id'] = null;
    }
?>


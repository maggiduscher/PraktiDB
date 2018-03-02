<?php
    include_once "../utils/database.php";

    function checkLogin($username,$password)
    {
        $username = trim($username);
        $password = trim($password);
        if($username != "" && $password != "")
        {
            $sqlresult = databaseQuery("CALL CheckUser('".$username."','".hash("sha256",$password)."')");
            if($sqlresult == null || $sqlresult->num_rows == 0)
            {
                CreateError("Dein Benutzername/Email oder Passwort ist flasch. Bitte versuche es erneut.");
            }else
            {
                logout();
                session_start();
                $output = $sqlresult->fetch_array();
                $_SESSION['id']=$output['biUserID'];
                $_SESSION['role']=$output['vaUserRole'];
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

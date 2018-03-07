<?php
    include_once "../utils/database.php";

    function checkLogin($username,$password)
    {
        $username = trim($username);
        $password = trim($password);
        if($username != "" && $password != "")
        {
			$Data = array();
			$Data[] = $username;
			$Data[] = hash("sha256",$password);
			
			
            $sqlresult = databaseStoredProcedure('Call CheckUser(?,?)',$Data);
            if($sqlresult == null)
            {
                CreateError("Dein Benutzername/Email oder Passwort ist falsch. Bitte versuche es erneut.");
            }else
            {
                logout();
                session_start();
                
                $_SESSION['id']=$sqlresult['biUserID'];
                $_SESSION['role']=$sqlresult['vaUserRole'];
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

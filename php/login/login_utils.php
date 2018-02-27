<<<<<<< HEAD
<?php
    include_once "../utils/database.php";

    function checkLogin($username,$password)
    {
        $username = trim($username);
        $password = trim($password);
        if($username != "" && $password != "")
        {
            $sqlresult = databaseQuery("CALL CheckUser('".$username."','".hash("sha256",$password)."')");
            if($sqlresult === false || $sqlresult->num_rows == 0)
            {
                CreateError("Dein Benutzername/Email oder Passwort ist flasch. Bitte versuche es erneut.");
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

=======
<?php
    include_once "../utils/database.php";

    function checkLogin($username,$password)
    {
        $username = trim($username);
        $password = trim($password);
        if($username != "" && $password != "")
        {
            $connection = databaseConnect();
            $sqlcommand = "SELECT biUserId FROM tbUser WHERE (vaUsername = '".$username."' AND vaPasswort = '".hash("sha256",$password)."') OR (vaEmail = '".$username."' AND vaPasswort = '".hash("sha256",$password)."');";
            $sqlresult = $connection->query($sqlcommand);
            if($sqlresult === false || $sqlresult->num_rows == 0)
            {
                die('Ungültige Anfrage: ' . $connection->error);
            }else
            {
                session_start();
                $_SESSION['id']=$sqlresult->fetch_array()['biUserId'];
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

>>>>>>> refs/remotes/origin/master

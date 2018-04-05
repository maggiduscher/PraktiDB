
<?php
    include_once "../utils/database.php";
    function checkLogin($username,$password)
    {
        $username = trim($username);
        $password = trim($password);
        if($username != "" && $password != "")
        { 
	       
			
            $sqlresult = databaseQuery("CALL CheckUser(?,?)",$username,hash("sha256",$password));
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

<?
      
   function databaseQuery($query,$strUsername,$strPassword )
    {
        $connection = databaseConnect();
		$stmt = mysqli_stmt_init($connection);
        $sqlcommand = $query;
		if(!mysqli_stmt_prepare($stmt,$query))echo 'SQL FEHLER ';
		else{
			 mysqli_stmt_bind_param($stmt,"ss",$strUsername,$strPassword);
             mysqli_stmt_execute($stmt);	
		    $sqlresult = mysqli_stmt_get_result($stmt);
		}
        if($sqlresult === false || $sqlresult->num_rows == 0)
        {
            CreateError("Fehlerhafte SQL Anfrage: ".$connection->error.".");
        }else
        {
            return $sqlresult;
        }
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



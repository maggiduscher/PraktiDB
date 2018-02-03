<?php
	include_once "../utils/database.php";
	
	function checkLogin($username,$password)
	{
		$username = trim($username);
		$password = trim($password);
		if($username != "" && $password != "")
		{
			$connection = databaseConnect();
			$sqlcommand = "SELECT biUserId FROM tbUser WHERE vaUsername = ".$username." AND vaPassword = ".hash("sha256",$password).";";
			$sqlresult = $connection->query($sqlcommand);
			if($sqlresult === false)
			{
				echo "NOPE!.avi";
				return null;
			}else
			{
				session_start();
				$_SESSION['id']=$sqlresult->fetch_array()['biUserId'];
			}
		}
		
	}
	
?>


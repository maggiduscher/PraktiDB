<?php
	include_once "../utils/database.php";
	
	function checkLogin($username,$password)
	{
		$username = trim($username);
		$password = trim($password);
		if($username != "" && $password != "")
		{
			$connection = databaseConnect();
		}
		
		
		
	}
	
?>


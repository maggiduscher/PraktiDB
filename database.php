<?php
	
	function databaseConnect(){
		
		$db = new mysqli("maggiduscher.site", "DBUser", "DBPass", "DBName");
		
		if(mysqli_connect_error()){
			
			return "Connection Error: (".mysqli_connect_errno().") ".mysqli_connect_error();
			
		}else return $db;
	}
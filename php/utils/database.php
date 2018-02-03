<?php
	
	function databaseConnect(){
		
		$db = new mysqli("localhost", "root", "", "PraktiDB");
		
		if(mysqli_connect_error()){
			
			return "Connection Error: (".mysqli_connect_errno().") ".mysqli_connect_error();
			
		}else return $db;
	}
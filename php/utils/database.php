<?php
	
    function databaseConnect(){

            $db = new mysqli("localhost", "root", "", "PraktiDB");

            if(mysqli_connect_error()){

                    return "Connection Error: (".mysqli_connect_errno().") ".mysqli_connect_error();

            }else return $db;
    }
    
    function databaseQuery($query, $mute = false)
    {
        $connection = databaseConnect();
        $sqlresult = $connection->query($query);
        if($sqlresult === false)
        {
            if(!$mute) { CreateError("Fehlerhafte SQL Anfrage: ".$connection->error."."); }
            
            return null;
        }else
        {
            return $sqlresult;
        }
    }
    
    function databasePreparedStatement($StoredProcedure,$Data,$mute = false)
    {
	$servername = "localhost";
        $username = "root";
        $password = "";
        $databasename = "PraktiDB";
		
        $connection = @mysqli_connect($severname,$username,$password,$databasename)
		Or die("Nope ".mysql_error());

		$stmt = mysqli_stmt_init($connection);
	
	  if(!mysqli_stmt_prepare($stmt,$StoredProcedure))echo 'SQL FEHLER ';
	  else
	  {
		switch(sizeof($Data)){
			case 0:
			
			break;
			
			case 1:
			mysqli_stmt_bind_param($stmt,"s",$Data[0]);
			break;
			
			case 2:
			mysqli_stmt_bind_param($stmt,"ss",$Data[0],$Data[1]);
			break;
			
			case 3:
			mysqli_stmt_bind_param($stmt,"sss",$Data[0],$Data[1],$Data[2]);
			break;
			
			case 4:
			mysqli_stmt_bind_param($stmt,"ssss",$Data[0],$Data[1],$Data[2],$Data[3]);
			break;
			
			case 5:
			mysqli_stmt_bind_param($stmt,"sssss",$Data[0],$Data[1],$Data[2],$Data[3],$Data[4]);
			break;
			
			case 6:
			mysqli_stmt_bind_param($stmt,"ssssss",$Data[0],$Data[1],$Data[2],$Data[3],$Data[4],$Data[5]);
			break;
			
			case 7:
			mysqli_stmt_bind_param($stmt,"sssssss",$Data[0],$Data[1],$Data[2],$Data[3],$Data[4],$Data[5],$Data[6]);
			break;
			
			case 8:
			mysqli_stmt_bind_param($stmt,"ssssssss",$Data[0],$Data[1],$Data[2],$Data[3],$Data[4],$Data[5],$Data[6],$Data[7]);
			break;
			
			case 9:
			mysqli_stmt_bind_param($stmt,"sssssssss",$Data[0],$Data[1],$Data[2],$Data[3],$Data[4],$Data[5],$Data[6],$Data[7],$Data[8]);
			break;
			
			case 10:
			mysqli_stmt_bind_param($stmt,"ssssssssss",$Data[0],$Data[1],$Data[2],$Data[3],$Data[4],$Data[5],$Data[6],$Data[7],$Data[8],$Data[9]);
			break;
			
		}
		mysqli_stmt_execute($stmt);	
		$result = mysqli_stmt_get_result($stmt);	
        return $result;		
		/*
		$result = mysqli_stmt_get_result($stmt);	
		if($result === false)
        {
            if(!$mute) { CreateError("Fehlerhafte SQL Anfrage: ".$connection->error."."); }
            
            return null;
        }else
        {
            return $result;
        }
		*/
	  }
	}
?>
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
        echo "<br/>";
        echo "<br/>";
        if($sqlresult === false)
        {
            if(!$mute) { CreateError("Fehlerhafte SQL Anfrage: ".$connection->error."."); }
            
            return null;
        }else
        {
            return $sqlresult;
        }
    }
	
	function databaseStoredProcedure($StoredProcedure,$Data,$mute = false)
    {
        $connection = databaseConnect();
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
			
		}
		mysqli_stmt_execute($stmt);		
		$result = mysqli_stmt_get_result($stmt);
		$row = mysqli_fetch_array($result);		
		
		if($row === false)
        {
            if(!$mute) { CreateError("Fehlerhafte SQL Anfrage: ".$connection->error."."); }
            
            return null;
        }else
        {
            return $row;
        }
	  }
		      
    }
?>
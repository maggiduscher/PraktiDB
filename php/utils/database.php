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
        var_dump($query);
        echo "<br/>";
        var_dump($sqlresult);
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
?>
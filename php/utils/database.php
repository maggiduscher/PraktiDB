<?php
	
    function databaseConnect(){

            $db = new mysqli("localhost", "root", "", "PraktiDB");

            if(mysqli_connect_error()){

                    return "Connection Error: (".mysqli_connect_errno().") ".mysqli_connect_error();

            }else return $db;
    }
    
    function databaseQuery($query)
    {
        $connection = databaseConnect();
        $sqlcommand = $query;
        $sqlresult = $connection->query($sqlcommand);
        if($sqlresult === false || $sqlresult->num_rows == 0)
        {
            CreateError("Fehlerhafte SQL Anfrage: ".$connection->error.".");
        }else
        {
            return $sqlresult;
        }
    }
?>
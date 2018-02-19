<?php
    
    include_once("../../utils/database.php");

    function GetUsernameOf($id)
    {
        $connection = databaseConnect();
        $sqlcommand = "SELECT vaUsername FROM tbUser WHERE biUserID = ".$id.";";
        $sqlresult = $connection->query($sqlcommand);
        if($sqlresult === false || $sqlresult->num_rows == 0)
        {
            die('Ungültige Anfrage: ' . $connection->error);
        }else
        {
            $output = $sqlresult->fetch_array();
            return $output['vaUsername'];
        }
    }
    
    function GetUserData($id)
    {
        $connection = databaseConnect();
        $sqlcommand = "SELECT * FROM tbUser JOIN tbOrt USING (vaPLZ) WHERE biUserID = ".$id.";";
        $sqlresult = $connection->query($sqlcommand);
        if($sqlresult === false || $sqlresult->num_rows == 0)
        {
            die('Ungültige Anfrage: ' . $connection->error);
        }else
        {
            $output = $sqlresult->fetch_array();
            return $output;
        }
    }
    
    
    
    
?>
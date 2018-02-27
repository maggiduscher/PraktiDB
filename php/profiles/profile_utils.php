<?php
    
    include_once("../../utils/database.php");
    
    function GetUserData($id)
    {
        $sqlresult = databaseQuery("CALL GetUser(".$id.")");
        $output = $sqlresult->fetch_array();
        return $output;
    }
    
    function GetCompanyData($id)
    {
        $sqlresult = databaseQuery("CALL GetUnternehmen(".$id.")");
        $output = $sqlresult->fetch_array();
        return $output;
    }
?>
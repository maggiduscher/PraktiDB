<?php
    
    include_once("../../utils/database.php");
    
    function GetUserData($id)
    {
        $sqlresult = databaseQuery("CALL GetUser(".$id.")");
		
		if($sqlresult !== false || $sqlresult->num_rows != 0){
			
            $output = $sqlresult->fetch_array();
            switch ($output['vaUserRole']){
				
				case 'student':
					$output['vaUserRole'] = "Sch&uuml;ler";
					break;
				case 'admin':
					$output['vaUserRole'] = "Administrator";
					break;
				case 'company':
					$output['vaUserRole'] = "Praktikumsbetrieb";
					break;
				case 'teacher':
					$output['vaUserRole'] = "Lehrer";
					break;
				default:
					break;
			}
        return $output;
		}
	}
    
    function GetCompanyData($id)
    {
        $sqlresult = databaseQuery("CALL GetUnternehmen(".$id.")");
        $output = $sqlresult->fetch_array();
        return $output;
    }
?>
<?php
    
    include_once("../../utils/database.php");
    
    function GetUserData($id)
    {
        $sqlresult = databaseQuery("CALL GetUser(".$id.")");
        if($sqlresult != null || $sqlresult->num_rows != 0)
        {	
            $output = $sqlresult->fetch_array();
            switch ($output['vaUserRole'])
            {		
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
    
    function GetRatingFromUser($userid,$companyid)
    {
        $sqlresult = databaseQuery("CALL GetBewertung(".$userid.", ".$companyid.")");
        if ($sqlresult === null)
        {
            return null;
        }else
        {
            $output = $sqlresult->fetch_array();
            return $output;
        }
        
    }
    
    function GetAllRatingsFromCompany($companyid)
    {
        $sqlresult = databaseQuery("CALL GetBewertungenUnternehmen (".$companyid.")");
        if ($sqlresult === null)
        {
            return null;
        }else
        {
            $output = $sqlresult->fetch_all(MYSQLI_ASSOC);
            return $output;
        }
        
    }
    
    function GetLastApplication($userid)
    {
        $sqlresult = databaseQuery("CALL GetLetzteBewerbung(".$userid.")");
        if ($sqlresult === null)
        {
            return null;
        }else
        {
            $array = $sqlresult->fetch_array();
            $output = date_create($array['dBewerbung']);
            return $output;
        }
            
    }
?>
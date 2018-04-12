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
        if ($sqlresult === false)
        {
            return null;
        }else
        {
            $array = $sqlresult->fetch_array();
            if($array != null && $array['MAX(dBewerbung)'] != null)
            {
                $output = date_create($array['MAX(dBewerbung)']);
                return $output;
            }else 
                return null;
        }
            
    }
    
    function GenerateGoogleMap($origin, $dest) {
        echo "<div id='map'></div>"
                ."<script>"  
                  ."function initMap() {"
                    // Map Objekt erstllen
                    ."var map = new google.maps.Map(document.getElementById('map'), {"
                        ."zoom: 7"
                    ."});"
                    
                    ."var directionsDisplay = new google.maps.DirectionsRenderer({"
                        ."map: map"
                    ."});"

                      // Start, Ziel und Reiseart setzen
                    ."var request = {"
                        ."destination: '".$dest."',"
                        ."origin: '".$origin."',"
                        ."travelMode: 'DRIVING'"
                    ."};"

                      // Anfrage an die directionsService senden
                    ."var directionsService = new google.maps.DirectionsService();"
                    ."directionsService.route(request, function(response, status) {"
                        ."if (status == 'OK') {"
                            // Die Route auf der Map anzeigen
                            ."directionsDisplay.setDirections(response);"
                        ."}"
                    ."});"
                  ."}"
                ."</script>";
                $handle = fopen("../../../APIkey.txt", "r");
                if ($handle) 
                {
                    while (($line = fgets($handle)) !== false) 
                    {
                        $key = $line;
                    }
                    fclose($handle);
                } else 
                {
                    echo "Can't get GoogleAPIKey from server!";
                }
                echo "<script src='https://maps.googleapis.com/maps/api/js?key=".$key."&callback=initMap'"
                    ."async defer></script>";
    }
    
    function GetAddressFromUser($id)
    {
        $sqlresult = databaseQuery("CALL GetUser(".$id.");");
        if($sqlresult != null)
        {
            $row = $sqlresult->fetch_array();
            $output = $row['vaAdresse']." ".$row['vaPLZ']." ".$row['vaStadt'];
            $output = str_replace(' ', '+', $output);
            return $output;
        }else
            return null;
    }
?>
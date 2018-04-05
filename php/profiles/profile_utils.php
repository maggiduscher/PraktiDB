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
    
    function GenerateGoogleMap($origin, $dest) {
        echo "<div id='map'></div>"
                ."<script>"  
                  ."function initMap() {"
                    // Create a map object and specify the DOM element for display.
                    ."var map = new google.maps.Map(document.getElementById('map'), {"
                        ."zoom: 7"
                    ."});"
                    
                    ."var directionsDisplay = new google.maps.DirectionsRenderer({"
                        ."map: map"
                    ."});"

                      // Set destination, origin and travel mode.
                    ."var request = {"
                        ."destination: '".$dest."',"
                        ."origin: '".$origin."',"
                        ."travelMode: 'DRIVING'"
                    ."};"

                      // Pass the directions request to the directions service.
                    ."var directionsService = new google.maps.DirectionsService();"
                    ."directionsService.route(request, function(response, status) {"
                        ."if (status == 'OK') {"
                            // Display the route on the map.
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
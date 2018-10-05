<?php
    function GetDistanceFromGoogleAPI($origin,$dest)
    {
        $handle = fopen("../../APIkey.txt", "r");
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
        $origin = str_replace(' ', '+', $origin);
        $dest = str_replace(' ', '+', $dest);
        $url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=".$origin."&destinations=".$dest."&key=".$key;
        $arrContextOptions=array(
                "ssl"=>array(
                "verify_peer"=>false,
                "verify_peer_name"=>false,
                ),
            ); 
        $json = file_get_contents($url, false, stream_context_create($arrContextOptions));
        $jsonarray = json_decode($json);
        $status = $jsonarray->rows[0]->elements[0]->status;
        if($status == "OK") 
        {
            $distance = $jsonarray->rows[0]->elements[0]->distance->text;
            return $distance;
        }else
        {
            return "N/A";
        }
    }
    
    function GetAddressFromUser($id)
    {
        $sqlresult = databaseQuery("CALL GetUser(".$id.");");
        if($sqlresult != null)
        {
            $row = $sqlresult->fetch_array();
            $output = $row['vaAdresse']." ".$row['vaPLZ']." ".$row['vaStadt'];
            return $output;
        }else
            return null;
    }
        
?>
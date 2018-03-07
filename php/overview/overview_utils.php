<?php
    function GetDistanceFromGoogleAPI($origin,$dest)
    {
        
        $origin = str_replace(' ', '+', $origin);
        $dest = str_replace(' ', '+', $dest);
        $url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=".$origin."&destinations=".$dest."&key=AIzaSyA6ZN48baQWt7Rs9RZAOaXxKrLrdqY5gl0";
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        $json = curl_exec($ch);
        curl_close($ch);
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
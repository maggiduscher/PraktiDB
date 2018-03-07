<?php
    function GetDistanceFromGoogleAPI($origin,$dest)
    {
        str_replace(' ', '+', $origin);
        str_replace(' ', '+', $dest);
        $url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=".$origin."&destinations=".$dest."&key=AIzaSyA6ZN48baQWt7Rs9RZAOaXxKrLrdqY5gl0";
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        $json = curl_exec($ch);
        curl_close($ch);
        $json = file_get_contents($url);
        $jsonarray = json_decode($json);
        $status = $jsonarray->rows[0]->elements[0]->status;
        iF($status == "OK") 
        {
            $distance = $jsonarray->rows[0]->elements[0]->distance->text;
            return $distance;
        }
    }
?>
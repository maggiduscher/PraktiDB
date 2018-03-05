<?php

    function CreateHead($name)
    {
        echo "<title> PraktiDB - ".$name." </title>";
        echo "<link rel=\"stylesheet\" href=\"/PraktiDB/css/main.css\" />";
		echo "<link href=\"https://fonts.googleapis.com/css?family=Lato\" rel=\"stylesheet\" />"; 
		if(strpos($name, "Profil") === false)echo "<link rel=\"stylesheet\" href=\"/PraktiDB/css/".$name.".css\" />"; 
    }

    function CreateNav()
    {

		echo "<div id=\"nav\">"
				."<div id=\"nav-item\"> <a href=\"#\">Starseite </a> </div>"
				."<div id=\"nav-item\"> <a href=\"#\">Placeholder1 </a> </div>"
				."<div id=\"nav-item\"> <a href=\"#\">Placeholder2 </a> </div>"
				."<div id=\"nav-item\"> <a href=\"#\">Placeholder3 </a> </div>"
				."<div id=\"nav-item\"> <a href=\"#\">Placeholder4 </a> </div>"
			."</div>\n";


    }

    function CreateFooter()
    {



    }

    function IsLoggedIn($path = "")
    {
        session_start();
        if(!isset($_COOKIE["PHPSESSID"])){

            Header("Location: ".$path."../login/index.php?nosession");

        }
        if(!isset($_SESSION['id']))
        {
            Header("Location: ".$path."../login/index.php?nologin");
        }

    }
    
    function CreateError($msg)
    {
        echo "<div id='error_box'>".$msg."</div>";
    }
    
    function CreateWarning($msg)
    {
        echo "<div id='warning_box'>.$msg.</div>";
    }
?>
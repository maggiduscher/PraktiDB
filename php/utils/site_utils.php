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
				."<div id=\"nav-item\"> <a href=\"/PraktiDB/php/overview/\">Starseite </a> </div>"
				."<div id=\"nav-item\"> <a href=\"/PraktiDB/php/profiles/user/?id=".$_SESSION['id']."\">Profil </a> </div>"
				."<div id=\"nav-item\"> <a href=\"#\">Placeholder2 </a> </div>"
				."<div id=\"nav-item\"> <a href=\"#\">Placeholder3 </a> </div>"
				."<div id=\"nav-item\"> <a href=\"/PraktiDB/php/login/\">Logout </a> </div>"
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
    
    function AllowedRolesOnly($roles)
    {
        $allowed = false;
        foreach ($roles as $role)
        {
            if($_SESSION['role']==$role)
            {
                $allowed = true;
                break;
            }
        }
        if($allowed === false)
        {
            CreateError("Du nix Zugriff opfa!");
            die();
        }
    }
    
    function IsRole($role)
    {
        if($_SESSION['role']== $role)
        {
            return true;
        }else
        {
            return false;
        }
    }


    function CreateError($msg)
    {
        echo "<div id='error_box'>".$msg."</div>";
    }
    
    function CreateWarning($msg)
    {
        echo "<div id='warning_box'>".$msg."</div>";
    }
?>
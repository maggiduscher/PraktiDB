<?php

    function CreateHead($name)
    {
        echo "\t<head>\n";
        echo "\t\t<title> PraktiDB - ".$name." </title>\n";
        echo "\t\t<link rel=\"stylesheet\" href=\"CSSPath\">\n";
        echo "\t</head>\n";
    }

    function CreateNav()
    {



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
    
    function IsRole($role)
    {
        if($_SESSION['role']!=$role)
        {
            CreateError("Du nix Zugriff opfa!");
            die();
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
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

    function IsLoggedIn()
    {
        session_start();
        if(!isset($_COOKIE["PHPSESSID"])){

            Header("Location: ../login/login.php?nosession");

        }
        if(!isset($_SESSION['id']))
        {
            Header("Location: ../login/login.php?nologin");
        }

    }
	
	

?>
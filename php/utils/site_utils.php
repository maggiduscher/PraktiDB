<?php

    function CreateHead($name)
    {
        echo "<meta charset='UTF-8'>";
        echo "<title> PraktiDB - ".$name." </title>";
        echo "<link rel=\"stylesheet\" href=\"/PraktiDB/css/main.css\" />";
        echo "<link rel=\"stylesheet\" href=\"/PraktiDB/css/print.css\" media=\"print\"/>";
        echo "<link rel=\"shortcut icon\" type=\"image/x-icon\" href=\"/PraktiDB/favicon.ico\">";
		echo "<link href=\"https://fonts.googleapis.com/css?family=Lato\" rel=\"stylesheet\" />"; 
		if(strpos($name, "Profil") === false && strpos($name, "Admin") === false)echo "<link rel=\"stylesheet\" href=\"/PraktiDB/css/".$name.".css\" />";
		if(strpos($name, "Admin") !== false && strpos($name, "Profil") === false) echo "<link rel=\"stylesheet\" href=\"/PraktiDB/css/Admin.css\" />"; 		
    }

    function CreateNav()
    {

		echo "<div id=\"nav\">"
				."<a href=\"/PraktiDB/php/overview/\">Startseite </a>"
				."<a href=\"/PraktiDB/php/profiles/user/?id=".$_SESSION['id']."\">Profil </a>";
                                if(IsRole('admin')|| IsRole('teacher'))
                                {
                                    echo "<a href=\"/PraktiDB/php/adminTool/\">Kontrollzentrum </a>";
                                }
				echo "<a href=\"/PraktiDB/php/login/\">Logout </a>"
                                
			."</div>\n";


    }

    function CreateFooter()
    {



    }

    function IsLoggedIn($path = "") //Überprüfen ob der Benutzer einggeloggt. Wenn nicht sende ihn zurück zum Login.
    {
        session_start(['gc_maxlifetime'=>0]);
        if(!isset($_COOKIE["PHPSESSID"])){

            Header("Location: ".$path."../login/index.php?nosession");

        }
        if(!isset($_SESSION['id']))
        {
            Header("Location: ".$path."../login/index.php?nologin");
        }

    }
    
    function AllowedRolesOnly($roles) //Überprüfe ob der Benutzer eine der erlaubten Rollen hat. Wenn nicht verweigere Zugriff.
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
            CreateError("Sie haben keine Zugriffsrechte auf diese Seite!");
            die();
        }
    }
    
    function IsRole($role) //Überprüfe ob der Benutzer die angegeben Rolle hat.
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

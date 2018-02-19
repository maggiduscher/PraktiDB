<?php
	include_once "../profile_utils.php";
	include_once "../../utils/site_utils.php";
	IsLoggedIn("../");
        $userdata = array();
        $userdata = GetUserData($_GET['id']);
        //$userort = GetUserOrt($userdata['vaPLZ']);
        var_dump($userdata);
	
?>
<html>
    <?php            
        CreateHead("Profil von ".$userdata['vaUsername']);
    ?>
    <body>
        <?php
            CreateNav();
            $alter = date_diff(date_create(date("Y-m-d")),date_create($userdata['dGeburtsjahr']));
            echo "<h1>Profil von ".$userdata['vaUsername']."</h1>"
                . "<div id='content'>"
                . "<div id='profile_data'>"
                . "<div id='profile_pic'><img src='pics/".$userdata['biUserID'].".png' alt='Profilbild'/></div>"
                . "Name: ".$userdata['vaVorname']." ".$userdata['vaNachname']."<br/>"
                . "Alter: ".$alter->format('%y')."<br/>"
                . "Adresse: <br/>".$userdata['vaAdresse']."<br/>".$userdata['vaPLZ']." ".$userdata['vaStadt']."<br/>"
                . "E-Mail: ".$userdata['vaEmail']."<br/>"
                . "Klasse: ".$userdata['vaKlasse']."<br/>"
                .$userdata['vaUserRole']
                . "</div>"
                . "</div>";
        ?>
        <?php
                CreateFooter();
        ?>
    </body>
</html>
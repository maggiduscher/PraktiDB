<?php
	include_once "../profile_utils.php";
	include_once "../../utils/site_utils.php";
	IsLoggedIn("../");
        $userdata = array();
        $userdata = GetUserData($_GET['id']);
        //$userort = GetUserOrt($userdata['vaPLZ']);
	
?>
<html>
    <?php            
        echo "</head>";
		CreateHead("Profil von ".$userdata['vaUsername']."");
		echo "<link rel=\"stylesheet\" href=\"/PraktiDB/css/profile.css\" />";
		echo "</head>";
		
		
    ?>
    <body>
        <?php
            CreateNav();
            $alter = date_diff(date_create(date("Y-m-d")),date_create($userdata['dGeburtsjahr']));
            echo "<div id='main'>"
					. "<h1>Profil von ".$userdata['vaUsername']."</h1>"
					. "<div id='profile'>"
						. "<div id='profile_pic'><img src='/PraktiDB/img/".$userdata['biUserID'].".png' alt='Profilbild'/></div>"
						. "<div id='profile_row'>"
							. "<div id='profile_data'> Name: </div><div id='profile_data'>".ucwords($userdata['vaVorname'], "-")." ".ucfirst($userdata['vaNachname'])."<br/>"
							. $userdata['vaUserRole']."</div>"
						. "</div>"
						. "<div id='profile_row'>"
							. "<div id='profile_data'> Alter: </div><div id='profile_data'>".$alter->format('%y')." </div> <br/>"
						. "</div>"
						. "<div id='profile_row'>"
							. "<div id='profile_data'> Adresse: </div><div id='profile_data'>".ucwords($userdata['vaAdresse'])."<br/>".$userdata['vaPLZ']." ".$userdata['vaStadt']."</div> <br/>"
						. "</div>"
						. "<div id='profile_row'>"
							. "<div id='profile_data'> E-Mail: </div><div id='profile_data'>".$userdata['vaEmail']."</div> <br/>"
						. "</div>"
						. "<div id='profile_row'>"
							. "<div id='profile_data'> Klasse: </div><div id='profile_data'>".strtoupper($userdata['vaKlasse'])."</div> <br/>"
						. "</div>"
						. "<div id='profile_row'>"
							. "<div id='profile_data'> &Uuml;ber mich: </div><div id='profile_data'>".strtoupper($userdata['tText'])."</div> <br/>"
						. "</div>"
					. "</div>"
                . "</div>";
        ?>
        <?php
                CreateFooter();
        ?>
    </body>
</html>
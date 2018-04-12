<?php
	include_once "../profile_utils.php";
	include_once "../../utils/site_utils.php";
	include_once "../../utils/database.php";
	IsLoggedIn("../");
        $userdata = array();	
        if(isset($_POST['submit']) && isset($_POST['profile_info']))
        {
           if(preg_match('/[<>]/',$_POST['profile_info']) != 0){CreateError( "Bitte Gültigen Text eingeben");}
           else
           {
              $SQLQuery = "Call UpdateText(".$_GET['id'].", '".$_POST['profile_info']."');";
              databaseQuery($SQLQuery);
           } 
        }
        if(isset($_POST['submit']) && isset($_FILES['upload']) && is_uploaded_file($_FILES['upload']['tmp_name']))
        {
            if (file_exists("../../../img/".$_SESSION['id'].".png")) 
            {
                unlink("../../../img/".$_SESSION['id'].".png");
            }
            $fileExtension =  strtolower(pathinfo($_FILES["upload"]["name"],PATHINFO_EXTENSION));
            if( $fileExtension != "jpg" && $fileExtension != "png" && $fileExtension != "jpeg")
            {
                CreateWarning("Es dürfen nur Bilder mit einer der folgenden Endungen hochgeladen werden: jpg, jpeg, png");
            }else
            {
                if (file_exists("../../../img/".$_SESSION['id'].".png"))
                {
                    unlink("../../../img/".$_SESSION['id'].".png");
                }
                if(!move_uploaded_file($_FILES["upload"]["tmp_name"], "../../../img/".$_SESSION['id'].".png")) CreateError("Upload fehlgeschlagen");
                $_GET['uploaded'] = true;
            } 
        }else if (isset($_POST['submit']) && isset($_FILES['upload']) && !is_uploaded_file($_FILES['upload']['tmp_name']))
        {
            $_GET['uploaded'] = false;
        }
        $userdata = GetUserData($_GET['id']);
        $letzteBewerbung = GetLastApplication($_GET['id']);
	
?>
<html>
    <?php            
        echo "</head>";
		CreateHead("Profil von ".$userdata['vaVorname']." ".$userdata["vaNachname"]."");
		echo "<link rel=\"stylesheet\" href=\"/PraktiDB/css/profile.css\" />";
		echo "</head>";
		
		
    ?>
    <body>
        <?php
		CreateNav();
            if(isset($_GET['id']))
            {
             $alter = date_diff(date_create(date("Y-m-d")),date_create($userdata['dGeburtsjahr']));
			 echo "<div id='main'>"
			. "<h1>Profil von ".$userdata['vaVorname']." ".$userdata["vaNachname"]."</h1>"
			. "<div id='profile'>"
				."<form method=\"POST\" enctype=\"multipart/form-data\">";				
				if(isset($_POST['submit']) & !isset($_GET['uploaded'])) {
					echo "<div id='profile_pic'><img class='edit' src='/PraktiDB/img/";
					if(file_exists("../../../img/".$userdata['biUserID'].".png"))echo $userdata['biUserID'];
					else echo "default";
					echo ".png' alt='Profilbild'/>"
					. "<input type='file' name='upload' id='upload'/>";
				}else{ echo "<div id='profile_pic'><img src='/PraktiDB/img/";
					if(file_exists("../../../img/".$userdata['biUserID'].".png"))echo $userdata['biUserID'];
					else echo "default";
					echo ".png' alt='Profilbild'/>";
				}
				echo "</div>"
				. "<div id='profile_row'>"
					. "<div id='profile_data'> Name: </div><div id='profile_data'>".ucwords($userdata['vaVorname'], "-")." ".ucfirst($userdata['vaNachname'])."<br/>"
					. $userdata['vaUserRole']."</div>"
				. "</div>"
				. "<div id='profile_row'>"
					. "<div id='profile_data'> Alter: </div><div id='profile_data'>".$alter->format('%y')." </div> <br/>"
				. "</div>"
				. "<div id='profile_row'>"
					. "<div id='profile_data'> Adresse: </div><div id='profile_data'>".ucwords($userdata['vaAdresse'])."<br/>".$userdata['vaPLZ']." ".utf8_decode($userdata['vaStadt'])."</div> <br/>"
				. "</div>"
				. "<div id='profile_row'>"
					. "<div id='profile_data'> E-Mail: </div><div id='profile_data'>".$userdata['vaEmail']."</div> <br/>"
				. "</div>"
				. "<div id='profile_row'>"
					. "<div id='profile_data'> Klasse: </div><div id='profile_data'>".strtoupper($userdata['vaKlasse'])."</div> <br/>"
				. "</div>";
				if(isset($_POST['submit']) && !isset($_POST['profile_info'])){
					echo "<div id='profile_row'>"
					. "<div id='profile_data' class='text'> &Uuml;ber mich: </div><textarea id='profile_data' name='profile_info'>".$userdata['tText']."</textarea> <br/>"
				. "</div>";
					$_GET['edited'] = true;
				}else{
					echo "<div id='profile_row'>"
					. "<div id='profile_data'> &Uuml;ber mich: </div><div id='profile_data'>";
                                        if($userdata['tText']!= null)
                                        {
                                            echo $userdata['tText'];
                                        }
                                        else
                                        {
                                            echo "Dieser Nutzer hat noch keine Informationen über sich hinzugefügt.";
                                        }
                                        echo "</div> <br/>"
				. "</div>";
				}
				if((isRole("teacher")|| IsRole("admin"))&&$userdata['vaUserRole']=='student'){ 
					echo "<div id='profile_row'>"
						. "<div id='profile_data'> Letzte Bewerbung: </div><div id='profile_data'>";
                                                    if($letzteBewerbung != null)
                                                    {
                                                        echo $letzteBewerbung->format('d.m.y');
                                                    }
                                                    else 
                                                    {
                                                        echo "Dieser Sch&uuml;ler hat sich noch nie bei einem Unternehmen beworben.";
                                                    }
                                                echo " </div> <br/>"
					. "</div>";
				}
				
				echo "<div id='profile_row'>";
				if($_GET['id'] == $_SESSION['id'])	echo "<div id='profile_data'> </div><div id='profile_data'> <input type='submit' name='submit' value='Ändern' /> </div> <br/>";
				echo "</div>"
				. "</form>"
			. "</div>";
            }
        ?>
        <?php
                CreateFooter();
        ?>
    </body>
</html>
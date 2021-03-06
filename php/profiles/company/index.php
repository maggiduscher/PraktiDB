<?php
	include_once "../profile_utils.php";
	include_once "../../utils/site_utils.php";
	IsLoggedIn("../");
        if(isset($_POST['bewertung']))
        {
            $sqlresult = databaseQuery("CALL AddBewertung('".$_GET['id']."', '".$_SESSION['id']."', '".$_POST['punkte']."', '".$_POST['bewertungstext']."');");
        }
        if(isset($_GET['id']))
        {
            $companydata = array();
            $companydata = GetCompanyData($_GET['id']);
            $rating = GetRatingFromUser($_SESSION['id'],$_GET['id']);   
        }
?>
<html>
    <?php            
        if(isset($_GET['id'])){CreateHead("Profil von ".$companydata['vaName']);}
        else {CreateHead("Leeres Profil");}
        echo "<link rel=\"stylesheet\" href=\"/PraktiDB/css/profile.css\" />";
    ?>
    <body>
        <?php
            CreateNav();
            if(!isset($_GET['id']) || $companydata == null ){ echo "<div id='main'>Dieses Profil existiert nicht!</div>";die;}
            if(isset($_GET['id']))
            {
                
                echo "<div id='main'>"
                    . "<h1>Profil von ".$companydata['vaName']."</h1>"
                    . "<div id='profile'>"
                    . "<div id='profile_row'>"
					. "<div id='profile_data'> Adresse: </div> <div id='profile_data'>".$companydata['vaAdresse']."<br/>".$companydata['vaPLZ']." ".utf8_decode($companydata['vaStadt'])."</div>"
                    . "</div>"
					. "<div id='profile_row'>"
					. "<div id='profile_data'>E-Mail: </div> <div id='profile_data'>".$companydata['vaEmail']."</div>"
                    . "</div>"
					. "<div id='profile_row'>"
					. "<div id='profile_data'>Tel.:</div> <div id='profile_data'>".$companydata['vaTelefonnummer']."</div>"
                    . "</div>"
					. "<div id='profile_row'>"
					. "<div id='profile_data'>Website: </div> <div id='profile_data'><a href='//".$companydata['vaWeblink']."'>".$companydata['vaWeblink']."</a></div>"
                    . "</div>"
                                        . "<div id='profile_row'>"
					. "<div id='profile_data'>Beschreibung: </div> <div id='profile_data'>".$companydata['tText']."</a></div>"
                    . "</div>"
					. "</div>"
					. "<input type='button' value='Profil ausdrucken'onClick='window.print();' id='print' /><br/><br/>"
                    . "<a href='rating.php?id=".$_GET['id']."' id='rating'>Bewertungen zu diesem Unternehmnen ansehen!</a>";
                if(IsRole('teacher') || IsRole('admin'))
                {
                    echo "<div id='rating'>";
                    if($rating === null)
                    {
                        echo "<form method='POST' action='".$_SERVER['PHP_SELF']."?id=".$_GET['id']."'>"
                            . "<label for='punkte'> Punkte: <span id=punkteAnz>50</span> </label><br/>"
                            . "<input type='range' min='0' max='100' step='1' name='punkte' id='punkte'/>"
                            . "<br/>"
                            . "<label for='bewertungstext'> Schreiben Sie Ihre Meinung hier:</label>"
                            . "<textarea name='bewertungstext' id='bewertungstext' placeholder='Bewertung' maxlength='50'></textarea>"
                            . "<br/>"
                            . "<input type='submit' name='bewertung' id='bewertung' value='Bewerten!'/>"
                            . "</form>";
                        echo "<script>"
                                . "var punkteAnz = document.getElementById('punkteAnz');"
                                . "var punkte = document.getElementById('punkte');"
                                . "punkte.addEventListener('input', function (e) {"
                                    . "punkteAnz.innerHTML = this.value;"
                                . "});"
                            . "</script>";
                    }else
                    {
                        echo "<span id='h1'>Sie haben dieses Unternehmen bewertet:</span><br/>"
                            . "<span id='h2'>Punkte: ".$rating['iPunkte']." von 100.</span><br/>"
                            . $rating['vaText']."<br/>";
                    }
                    echo "</div>";
                }
                
                GenerateGoogleMap(GetAddressFromUser($_SESSION['id']),str_replace(' ', '+',$companydata['vaAdresse']." ".$companydata['vaPLZ']." ".utf8_decode($companydata['vaStadt'])));
                echo "</div>";
            }
        ?>
        <?php
                CreateFooter();
        ?>
    </body>
</html>
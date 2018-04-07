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
        CreateHead("Profil von ".$companydata['vaName']);
    ?>
    <body>
        <?php
            CreateNav();
            if(isset($_GET['id']))
            {
                echo "<h1>Profil von ".$companydata['vaName']."</h1>"
                    . "<div id='content'>"
                    . "<div id='profile_data'>"
                    . "<div id='profile_pic'><img src='../img/pics/company/".$companydata['biUnternehmensID'].".png' alt='Profilbild'/></div>"
                    . "Adresse: <br/>".$companydata['vaAdresse']."<br/>".$companydata['vaPLZ']." ".$companydata['vaStadt']."<br/>"
                    . "E-Mail: ".$companydata['vaEmail']."<br/>"
                    . "</div>";
                if(IsRole('teacher'))
                {
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
                }
                echo "<a href='rating.php?id=".$_GET['id']."'>Bewertungen zu diesem Unternehmnen ansehen!</a>";
                GenerateGoogleMap(GetAddressFromUser($_SESSION['id']),str_replace(' ', '+',$companydata['vaAdresse']." ".$companydata['vaPLZ']." ".$companydata['vaStadt']));
                echo "</div>";
            }
        ?>
        <?php
                CreateFooter();
        ?>
    </body>
</html>
<?php
	include_once "../profile_utils.php";
	include_once "../../utils/site_utils.php";
	IsLoggedIn("../");
        if(isset($_GET['id']))
        {
            $companydata = array();
            $companydata = GetCompanyData($_GET['id']);
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
                . "</div>"
                . "</div>";
            }
        ?>
        <?php
                CreateFooter();
        ?>
    </body>
</html>
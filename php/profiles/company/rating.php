<?php
	include_once "../profile_utils.php";
	include_once "../../utils/site_utils.php";
	IsLoggedIn("../");
        if(isset($_GET['id']))
        {
            $companydata = array();
            $ratings = GetAllRatingsFromCompany($_GET['id']);
        }
        
	
?>
<html>
    <?php            
        CreateHead("Bewertugnen zu ".$ratings[0]['vaName']);
    ?>
    <body>
        <?php
            CreateNav();
            if(isset($_GET['id']))
            {
                echo "<div id='main'>"
                    . "<h1>Bewertugnen zu <a href='../company/?id=".$_GET['id']."'>".$ratings[0]['vaName']."</a></h1>"
                    . "<div id='ratings'>";
                    foreach($ratings as $rating)
                    echo "<div id='rating'>"
                        . "<span id='h1'><a href='../user/?id=".$rating['biUserID']."'>".$rating['vaUsername']."</a> hat dieses Unternehmen bewertet:</span><br/>"
                        . "<span id='h2'>Punkte: ".$rating['iPunkte']." von 100.</span><br/>"
                        . $rating['vaText']."<br/>"
                        . "</div>";
                    echo "</div>";
                    
            }
        ?>
        <?php
                CreateFooter();
        ?>
    </body>
</html>
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
        CreateHead("Bewertungen zu ".$ratings[0]['vaName']);
    ?>
    <body>
        <?php
            CreateNav();
            if(isset($_GET['id']))
            {
                echo "<div id='main'>"
                    . "<h1>Bewertungen zu <a href='../company/?id=".$_GET['id']."'>".$ratings[0]['vaName']."</a></h1>"
                    . "<div id='ratings'>";
                    if($ratings != null){
                        foreach($ratings as $rating)
                        echo "<div id='rating'>"
                            . "<span id='h1'><a href='../user/?id=".$rating['biUserID']."'>".$rating['vaUsername']."</a> hat dieses Unternehmen bewertet:</span><br/>"
                            . "<span id='h2'>Punkte: ".$rating['iPunkte']." von 100.</span><br/>"
                            . $rating['vaText']."<br/>"
                            . "</div>";
                    }else{
                        echo "Es gibt keine Bewertung für diese Firma.";
                    }
                    echo "</div>";
                    
            }
        ?>
        <?php
                CreateFooter();
        ?>
    </body>
</html>
<?php
    include_once "../utils/site_utils.php";
    include_once "../utils/database.php";
    IsLoggedIn();
    $connection = databaseConnect();
    $sqlcommand = "SELECT * FROM tbunternehmen";
?>
<html>
    <head>
		<?php
			CreateHead("AdminTools - Unternehmens Liste");
		?>
    </head>
    <body>
		<?php
			CreateNav();
		?>
    <h1>Admin Kontrollraum</h1>
        <div id="content">
            <div id="company_list">
            <?php
                $sqlresult = $connection->query($sqlcommand);
                if($sqlresult === false)
                {
                    echo "Es ist ein Fehler bei der Datenbankanfrage aufgetreten! Versuchen Sie es sp�ter erneut oder informieren Sie einen Admin oder Developer.";
                }else
                {
                    $sqlresult = $sqlresult->fetch_array();
                    foreach ($sqlresult as $wag)
                    {
                        echo "<div id='entry'><div id='entry_name'>".$wag['vaName']."</div></div>";
                    }
                }
            ?>
            </div>
        </div>
		<?php
			CreateFooter();
		?>
    </body>
</html>
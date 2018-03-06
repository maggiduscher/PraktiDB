<?php
    include_once "../utils/site_utils.php";
    include_once "../utils/database.php";
    IsLoggedIn();
    $connection = databaseConnect();
    $sqlcommand = "CALL GetAllAngebote();";
?>
<html>
    <head>
        <?php
			CreateHead("AdminTools - Angbot Liste");
		?>
    </head>
    <body>
		<?php
			CreateNav();
		?>
    <h1>Admin Kontrollraum</h1>
        <div id="content">
            <div id="offer_list">
                <?php
                    $sqlresult = $connection->query($sqlcommand);
                    if($sqlresult === false)
                    {
                        CreateError("Fehlerhafte SQL Anfrage: ".$connection->error.".");
                    }else
                    {
                        foreach ($sqlresult as $wag)
                        {
                            echo "<div id='entry'><div id='entry_name'>".$wag['biAngebotesID']."</div></div>"
                                    . "<div id='entry_delete'><a href='userEdit?delete=".$wag['biUserID']."'><img alt='delete'/></a></div>"
                                    . "<div id='entry_edit'><a href='userEdit?edit=".$wag['biUserID']."'><img alt='edit'/></a></div></div>";
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
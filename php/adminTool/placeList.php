<?php
    include_once "../utils/site_utils.php";
    include_once "../utils/database.php";
    IsLoggedIn();
    IsRole("admin");
    $sqlcommand = "CALL GetAllOrt();";
?>
<html>
    <head>
        <?php
            CreateHead("AdminTools - Ort Liste");
        ?>
    </head>
    <body>
        <?php
                CreateNav();
                if(isset($_GET['fail']))
                {
                    CreateError("Diese Aktion kann nicht durchgeführt werden! Versuchen Sie es erneut und vergewissern sie sich das Sie die richtigen Daten eingegeben haben! Sollte das Problem weiterhin bestehen wenden Sie sich an einen Admin!");
                }
        ?>
        <h1>AdminTools - Ort Liste</h1>
        <div id="content">
            <a href="placeEdit.php?new">Neuen Ort erstellen</a>
            <div id="user_list">
                <?php
                    $sqlresult = databaseQuery($sqlcommand);
                    if($sqlresult != null)
                    {
                        foreach ($sqlresult as $wag)
                        {
                            echo "<div id='entry'><div id='entry_name'>".$wag['vaPLZ']." ".$wag['vaStadt']."</div>"
                                . "<div id='entry_delete'><a href='placeEdit.php?delete=".$wag['vaPLZ']."'><img alt='delete'/></a></div>"
                                . "<div id='entry_edit'><a href='placeEdit.php?edit=".$wag['vaPLZ']."'><img alt='edit'/></a></div></div>";
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
<?php
    include_once "../utils/site_utils.php";
    include_once "admin_utils.php";
    include_once "../utils/database.php";
    IsLoggedIn();
    AllowedRolesOnly(array("admin"));
?>
<html>
    <head>
        <?php
            CreateHead("Admin Kontrollraum - Ort Liste");
        ?>
    </head>
    <body>
        <?php
            if(isset($_GET['fail']))
            {
                CreateError("Diese Aktion kann nicht durchgeführt werden! Versuchen Sie es erneut und vergewissern sie sich das Sie die richtigen Daten eingegeben haben! Sollte das Problem weiterhin bestehen wenden Sie sich an einen Admin!");
            }else if(isset($_GET['succ']))
            {
                CreateWarning("Aktion erfolgreich durchgeführt!");
            }
            CreateNav();     
        ?>
        <div id="main">
            <h1>Admin Kontrollraum - Ort Liste</h1>
            <a href="placeEdit.php?new"><img src="../../img/icons/add.png" alt="edit"/>Neuen Ort erstellen</a>
            <div id="user_list">
                <?php
                    $sqlresult = databaseQuery("CALL GetAllOrt();");
                    if($sqlresult != null)
                    {
                        foreach ($sqlresult as $wag)
                        {
                            echo "<div id='entry'><div id='entry_name'>".$wag['vaPLZ']." ".$wag['vaStadt']."</div>"
                                . "<div id='entry_delete'><a href='placeEdit.php?delete=".$wag['vaPLZ']."'><img src='../../img/icons/delete.png' alt='delete'/>löschen</a></div>"
                                . "<div id='entry_edit'><a href='placeEdit.php?edit=".$wag['vaPLZ']."'><img src='../../img/icons/edit.png' alt='edit'/>bearbeiten</a></div></div>";
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
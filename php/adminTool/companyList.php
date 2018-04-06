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
            CreateHead("AdminTools - Unternehmens Liste");
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
    <h1>Admin Kontrollraum</h1>
        <div id="content">
            <a href="companyEdit.php?new"><img src="../../img/icons/add.png" alt="edit"/>Neue Frima hinzufügen</a>
            <div id="company_list">
                <?php
                    $sqlresult = databaseQuery("CALL GetAllUnternehmen();");
                    if($sqlresult === false)
                    {
                        CreateError("Fehlerhafte SQL Anfrage: ".$connection->error.".");
                    }else
                    {
                        foreach ($sqlresult as $wag)
                        {
                            echo "<div id='entry'><div id='entry_name'>".$wag['vaName']."</div></div>"
                                    . "<div id='entry_delete'><a href='companyEdit.php?delete=".$wag['biUnternehmensID']."'><img src='../../img/icons/delete.png' alt='delete'/>löschen</a></div>"
                                    . "<div id='entry_edit'><a href='companyEdit.php?edit=".$wag['biUnternehmensID']."'><img src='../../img/icons/edit.png' alt='edit'/>bearbeiten</a></div></div>";
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
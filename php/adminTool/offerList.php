<?php
    include_once "../utils/site_utils.php";
    include_once "admin_utils.php";
    include_once "../utils/database.php";
    IsLoggedIn();
    IsRole("admin");
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
            <a href="offerEdit.php?new">Neues Angebot hinzufügen</a>
            <div id="company_list">
                <?php
                    $sqlresult = databaseQuery("CALL GetAllAngebote();");
                    if($sqlresult !== false)
                    {
                        foreach ($sqlresult as $wag)
                        {
                            echo "<div id='entry'><div id='entry_name'>".$wag['vaName']." sucht ".$wag['iGesuchte_Bewerber']." Bewerber für ".$wag['vaAngebots_Art']." vom ".$wag['dAnfangsdatum']." bis zum ".$wag['dEnddatum'].".</div></div>"
                                    . "<div id='entry_delete'><a href='offerEdit.php?delete=".$wag['biAngebotsID']."'><img alt='delete'/></a></div>"
                                    . "<div id='entry_edit_1'><a href='offerEdit.php?edit1=".$wag['biAngebotsID']."'><img alt='edit'/></a></div></div>"
                                    . "<div id='entry_edit_2'><a href='offerEdit.php?edit2=".$wag['biAngebotsID']."'><img alt='edit'/></a></div></div>";
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
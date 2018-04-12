<?php
    include_once "../utils/site_utils.php";
    include_once "admin_utils.php";
    include_once "../utils/database.php";
    IsLoggedIn();
    AllowedRolesOnly(array("admin","teacher"));
?>
<html>
    <head>
        <?php
            CreateHead("Admin/Lehrer Kontrollraum - Angebots Liste");
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
            <h1>Admin/Lehrer Kontrollraum - Angebots Liste</h1>
            <a href="offerEdit.php?new"><img src="../../img/icons/add.png" alt="edit"/>Neues Angebot hinzufügen</a>
            <div id="company_list">
                <?php
                    $sqlresult = databaseQuery("CALL GetAllAngebote();");
                    if($sqlresult !== false)
                    {
                        foreach ($sqlresult as $wag)
                        {
                            echo "<div id='entry'><div id='entry_name'>".$wag['vaName']." sucht ".$wag['iGesuchte_Bewerber']." Bewerber für ".$wag['vaAngebots_Art']." vom ".$wag['dAnfangsdatum']." bis zum ".$wag['dEnddatum'].".</div>"
                                    . "<div id='entry_delete'><a href='offerEdit.php?delete=".$wag['biAngebotsID']."'><img src='../../img/icons/delete.png' alt='delete'/>l&ouml;schen</a></div>"
                                    . "<div id='entry_edit_1'><a href='offerEdit.php?edit1=".$wag['biAngebotsID']."'><img src='../../img/icons/edit.png' alt='edit'/>Anzahl angenommener Bewerber &Auml;ndern (Nutze Sie dies nicht um einen Sch&uuml;ler als angenommen zu markieren)</a></div>"
                                    . "<div id='entry_edit_2'><a href='offerEdit.php?edit2=".$wag['biAngebotsID']."'><img src='../../img/icons/edit.png' alt='edit'/>Anzahl m&ouml;glicher Bewerber &Auml;ndern</a></div></div>";
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
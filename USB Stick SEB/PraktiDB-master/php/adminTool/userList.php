<?php
    include_once "../utils/site_utils.php";
    include_once "../utils/database.php";
    IsLoggedIn();
    IsRole("admin");
    $sqlcommand = "CALL GetAllUser();";
?>
<html>
    <head>
        <?php
            CreateHead("AdminTools - Benutzer Liste");
        ?>
    </head>
    <body>
        <?php
                CreateNav();
        ?>
        <h1>Admin Kontrollraum</h1>
        <div id="content">
            <div id="user_list">
                <?php
                    $sqlresult = databaseQuery($sqlcommand);
                    if($sqlresult !== false)
                    {
                        foreach ($sqlresult as $wag)
                        {
                            echo "<div id='entry'><div id='entry_name'>".$wag['vaUsername']."</div>"
                                . "<div id='entry_delete'><a href='userEdit.php?delete=".$wag['biUserID']."'><img alt='delete'/></a></div>"
                                . "<div id='entry_edit'><a href='userEdit.php?edit=".$wag['biUserID']."'><img alt='edit'/></a></div></div>"
                                . "<div id='entry_edit'><a href='userEdit.php?editPassword=".$wag['biUserID']."'><img alt='editPassword'/></a></div></div>";
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
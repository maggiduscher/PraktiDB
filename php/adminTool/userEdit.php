<?php
    include_once "../utils/site_utils.php";
    include_once "../utils/database.php";
    IsLoggedIn();
    IsRole("admin");
    if(isset($_GET['delete']))
    {
        $sqlcommand = "CALL DeleteUser(".$_GET['delete'].");";
        $sqlresult = databaseQuery($sqlcommand);
        if($sqlresult != null)
        {
            echo CreateWarning("Benutzer wurde gelöscht");
            header("location: ../adminTool/userList.php?succ");
        }else
        {
            header("location: ../adminTool/userList.php?fail");
        }        
    }else if(isset ($_GET['edit']))
    {
        
    }
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
            <?php
            
            ?>
        </div>
        <?php
                CreateFooter();
        ?>
    </body>
</html>
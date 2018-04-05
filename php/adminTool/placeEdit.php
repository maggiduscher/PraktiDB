<?php
    include_once "../utils/site_utils.php";
    include_once "admin_utils.php";
    include_once "../utils/database.php";
    IsLoggedIn();
    AllowedRolesOnly(array("admin"));
    if(isset ($_POST['submitAdd']))
    {
        $sqlresult = databaseQuery("CALL AddOrt('".$_POST['plz']."', '".$_POST['ort']."');");
        if($sqlresult != null)
        {
            header("location: placeList.php?succ");
        }else
        {
            header("location: placeList.php?fail");
        }
    }else
    if(isset ($_POST['submitEdit']))
    {
        $sqlresult = databaseQuery("CALL UpdateOrt('".$_POST['plz']."', '".$_POST['ort']."');");
        if($sqlresult != null)
        {
            header("location: placeList.php?succ");
        }else
        {
            header("location: placeList.php?fail");
        }
    }else
    if(isset($_GET['delete']))
    {
        $sqlresult = databaseQuery("CALL DeleteOrt('".$_GET['delete']."');");
        if($sqlresult != null)
        {
            header("location: placeList.php?succ");
        }else
        {
            header("location: placeList.php?fail");
        }        
    }else 
     
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
            if(isset($_GET['edit']))
            {
                generateEditFormPlace();
            }else 
            if(isset($_GET['new']))
            {
                generateAddFormPlace();
            }
            ?>
        </div>
        <?php
                CreateFooter();
        ?>
    </body>
</html>
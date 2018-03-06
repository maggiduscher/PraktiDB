<?php
    include_once "../utils/site_utils.php";
    include_once "admin_utils.php";
    include_once "../utils/database.php";
    IsLoggedIn();
    IsRole("admin");
    if(isset($_POST['submitEdit']))
    {
        $sqlresult = databaseQuery("CALL UpdateUser(STR_TO_DATE('".$_POST['geburtstag']."','%Y-%m-%d'), '".$_POST['desc']."', '".$_POST['address']."', '".$_POST['email']."', '".$_POST['klasse']."', '".$_POST['nachname']."', '".$_POST['ort']."', '".$_POST['username']."', '".$_POST['role']."', '".$_POST['vorname']."', ".$_POST['userID'].");");
        if($sqlresult != null)
        {
            header("location: ../adminTool/userList.php?succ");
        }else
        {
            header("location: ../adminTool/userList.php?fail");
        }       
    }else if(isset($_POST['submitEditPassword']))
    {
        $sqlresult = databaseQuery("CALL UpdatePasswort('".hash("sha256",$_POST['password'])."', ".$_POST['userID'].");");
        if($sqlresult != null)
        {
            header("location: ../adminTool/userList.php?succ");
        }else
        {
            header("location: ../adminTool/userList.php?fail");
        }  
    }else if(isset($_POST['submitAdd']))
    {
        $sqlresult = databaseQuery("CALL AddUser(STR_TO_DATE('".$_POST['geburtstag']."','%d.%m.%Y'), '".$_POST['address']."', '".$_POST['email']."','".$_POST['klasse']."','".$_POST['nachname']."', '".hash("sha256",$_POST['password'])."', '".$_POST['ort']."','".$_POST['username']."', '".$_POST['role']."', '".$_POST['vorname']."');");
        if($sqlresult != null)
        {
            header("location: ../adminTool/userList.php?succ");
        }else
        {
            header("location: ../adminTool/userList.php?fail");
        }  
    }else
    if(isset($_GET['delete']))
    {
        $sqlresult = databaseQuery("CALL DeleteUser(".$_GET['delete'].");");
        if($sqlresult != null)
        {
            echo CreateWarning("Benutzer wurde gelöscht");
            header("location: ../adminTool/userList.php?succ");
        }else
        {
            header("location: ../adminTool/userList.php?fail");
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
                    generateEditFormUser();
                }else 
                if(isset($_GET['editPassword']))
                {
                    generateEditFormPassword();
                }else 
                if(isset($_GET['new']))
                {
                    generateAddFormUser();
                }
            ?>
        </div>
        <?php
                CreateFooter();
        ?>
    </body>
</html>
<?php
    include_once "../utils/site_utils.php";
    include_once "admin_utils.php";
    include_once "../utils/database.php";
    IsLoggedIn();
    AllowedRolesOnly(array("admin"));

    if(isset($_POST['submitEdit']))
    {
        $sqlresult = databaseQuery("CALL UpdateUnternehmen(".$_POST['userID'].",'".$_POST['desc']."','".$_POST['address']."','".$_POST['branche']."','".$_POST['email']."','".$_POST['ort']."','".$_POST['name']."');");
        if($sqlresult != null)
        {
            header("location: ../adminTool/companyList.php?succ");
        }else
        {
            header("location: ../adminTool/companyList.php?fail");
        }       
    }else if(isset($_POST['submitAdd']))
    {
        $sqlresult = databaseQuery("CALL AddUnternehmen('".$_POST['name']."','".$_POST['address']."','".$_POST['ort']."','".$_POST['branche']."','".$_POST['email']."');");
        if($sqlresult != null)
        {
            header("location: ../adminTool/companyList.php?succ");
        }else
        {
            header("location: ../adminTool/companyList.php?fail");
        }  
    }else
    if(isset($_GET['delete']))
    {
        $sqlresult = databaseQuery("CALL DeleteUnternehmen(".$_GET['delete'].");");
        if($sqlresult != null)
        {
            header("location: ../adminTool/companyList.php?succ");
        }else
        {
            header("location: ../adminTool/companyList.php?fail");
        }        
    }else 
?>
<html>
    <head>
        <?php
            CreateHead("AdminTools - Firmen Liste");
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
                    generateEditFormCompany();
                }else 
                if(isset($_GET['new']))
                {
                    generateAddFormCompany();
                }
            ?>
        </div>
        <?php
                CreateFooter();
        ?>
    </body>
</html>
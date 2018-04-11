<?php
    include_once "../utils/site_utils.php";
    include_once "admin_utils.php";
    include_once "../utils/database.php";
    IsLoggedIn();
    AllowedRolesOnly(array("admin","teacher"));

    if(isset($_POST['submitEdit']))
    {
        //TODO: update UpdateUnternehmen with tel,web and desc
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
        $sqlresult = databaseQuery("CALL AddUnternehmen('".$_POST['name']."','".$_POST['address']."','".$_POST['ort']."','".$_POST['branche']."','".$_POST['email']."','".$_POST['tel']."','".$_POST['web']."','".$_POST['desc']."');");
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
            CreateHead("Admin/Lehrer Kontrollraum - Unternehmen verwalten");
        ?>
    </head>
    <body>
        <?php
                CreateNav();
        ?>
        <div id="main">
            
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
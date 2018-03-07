<?php
    include_once "../utils/site_utils.php";
    include_once "admin_utils.php";
    include_once "../utils/database.php";
    IsLoggedIn();
    IsRole("admin");
    if(isset($_POST['submitAdd']))
    {
        $sqlresult = databaseQuery("CALL AddAngebot(".$_POST['company'].", STR_TO_DATE('".$_POST['start']."','%d.%m.%Y'), STR_TO_DATE('".$_POST['end']."','%d.%m.%Y'),'".$_POST['type']."',".$_POST['anz'].");");
        if($sqlresult != null)
        {
            header("location: ../adminTool/offerList.php?succ");
        }else
        {
            header("location: ../adminTool/offerList.php?fail");
        }  
    }else if(isset($_POST['submitEdit1']))
    {
        $sqlresult = databaseQuery("CALL UpdataAngebotsAngenommene(".$_POST['offerID'].", ".$_POST['anz'].");");
        if($sqlresult != null)
        {
            header("location: ../adminTool/offerList.php?succ");
        }else
        {
            header("location: ../adminTool/offerList.php?fail");
        }  
    }else if(isset($_POST['submitEdit2']))
    {
        $sqlresult = databaseQuery("CALL UpdateAngebotsBewerber(".$_POST['offerID'].", ".$_POST['anz'].");");
        if($sqlresult != null)
        {
            header("location: ../adminTool/offerList.php?succ");
        }else
        {
            header("location: ../adminTool/offerList.php?fail");
        }  
    }else
    if(isset($_GET['delete']))
    {
        $sqlresult = databaseQuery("CALL DeleteAngebot(".$_GET['delete'].");");
        if($sqlresult != null)
        {
            header("location: ../adminTool/offerList.php?succ");
        }else
        {
            header("location: ../adminTool/offerList.php?fail");
        }        
    }else 
?>
<html>
    <head>
        <?php
            CreateHead("AdminTools - Angebot Liste");
        ?>
    </head>
    <body>
        <?php
                CreateNav();
        ?>
        <h1>Admin Kontrollraum</h1>
        <div id="content">
            <?php
                if(isset($_GET['new']))
                {
                    generateAddFormOffer();
                }else if(isset($_GET['edit1']))
                {
                    generateEdit1FormOffer();
                }else if(isset($_GET['edit2']))
                {
                    generateEdit2FormOffer();
                }
            ?>
        </div>
        <?php
                CreateFooter();
        ?>
    </body>
</html>
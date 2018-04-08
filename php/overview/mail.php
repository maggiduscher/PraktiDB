<script>
    function sleep(milliseconds) 
    {
        var start = new Date().getTime();
        for (var i = 0; i < 1e7; i++) 
        {
            if ((new Date().getTime() - start) > milliseconds)
            {
                break;
            }
        }
    }
</script>

<?php
    include_once '../utils/database.php';
    include_once '../utils/site_utils.php';
    IsLoggedIn();
    

    if(isset($_GET['id']))
    {
        $sqlresult = databaseQuery("CALL GetEmailFromAngebot(".$_GET['id'].");");
        if($sqlresult !== false)
        {
            $sqlresult1 = databaseQuery("CALL IncrementAngebotsBewerber(".$_GET['id'].")");
            $sqlresult2 = databaseQuery("CALL AddBewerbung(".$_GET['id'].", ".$_SESSION['id'].", '".date('Y-m-d')."')");
            if($sqlresult1 !== false && $sqlresult2 !== false)
            {
                $email = $sqlresult->fetch_assoc()['vaEmail'];
                echo "<script>"
                        . "myWindow = window.open(\"mailto:".$email."?Subject=Bewerbung\");"
                        . "myWindow.close();"
                        . "sleep(200);"
                        . "window.close();"
                    . "</script>";
            }else{
                header("location: ../overview");
            }
        }else{
           header("location: ../overview");
        }
        
    }else{
        header("location: ../overview");
    }
?>
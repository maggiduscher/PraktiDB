<?php
    include_once "regis_utils.php";
    include_once "../utils/site_utils.php";
?>
<html>
    <head>
            <?php            
                    CreateHead("Registrierung");
            ?>
    </head>
    <body>
        <div id="main">
            <?php
                if(isset($_POST['submit']))
                {
                    if($_COOKIE['type'] == "student")
                    {
                        registerUser($_COOKIE['type']);
                        unset($_COOKIE['type']);
                        setcookie('type', null, -1, '/');
                    }else
                    {
                        //TODO: ask admin
                    }
                }
                if(isset($_POST['submitSelect']))
                {
                    $type = $_POST['type'];
                    if($type == "student")
                    {
                        generateFormStudent();
                    }else if($type == "company")
                    {
                        generateFormCompany();
                    }else if($type == "teacher")
                    {
                        generateFormTeacher();
                    }else
                    {
                        echo "Man! Hast du toll gemacht!";
                    }

                }else
                {
                    generateFormSelect();
                }
            ?>
            <div>
                <a href="../login/">Du hast schon einen Account? Dann logge dich hier ein!</a>
            </div>
        </div>
        <?php
                CreateFooter();
        ?>
    </body>
</html>
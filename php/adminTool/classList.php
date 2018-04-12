<?php
	include_once "../utils/site_utils.php";
	include_once "admin_utils.php";
        IsLoggedIn();
        AllowedRolesOnly(array("teacher","admin"));
?>
<html>
	<head>
		<?php
			CreateHead("Admin/Lehrer Kontrollraum - Klassenliste");
		?>
	</head>
	<body>
            <?php
                    CreateNav();
            ?>
            <div id="main">
                <h1>Admin/Lehrer Kontrollraum - Klassenliste </h1>
                <?php
                    //Klasse wurde ausgewählt:
                    if(isset($_POST['class'])){ 
                        $sqlresult = databaseQuery("CALL GetKlasse('".$_POST['class']."')");
                        $users = $sqlresult->fetch_all(MYSQLI_ASSOC);
                        foreach ($users as $user) {
                            echo "<div id='name'>"
                                ."<a href='../profiles/user/?id=".$user['biUserID']."'>".$user['vaVorname']." ".$user['vaNachname']."</a>"
                            ."</div>";
                        }
                    }else{ //Klasse wurde nicht ausgewählt:
                        $sqlresult = databaseQuery("CALL GetAllKlassen()");
                        $classes = $sqlresult->fetch_all();
                        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_student_form'>"
                            ."<div id='class'>"
                                    ."<label for='class'>Klasse: </label>"
                                    ."<select name='class' id='class'>";
                                    foreach ($classes as $class) 
                                    {   
                                            echo "<option value='".$class[0]."'>".$class[0]."</option>";
                                    }
                                    echo "</select><br/>"
                            ."</div>"
                            ."<input id='submit' name='submit' type='submit' value='Anzeigen!'/>";

                    }
                ?>
            </div>
            <?php
                CreateFooter();
            ?>
	</body>
</html>
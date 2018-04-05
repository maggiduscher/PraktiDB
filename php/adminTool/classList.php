<?php
	include_once "../utils/site_utils.php";
	include_once "admin_utils.php";
        IsLoggedIn();
        AllowedRolesOnly(array("teacher","admin"));
?>
<html>
	<head>
		<?php
			CreateHead("Klassenliste");
		?>
	</head>
	<body>
		<?php
			CreateNav();
		?>
	<h1>Klassenliste </h1>
		<div id="content">
                    <?php
                        if(isset($_POST['class'])){
                            $sqlresult = databaseQuery("CALL GetKlasse('".$_POST['class']."')");
                            $users = $sqlresult->fetch_all();
                            foreach ($users as $user) {
                                echo "<div id='name'>"
                                    ."<a href='../profiles/user/?id=".$user[0]."'>".$user[1]."</a>"
                                ."</div>";
                            }
                            
                        }else{
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
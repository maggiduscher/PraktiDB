<?php
	include_once "../utils/site_utils.php";
	include_once "admin_utils.php";
        IsLoggedIn();
        AllowedRolesOnly(array("teacher","admin"));
        if(isset($_GET['id'])){
            $sqlresult = databaseQuery("CALL DeleteAngenommene(".$_GET['id'].");");
        }
?>
<html>
	<head>
		<?php
			CreateHead("Liste aller besuchten bzw. aller nicht besuchten Praktikumsstellen");
		?>
	</head>
	<body>
		<?php
			CreateNav();
		?>
            <h1>Liste aller besuchten bzw. aller nicht besuchten Praktikumsstellen</h1>
		<div id="content">
                    <a href="#visitedList">besuchte Praktikumsstellen</a>
                    <a href="#notVisitedList">Nicht besuchte Praktikumsstellen</a>
                    <?php
                        $sqlresult = databaseQuery("CALL GetAllNichtBesuchteStellen()");
                        $notacceptedUsers = $sqlresult->fetch_all();
                        $sqlresult2 = databaseQuery("CALL GetAllBesuchteStellen()");
                        $acceptedUsers = $sqlresult2->fetch_all();
                        echo "<div id='visitedList'>";
                        echo "<h2>Liste aller besuchten Praktikumsstellen</h2>";
                        if($acceptedUsers != null){
                            foreach ($acceptedUsers as $acceptedUser) {
                                echo "<div id=row>".$acceptedUser[0]." hat ".$acceptedUser[1]." besucht. <a href='?id=".$acceptedUser[2]."'><img src='../../img/icons/delete.png' alt='delete' /></div>";
                            }
                        }else {
                            echo "<div id=row>Es wurden noch keine Praktikumsstellen besucht.</div>";
                        }
                        echo "</div><br/>";
                        echo "<div id='notVisitedList'>";
                        echo "<h2>Liste aller nicht besuchten Praktikumsstellen</h2>";
                        if($notacceptedUsers != null){
                            foreach ($notacceptedUsers as $notacceptedUser) {
                                echo "<div id=row>".$notacceptedUser[0]."</div>";
                            }
                        }else{
                            echo "<div id=row>Es wurden alle Praktikumsstellen besucht.</div>";
                        }
                        echo "</div><br/>";
                    ?>
		</div>
		<?php
			CreateFooter();
		?>
	</body>
</html>
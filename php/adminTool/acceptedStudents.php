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
			CreateHead("Liste aller angenommener bzw. aller nicht angenommener Sch&uuml;ler");
		?>
	</head>
	<body>
		<?php
			CreateNav();
		?>
            <h1>Liste aller angenommener bzw. aller nicht angenommener Sch&uuml;ler</h1>
		<div id="content">
                    <a href="#acceptedList">Angenommen Sch&uuml;ler</a>
                    <a href="#notAcceptedList">Nicht angenommen Sch&uuml;ler</a>
                    <?php
                        $sqlresult = databaseQuery("CALL GetAllNichtAngenommene()");
                        $notacceptedUsers = $sqlresult->fetch_all();
                        $sqlresult2 = databaseQuery("CALL GetAllAngenommen()");
                        $acceptedUsers = $sqlresult2->fetch_all();
                        echo "<div id='acceptedList'>";
                        echo "<h2>Liste aller angenommener Sch&uuml;ler</h2>";
                        if($acceptedUsers != null){
                            foreach ($acceptedUsers as $acceptedUser) {
                                echo "<div id=row>".$acceptedUser[0]." wurde bei ".$acceptedUser[1]." angenommen. <a href='?id=".$acceptedUser[2]."'><img src='../../img/icons/delete.png' alt='delete' /></a></div>";
                            }
                        }else{
                            echo "<div id=row>Es gibt keine Sch&uuml;ler die einen Praktikumstelle haben.</div>";
                        }
                        echo "</div><br/>";
                        echo "<div id='notAcceptedList'>";
                        echo "<h2>Liste aller nicht angenommener Sch&uuml;ler</h2>";
                        if($notacceptedUsers != null){
                            foreach ($notacceptedUsers as $notacceptedUsers) {
                                echo "<div id=row>".$notacceptedUsers[0]." wurde noch nicht angenommen. </div>";
                            }
                        }else{
                            echo "<div id=row>Es gibt keine Sch&uuml;ler die keine Praktikumstelle haben.</div>";
                        }
                        echo "</div><br/>";
                    ?>
		</div>
		<?php
			CreateFooter();
		?>
	</body>
</html>
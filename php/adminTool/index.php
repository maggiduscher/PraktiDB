<?php
	include_once "../utils/site_utils.php";
	include_once "admin_utils.php";
        IsLoggedIn();
        AllowedRolesOnly(array("admin","teacher"));
?>
<html>
	<head>
		<?php
			CreateHead("Admin/Lehrer Kontrollraum");
		?>
	</head>
	<body>
            <?php
                    CreateNav();
            ?>
            <div id="main">
                <h1>Admin/Lehrer Kontrollraum</h1>
                <?php
                if(isRole("admin")) echo "<a href='userList.php'>Benutzer Verwaltung</a><br/>"
                    . "<a href='placeList.php'>Ort Verwaltung</a><br/>";

                if(isRole("teacher")|| IsRole("admin")) echo "<a href='classList.php'>Klassenlisten</a><br/>"
                                                            . "<a href='offerList.php'>Angebot Verwaltung</a><br/>"
                                                            . "<a href='companyList.php'>Firmen Verwaltung</a><br/>"
                                                            . "<a href='deactivatedList.php'>Deaktivierte Benutzter verwalten</a><br/>"
                                                            ."<a href='acceptedStudents.php'>Liste aller angenommen Sch&uuml;ler bzw. aller nicht angenommen Sch&uuml;ler</a><br/>"
                                                            ."<a href='visitedStudents.php'>Liste aller besuchten Praktikumstellen bzw. aller nicht besuchten Praktikumstellen</a><br/>"
                                                            ."<a href='userEdit.php?accept'>Einen Sch&uuml;ler als angenommen markieren</a><br/>"
                                                            ."<a href='userEdit.php?visit'>Eine Praktikumsstelle als besucht markieren</a>"
                ?>
            </div>
            <?php
                    CreateFooter();
            ?>
	</body>
</html>
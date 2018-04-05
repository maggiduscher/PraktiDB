<?php
	include_once "../utils/site_utils.php";
	include_once "admin_utils.php";
        IsLoggedIn();
        AllowedRolesOnly(array("admin","teacher"));
?>
<html>
	<head>
		<?php
			CreateHead("AdminTools - Index");
		?>
	</head>
	<body>
		<?php
			CreateNav();
		?>
	<h1>Admin Kontrollraum</h1>
		<div id="content">
                    <?php
                    if(isRole("admin")) echo "<a href='userList.php'>Benutzer Verwaltung</a>"
                        . "<a href='companyList.php'>Firmen Verwaltung</a>"
                        . "<a href='offerList.php'>Angebot Verwaltung</a>"
                        . "<a href='placeList.php'>Ort Verwaltung</a>";

                    if(isRole("teacher")|| IsRole("admin")) echo "<a href='classList.php'>Klassenlisten</a>"
                    ?>
		</div>
		<?php
			CreateFooter();
		?>
	</body>
</html>
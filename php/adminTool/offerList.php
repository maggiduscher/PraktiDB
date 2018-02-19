<?php
    include_once "../utils/site_utils.php";
    IsLoggedIn();
?>
<html>
    <head>
        <?php
			CreateHead("AdminTools - Angbot Liste");
		?>
    </head>
    <body>
		<?php
			CreateNav();
		?>
    <h1>Admin Kontrollraum</h1>
        <div id="content">
            <div id="offer_list">
            </div>
        </div>
		<?php
			CreateFooter();
		?>
    </body>
</html>
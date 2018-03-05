<?php

	ini_set('include_path', '../utils');
	include_once("site_utils.php");
	include_once("Database.php");

	
	if(isset($_POST['ok'])){
		
		
	}
	
?>

<html>
	<head>
	
		<?php 
			echo "</head>";
			CreateHead("Startseite"); 
			echo "\t\t</head>";
		?>

	</head>
	
	<body>
		<script type="text/javascript" src="../../js/filter.js"> </script>
		<?php CreateNav(); ?>
		<div id="main" >
			<a href="#" id="Filter" onclick="Filter();" style=" Cursor: pointer; text-decoration:none">Filter</a>
			
			<form id="Filters" method="POST"> 
				<select id="branche" name="branche">
					<option value="default" selected>---</option>
					<option value="IT">IT</option>
					<option value="Chemie">Chemie</option>
				</select>
				<select id="entfernung" name="entfernung">
					<option value="default" selected>---</option>
					<option value="1h">100m</option>
					<option value="5h">500m</option>
				</select>
				<select id="sortby" name="sortby">
					<option value="default" selected>---</option>
					<option value="entfernung">Entfernung</option>
					<option value="bewertung">Bewertung</option>
				</select>
				<input id="ok" name="ok" type="submit" value="OK" />			
			</form>
		</div>
		
		<script>	
			document.getElementById("branche").style.display = "none";
			document.getElementById("entfernung").style.display = "none";
			document.getElementById("sortby").style.display = "none";
			document.getElementById("ok").style.display = "none";
			var show = true;
		</script>
			
	</body>

</html>
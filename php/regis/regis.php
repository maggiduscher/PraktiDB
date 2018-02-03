<?php
	include_once "regis_utils.php";
	
	$type = "";
?>
<html>
	<head>
		<title></title>
	</head>
	<body>
		<div id="content">
				<?php
					if(isset($_POST['submit']))
					{
						registerUser($type);
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
	
		</div>
	</body>
</html>
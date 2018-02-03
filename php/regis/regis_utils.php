<?php

	include_once "../utils/database.php";
	
	function generateFormCompany()
	{
		echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_company_form'>"
		."<label for='Name'>Name: </label>"
		."<input type='text' name='name' id='name' placeholder='Name'/><br/>"
		."<label for='vorname'>Ort: </label>"
		."<input type='text' name='ort' id='ort' placeholder='Ort'/><br/>"
		."<label for='plz'>PLZ: </label>"
		."<input type='text' name='plz' id='plz' placeholder='PLZ'/><br/>"
		."<label for='str'>Stra&szlig;e: </label>"
		."<input type='text' name='str' id='str' placeholder='Stra&szlig;e'/>"
		."<input type='text' name='strNr' id='strNr' placeholder='Stra&szlig;e Nr.'/><br/>"
		."<label for='branche'>Branche: </label>"
		."<input type='text' name='branche' id='branche' placeholder='Branche'/><br/>"
		."<input id='submit' name='submit' type='submit' value='Registriren'/>"
		."</form>";
	}
	function generateFormStudent()
	{
		echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_student_form'>"
		."<label for='vorname'>Vorname: </label>"
		."<input type='text' name='vorname' id='vorname' placeholder='Vorname'/><br/>"
		."<label for='nachname'>Nachname: </label>"
		."<input type='text' name='nachname' id='nachname' placeholder='Nachname'/><br/>"
		."<label for='vorname'>Ort: </label>"
		."<input type='text' name='ort' id='ort' placeholder='Ort'/><br/>"
		."<label for='plz'>PLZ: </label>"
		."<input type='text' name='plz' id='plz' placeholder='PLZ'/><br/>"
		."<label for='str'>Stra&szlig;e: </label>"
		."<input type='text' name='str' id='str' placeholder='Stra&szlig;e'/>"
		."<input type='text' name='strNr' id='strNr' placeholder='Stra&szlig;e Nr.'/><br/>"
		."<label for='branche'>Geburtsjahr: </label>"
		."<input type='text' name='geburtsjahr' id='geburtsjahr' placeholder='Geburtsjahr'/><br/>"
		."<label for='bildungsgang'>Bildungsgang: </label>"
		."<input type='text' name='bildungsgang' id='bildungsgang' placeholder='Bildungsgang'/><br/>"
		."<label for='klasse'>Klasse: </label>"
		."<input type='text' name='klasse' id='klasse' placeholder='Klasse'/><br/>"
		."<label for='username'>Username: </label>"
		."<input type='text' name='username' id='username' placeholder='Username'/><br/>"
		."<label for='email'>Email:</label>"
		."<input type='email' name='email' id='email' placeholder='Email'/><br/>"
		."<label for='password'>Passwort:</label>"
		."<input type='password' name='password' id='password' placeholder='Passwort'/><br/>"
		."<input id='submit' name='submit' type='submit' value='Registriren'/>"
		."</form>";
	}
	function generateFormTeacher()
	{
		echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_teacher_form'>"
		."<label for='vorname'>Vorname: </label>"
		."<input type='text' name='vorname' id='vorname' placeholder='Vorname'/><br/>"
		."<label for='nachname'>Nachname: </label>"
		."<input type='text' name='nachname' id='nachname' placeholder='Nachname'/><br/>"
		."<input id='submit' name='submit' type='submit' value='Registriren'/>"
		."</form>";
	}
	
	function generateFormSelect()
	{
		echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_teacher_form'>"
		."Bitte wähle sie ihre Dingens:<br/>"
		."<label for='user'>Schüler (User) </label>"
		."<input type='radio' name='type' id='user' value='student'/><br/>"
		."<label for='user'>Firma (benötigt Bestätigung von Lehrer oder Admin) </label>"
		."<input type='radio' name='type' id='user' value='company'/><br/>"
		."<label for='user'>Lehrer (benötigt Bestätigung von Admin) </label>"
		."<input type='radio' name='type' id='user' value='teacher'/><br/>"
		."<input id='submitSelect' name='submitSelect' type='submit' value='Auswählen'/>"
		."</form>";
	}
	
	function registerUser($type)
	{
		$connection = databaseConnect();
		
		if($type == "student")
		{
			$adresse = $_POST['str'] + $_POST['strNr'];
			$sqlcommand1 = "INSERT INTO tbOrt(vaPLZ,vaStadt) VALUES ".$_POST['plz'].",".$_POST['ort'].";";
			$sqlresult1 = $connection->query($sqlcommand);
			$sqlcommand2 = "INSERT INTO tbUser(vaUsername,vaUserRole,vaEmail,vaVorname,vaNachname,vaAdresse,vaPLZ,vaKlasse,dGeburtsjahr,vaPassword) VALUES ".$_POST['username'].", 'student', ".$_POST['email'].", ".$_POST['vorname'].", ".$_POST['nachname'].", ".$adress.", ".$_POST['PLZ'].", ".$_POST['klasse'].", ".$_POST['geburtsjahr'].", ".hash("sha256",$_POST['password']).";";
			$sqlresult2 = $connection->query($sqlcommand);
			if($sqlresult2 === true)
			{
				echo "Erfolg!";
			}else
			{
				echo "NOPE!.avi";
			}
		}else if($type == "company")
		{
			$sqlcommand = "SELECT biUserId FROM tbUser WHERE vaUsername = ".$username." AND vaPassword = ".hash("sha256",$password).";";
			$sqlresult = $connection->query($sqlcommand);;
		}else if($type == "teacher")
		{
			$sqlcommand = "SELECT biUserId FROM tbUser WHERE vaUsername = ".$username." AND vaPassword = ".hash("sha256",$password).";";
			$sqlresult = $connection->query($sqlcommand);
		}
	}
?>

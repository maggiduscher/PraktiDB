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
            setcookie("type", "company",0);
	}
	function generateFormStudent()
	{
            echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_student_form'>"
            ."<label for='vorname'>Vorname: </label>"
            ."<input type='text' name='vorname' id='vorname' placeholder='Vorname'/><br/>"
            ."<label for='nachname'>Nachname: </label>"
            ."<input type='text' name='nachname' id='nachname' placeholder='Nachname'/><br/>"
            ."<label for='ort'>Ort: </label>"
            ."<input type='text' name='ort' id='ort' placeholder='Ort'/><br/>"
            ."<label for='plz'>PLZ: </label>"
            ."<input type='text' name='plz' id='plz' placeholder='PLZ'/><br/>"
            ."<label for='str'>Stra&szlig;e: </label>"
            ."<input type='text' name='str' id='str' placeholder='Stra&szlig;e'/>"
            ."<input type='text' name='strNr' id='strNr' placeholder='Stra&szlig;e Nr.'/><br/>"
            ."<label for='branche'>Geburtstag: </label>"
            ."<input type='text' name='geburtstag' id='geburtstag' placeholder='Geburtstag'/><br/>"
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
            setcookie("type", "student",0);
	}
	function generateFormTeacher()
	{
            echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_student_form'>"
            ."<label for='vorname'>Vorname: </label>"
            ."<input type='text' name='vorname' id='vorname' placeholder='Vorname'/><br/>"
            ."<label for='nachname'>Nachname: </label>"
            ."<input type='text' name='nachname' id='nachname' placeholder='Nachname'/><br/>"
            ."<label for='ort'>Ort: </label>"
            ."<input type='text' name='ort' id='ort' placeholder='Ort'/><br/>"
            ."<label for='plz'>PLZ: </label>"
            ."<input type='text' name='plz' id='plz' placeholder='PLZ'/><br/>"
            ."<label for='str'>Stra&szlig;e: </label>"
            ."<input type='text' name='str' id='str' placeholder='Stra&szlig;e'/>"
            ."<input type='text' name='strNr' id='strNr' placeholder='Stra&szlig;e Nr.'/><br/>"
            ."<label for='branche'>Geburtstag: </label>"
            ."<input type='text' name='geburtstag' id='geburtstag' placeholder='Geburtstag'/><br/>"
            ."<label for='username'>Username: </label>"
            ."<input type='text' name='username' id='username' placeholder='Username'/><br/>"
            ."<label for='email'>Email:</label>"
            ."<input type='email' name='email' id='email' placeholder='Email'/><br/>"
            ."<label for='password'>Passwort:</label>"
            ."<input type='password' name='password' id='password' placeholder='Passwort'/><br/>"
            ."<input id='submit' name='submit' type='submit' value='Registriren'/>"
            ."</form>";
            setcookie("type", "teacher",0);
	}
	
	function generateFormSelect()
	{
            echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_teacher_form'>"
            ."Ich bin ein/e... <br/>"
            ."<label for='user'>...Schüler/in</label>"
            ."<input type='radio' name='type' id='user' value='student'/><br/>"
            ."<label for='user'> ...Firma (ben&ouml;tigt Best&auml;tigung von einem Lehrer oder einem Admin) </label>"
            ."<input type='radio' name='type' id='user' value='company'/><br/>"
            ."<label for='user'>...Lehrer/in (ben&ouml;tigt Best&auml;tigung von einem Admin) </label>"
            ."<input type='radio' name='type' id='user' value='teacher'/><br/>"
            ."<input id='submitSelect' name='submitSelect' type='submit' value='Ausw&auml;hlen'/>"
            ."</form>";
	}
	
	function registerUser($type)
	{
            if($type == "student")
            {
                $adress = $_POST['str'].' '.$_POST['strNr'];
                $sqlresult = databaseQuery("CALL GetStadt('".$_POST['plz']."');",true);
                if($sqlresult == null)
                {
                    $sqlresult2 = databaseQuery("CALL AddOrt('".$_POST['plz']."','".$_POST['ort']."');");
                }
                $sqlresult3 = databaseQuery("CALL AddUser(STR_TO_DATE('".$_POST['geburtstag']."','%d.%m.%Y'), '".$adress."', '".$_POST['email']."','".$_POST['klasse']."','".$_POST['nachname']."', '".hash("sha256",$_POST['password'])."', '".$_POST['plz']."','".$_POST['username']."', 'student','".$_POST['vorname']."');");
                if ($sqlresult3 != null) 
                {
                    CreateWarning("Erfolg!");
                }
            }else if($type == "company")
            {
                    $sqlcommand = "SELECT biUserId FROM tbUser WHERE vaUsername = ".$username." AND vaPassword = ".hash("sha256",$password).";";
                    $sqlresult = $connection->query($sqlcommand);;
            }else if($type == "teacher")
            {
                $adress = $_POST['str'].' '.$_POST['strNr'];
                $sqlresult = databaseQuery("SELECT * FROM tbOrt WHERE vaPLZ = '".$_POST['plz']."';");               
                if($sqlresult !== false)
                {
                    if($sqlresult->num_rows == 0)
                    {
                        $sqlresult2 = databaseQuery("INSERT INTO tbOrt(vaPLZ,vaStadt) VALUES ('".$_POST['plz']."','".$_POST['ort']."');");
                        if (!$sqlresult2) 
                        {
                            CreateError("Fehlerhafte SQL Anfrage: ".$connection->error.".");
                        }
                    }
                }else
                {
                    CreateError("Fehlerhafte SQL Anfrage: ".$connection->error.".");
                }
                $sqlresult3 = databaseQuery("INSERT INTO tbUser(vaUsername,vaUserRole,vaEmail,vaVorname,vaNachname,vaAdresse,vaPLZ,vaKlasse,dGeburtsjahr,vaPasswort) VALUES ('".$_POST['username']."', 'teacher', '".$_POST['email']."', '".$_POST['vorname']."', '".$_POST['nachname']."', '".$adress."', '".$_POST['plz']."', null , STR_TO_DATE('".$_POST['geburtsjahr']."','%Y'), '".hash("sha256",$_POST['password'])."');");
                if ($sqlresult3 !== null) 
                {
                    CreateWarning("Erfolg!");
                }
            }
	}
?>

<?php
//Echt
	include_once "../utils/database.php";
	
	function generateFormCompany()
	{
            $sqlresult = databaseQuery("CALL GetAllOrt()");
            $places = $sqlresult->fetch_array();
            echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_company_form'>"
				."<div id='Name'>"
					."<label for='Name'>Name: </label>"
					."<input type='text' name='name' id='name' placeholder='Name'/><br/>"
				."</div>"
				."<div id='ort'>"
					."<label for='ort'>Ort: </label>"
					."<select name='ort' id='ort'>";
					foreach ($places as $place) 
					{   
						echo "<option value='".$place[0]."'>".$place[0]." ".$place[1]."</option>";
					}
					echo "</select><br/>"
				."</div>"
				."<div id='plz'>"
					."<label for='plz'>PLZ: </label>"
					."<input type='text' name='plz' id='plz' placeholder='PLZ'/><br/>"
				."</div>"
				."<div id='str'>"
					."<label for='str'>Stra&szlig;e: </label>"
					."<input type='text' name='str' id='str' placeholder='Stra&szlig;e'/>"
					."<input type='text' name='strNr' id='strNr' placeholder='Stra&szlig;e Nr.'/><br/>"
				."</div>"
				."<div id='branche'>"
					."<label for='branche'>Branche: </label>"
					."<input type='text' name='branche' id='branche' placeholder='Branche'/><br/>"
					."<input id='submit' name='submit' type='submit' value='Registrieren'/>"
				."</div>"
			."</form>";
            setcookie("type", "company",0);
	}
	function generateFormStudent()
	{
            $sqlresult = databaseQuery("CALL GetAllOrt()");
            var_dump($sqlresult);
            $places = $sqlresult->fetch_all();
            var_dump($places);
            echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_student_form'>"
				."<div id='vorname'>"
					."<label for='vorname'>Vorname: </label>"
					."<input type='text' name='vorname' id='vorname' placeholder='Vorname'/><br/>"
				."</div>"
				."<div id='nachname'>"
					."<label for='nachname'>Nachname: </label>"
					."<input type='text' name='nachname' id='nachname' placeholder='Nachname'/><br/>"
				."</div>"
				."<div id='ort'>"
					."<label for='ort'>Ort: </label>"
                                        ."<select name='ort' id='ort'>";
					foreach ($places as $place) 
					{   
						echo "<option value='".$place[0]."'>".$place[0]." ".$place[1]."</option>";
					}
					echo "</select><br/>"
				."</div>"
				."<div id='plz'>"
					."<label for='plz'>PLZ: </label>"
					."<input type='text' name='plz' id='plz' placeholder='PLZ'/><br/>"
				."</div>"
				."<div id='str'>"
					."<label for='str'>Stra&szlig;e: </label>"
					."<input type='text' name='str' id='str' placeholder='Stra&szlig;e'/>"
					."<input type='text' name='strNr' id='strNr' placeholder='Stra&szlig;e Nr.'/><br/>"
				."</div>"
				."<div id='branche'>"
					."<label for='branche'>Geburtstag: </label>"
					."<input type='text' name='geburtstag' id='geburtstag' placeholder='Geburtstag'/><br/>"
				."</div>"
				."<div id='klasse'>"
					."<label for='klasse'>Klasse: </label>"
					."<input type='text' name='klasse' id='klasse' placeholder='Klasse'/><br/>"
				."</div>"
				."<div id='username'>"
					."<label for='username'>Username: </label>"
					."<input type='text' name='username' id='username' placeholder='Username'/><br/>"
				."</div>"
				."<div id='email'>"
					."<label for='email'>Email:</label>"
					."<input type='email' name='email' id='email' placeholder='Email'/><br/>"
				."</div>"
				."<div id='password'>"
					."<label for='password'>Passwort:</label>"
					."<input type='password' name='password' id='password' placeholder='Passwort'/><br/>"
				."</div>"
				."<input id='submit' name='submit' type='submit' value='Registrieren'/>"
            ."</form>";
            setcookie("type", "student",0);
	}
	function generateFormTeacher()
	{
            $sqlresult = databaseQuery("CALL GetAllOrt()");
            $places = $sqlresult->fetch_array();
			echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_teacher_form'>"
				."<div id='vorname'>"
					."<label for='vorname'>Vorname: </label>"
					."<input type='text' name='vorname' id='vorname' placeholder='Vorname'/><br/>"
				."</div>"
				."<div id='nachname'>"
					."<label for='nachname'>Nachname: </label>"
					."<input type='text' name='nachname' id='nachname' placeholder='Nachname'/><br/>"
				."</div>"
				."<div id='ort'>"
					."<label for='ort'>Ort: </label>"
					."<select name='ort' id='ort'>";
					foreach ($places as $place) 
					{   
						echo "<option value='".$place[0]."'>".$place[0]." ".$place[1]."</option>";
					}
					echo "</select><br/>"
				."</div>"
				."<div id='plz'>"
					."<label for='plz'>PLZ: </label>"
					."<input type='text' name='plz' id='plz' placeholder='PLZ'/><br/>"
				."</div>"
				."<div id='str'>"
					."<label for='str'>Stra&szlig;e: </label>"
					."<input type='text' name='str' id='str' placeholder='Stra&szlig;e'/>"
					."<input type='text' name='strNr' id='strNr' placeholder='Stra&szlig;e Nr.'/><br/>"
				."</div>"
				."<div id='branche'>"
					."<label for='branche'>Geburtstag: </label>"
					."<input type='text' name='geburtstag' id='geburtstag' placeholder='Geburtstag'/><br/>"
				."</div>"
				."<div id='username'>"
					."<label for='username'>Username: </label>"
					."<input type='text' name='username' id='username' placeholder='Username'/><br/>"
				."</div>"
				."<div id='email'>"
					."<label for='email'>Email:</label>"
					."<input type='email' name='email' id='email' placeholder='Email'/><br/>"
				."</div>"
				."<div id='password'>"
					."<label for='password'>Passwort:</label>"
					."<input type='password' name='password' id='password' placeholder='Passwort'/><br/>"
				."</div>"
				."<div id='senden'>"
					."<input id='submit' name='submit' type='submit' value='Registrieren'/>"
				."</div>"
            ."</form>";
            setcookie("type", "teacher",0);
	}
	
	function generateFormSelect()
	{
            echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_select_form'>"
            ."Ich bin ein/e... <br/>"
            ."<input type='radio' name='type' id='user' value='student'/>"
            ."<label for='user'>...Schüler/in</label><br/>"
            ."<input type='radio' name='type' id='user' value='company'/>"
            ."<label for='user'> ...Firma (ben&ouml;tigt Best&auml;tigung von einem Lehrer oder einem Admin) </label><br/>"
            ."<input type='radio' name='type' id='user' value='teacher'/>"
            ."<label for='user'>...Lehrer/in (ben&ouml;tigt Best&auml;tigung von einem Admin) </label><br/>"
            ."<input id='submitSelect' name='submitSelect' type='submit' value='Ausw&auml;hlen'/>"
            ."</form>";
	}
	
	function registerUser($type)
	{
		$adress = $_POST['str'].' '.$_POST['strNr'];  
        $Data = array();
            if($type == "student")
            {
                
                $Data[] = "STR_TO_DATE('".$_POST['geburtsjahr']."','%d.%m.%Y'')";
				$Data[] = $adress;
				$Data[] = $_POST['email'];
				$Data[] = $_POST['klasse'];
				$Data[] = $_POST['nachname'];
				$Data[] = hash("sha256",$_POST['password']);
				$Data[] = $_POST['ort'];
				$Data[] = $_POST['username'];
				$Data[] = 'student';
				$Data[] = $_POST['vorname'];
				                				
                $sqlresult = databasePreparedStatement("CALL AddUser(?,?,?,?,?,?,?,?,?,?);",$Data);
                if ($sqlresult != null) 
                {
                    CreateWarning("Erfolg!");
                }
            }else if($type == "company")
            {
                    
            }else if($type == "teacher")
            {
                $Data[] = "STR_TO_DATE('".$_POST['geburtsjahr']."','%d.%m.%Y'')";
				$Data[] = $adress;
				$Data[] = $_POST['email'];
				//$Data[] = $_POST['klasse'];
				$Data[] = $_POST['nachname'];
				$Data[] = hash("sha256",$_POST['password']);
				$Data[] = $_POST['ort'];
				$Data[] = $_POST['username'];
				$Data[] = 'teacher';
				$Data[] = $_POST['vorname'];
				                				
                $sqlresult = databasePreparedStatement("CALL AddUser(?,?,?,?,?,?,?,?,?);",$Data);
                if ($sqlresult != null) 
                {
                    CreateWarning("Erfolg!");
                }
            }
	}
?>

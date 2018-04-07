<?php
//Echt
	include_once "../utils/database.php";
	
	function generateFormCompany($erros)
	{
            setcookie("type", "company",0);
            $sqlresult = databaseQuery("CALL GetAllOrt()");
            $places = $sqlresult->fetch_all();
            echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_company_form'>";
		       	if(count($erros) > 1 || $erros[0] != NULL){
					echo '<div id = "error_box" >';
					foreach($erros as $error){echo $error.'<br />';}
					echo '</div>';
				}
                    echo "<div id='name'>"
                            ."<label for='name'>Name: </label>"
                            ."<input type='text' name='name' id='name' placeholder='Name' required/><br/>"
                    ."</div>"
                    ."<div id='ort'>"
                            ."<label for='ort'>Ort: </label>"
                            ."<select name='ort' id='ort'>";
                            foreach ($places as $place){echo "<option value='".$place[0]."'>".$place[1]." ".$place[0]."</option>";}
                            echo "</select><br/>"
                    ."</div>"
                    ."<div id='plz'>"
                            ."<label for='plz'>PLZ: </label>"
                            ."<input type='text' name='plz' id='plz' placeholder='PLZ' required/><br/>"
                    ."</div>"
                    ."<div id='str'>"
                            ."<label for='str'>Stra&szlig;e: </label>"
                            ."<input type='text' name='str' id='str' placeholder='Stra&szlig;e'required/>"
                            ."<input type='text' name='strNr' id='strNr' placeholder='Stra&szlig;e Nr.'required/><br/>"
                    ."</div>"
                    ."<div id='email'>"
                            ."<label for='email'>Email:</label>"
                            ."<input type='email' name='email' id='email' placeholder='Email'required/><br/>"
                    ."</div>"
					  ."<div id='telefonnummer'>"
                            ."<label for=' telefonnummer '> Telefonnummer :</label>"
                            ."<input type='Text' name='telefonnummer' id='telefonnummer' placeholder='Telefonnummer 'required/><br/>"
                    ."</div>"
					  ."<div id='webseite'>"
                            ."<label for='webseite'>Webseite:</label>"
                            ."<input type='Text' name='webseite' id='webseite' placeholder='Webseite'required/><br/>"
                    ."</div>"
                    ."<div id='branche'>"
                            ."<label for='branche'>Branche: </label>"
                            ."<input type='text' name='branche' id='branche' placeholder='Branche'/><br/>"
                            
                    ."</div>"
					
					 ."<div id='Text'>"
                            ."<label for='Text'>Text: </label>"
                            ."<textarea rows=\"4\" cols=\"50\" name = \"Text\"></textarea><br />"
                            ."<input id='submit' name='submit' type='submit' value='Registrieren'/>"
                    ."</div>"
					
                ."</form>";
	}
	
	function generateFormStudent($erros)
	{ 	                     
	        setcookie("type", "student",0);	
			$sqlresult = databaseQuery("CALL GetAllOrt()");
            $places = $sqlresult->fetch_all();
			echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_teacher_form'>";
                if(count($erros) > 1 || $erros[0] != NULL){
					echo '<div id = "error_box" >';
					foreach($erros as $error){echo $error.'<br />';}
					echo '</div>';
				}
                    echo "<div id='vorname'>"
					."<label for='vorname'>Vorname: </label>"
					."<input type='text' name='vorname' id='vorname' placeholder='Vorname' required/><br/>"
				."</div>"
				."<div id='nachname'>"
					."<label for='nachname'>Nachname: </label>"
					."<input type='text' name='nachname' id='nachname' placeholder='Nachname' required/><br/>"
				."</div>"
		    	."<div id='ort'>"
					."<label for='ort'>Ort: </label>"
                    ."<select name='ort' id='ort'>";
					foreach ($places as $place) {   echo "<option value='".$place[0]."'>".$place[1]." ".$place[0]."</option>";}
					echo "</select><br/>"
				."</div>"
				."<div id='plz'>"
					."<label for='plz'>PLZ: </label>"
					."<input type='text' name='plz' id='plz' placeholder='PLZ' required/><br/>"
				."</div>"
				."<div id='str'>"
					."<label for='str'>Stra&szlig;e: </label>"
					."<input type='text' name='str' id='str' placeholder='Stra&szlig;e' required/>"
					."<input type='text' name='strNr' id='strNr' placeholder='Stra&szlig;e Nr.' required/><br/>"
				."</div>"
				 ."<div id='klasse'>"
                            ."<label for='klasse'>Klasse: </label>"
                            ."<input type='text' name='klasse' id='klasse' placeholder='Klasse' required/><br/>"
                ."</div>"
				."<div id='branche'>"
					."<label for='branche'>Geburtstag: </label>"
					."<input type='text' name='geburtstag' id='geburtstag' placeholder='Geburtstag' required/><br/>"
				."</div>"
				."<div id='username'>"
					."<label for='username'>Username: </label>"
					."<input type='text' name='username' id='username' placeholder='Username' required/><br/>"
				."</div>"
				."<div id='email'>"
					."<label for='email'>Email:</label>"
					."<input type='email' name='email' id='email' placeholder='Email' required/><br/>"
				."</div>"
				."<div id='password'>"
					."<label for='password'>Passwort:</label>"
					."<input type='password' name='password' id='password' placeholder='Passwort' required/><br/>"
				."</div>"
				."<div id='senden'>"
					."<input id='submit' name='submit' type='submit' value='Registrieren'/>"
				."</div>"
            ."</form>";	  
	}
	
	function generateFormTeacher($erros)
	{
            setcookie("type", "teacher",0);
            $sqlresult = databaseQuery("CALL GetAllOrt()");
            $places = $sqlresult->fetch_all();
            echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_teacher_form'>";
			    if(count($erros) > 1 || $erros[0] != NULL){
					echo '<div id = "error_box" >';
					foreach($erros as $error){echo $error.'<br />';}
					echo '</div>';
				}
                    echo "<div id='vorname'>"
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
                            foreach ($places as $place) {   echo "<option value='".$place[0]."'>".$place[1]." ".$place[0]."</option>";}
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
	
	
	
	function CheckTheDate($date,&$Data,&$Fehler)
	{
		$Check = True;
		if(empty(trim($date))){$Data[] = " "; return false;}
		else{
			 
			 $dummy = split('\.',$date);
			 if(count($dummy) != 3){$Check = false;}
			 else{
			     if(preg_match('/[A-Z]/i',$date) != 0 ){$Check = false;}
				 else if(!checkdate( $dummy[1], $dummy[0], $dummy[2])){$Check = false;}
				}    	
			}
	    if(!$Check){$Fehler[] = "Bitte geben Sie ein richtiges Datum ein"; $Data[] = "Fehler";}
		return $Check;
	}
	
	function CheckEmail($Email)
	{
		$sqlresult = databasePreparedStatement("CALL CheckEmail(?);",[$Email]);
		$output = $sqlresult->fetch_array();
		
		if($output['vaEmail'] == Null){return True;}
		else{return False;}
	}
	
	function CheckNachZahlen($Wort)
	{	
	    if(preg_match('/[0-9]/',$Wort) != 0 ){return false;}
		else{return True;}	    	
	}
	
	
	function FindeFehler($Data,&$Fehler,$type)
	{
		for($i= 0; $i < count($Data);++$i)
				{
					if(empty(trim($Data[$i])))
				    {
					      switch($i)
						  {
							  case 0:
							  $Fehler[] = "Sie haben kein Datum eingegeben";
							  break;
							  
							  case 1:
							  $Fehler[] = "Sie haben keine Adress eingegeben";
							  break;
							  
							  case 2:
							  $Fehler[] = "Sie haben keine Email eingegeben";
							  break;
							  
							  case 3:
							  if($type == "student"){$Fehler[] = "Sie haben keine Klasse eingegeben";}
							  //Ein Lehrer muss keine Klasse angeben
							  break;
							  
							  case 4:
							  $Fehler[] = "Sie haben keinen Nachname eingegeben";
							  break;
							  
							  case 5:
							  $Fehler[] = "Sie haben kein Password eingegeben";
							  break;  
							  							  
							  case 6:
							  $Fehler[] = "Sie haben keinen Ort eingegeben";
							  break;  
							  							  
							  case 7:
							  $Fehler[] = "Sie haben keinen Username eingegeben";
							  break;  
							  							  
							  case 8:
							  $Fehler[] = "Sie haben einen Fehler der nicht kommen sollte";
							  break;  
							  							  
							  case 9:
							  $Fehler[] = "Sie haben keinen Vorname eingegeben";
							  break;  

							  default: 
							  break;
							
						  }
				    }
				}
	}
		
	function registerUser($type)
	{
		
		$adress = $_POST['str'].' '.$_POST['strNr'];  
        $Data = array();
		$Fehler = array();
            if($type == "student")
            { 
		    	$date = $_POST['geburtstag'];
                if(CheckTheDate($date,$Data,$Fehler))
				{
					if(strlen(explode('.',$date)[2])==2){$datetime = DateTime::createFromFormat('d.m.y',$_POST['geburtstag']);}
				    else if(strlen(explode('.',$date)[2])==4){$datetime = DateTime::createFromFormat('d.m.Y',$_POST['geburtstag']);}
                    $Data[] = $datetime->format('Y-m-d');	
				}
				$Data[] = $adress;
				if(CheckEmail($_POST['email'])){$Data[] = $_POST['email'];}
				else{$Data[] = "Fehler"; $Fehler[] = "Die EMail ist schon vorhanden";}
				
				$Data[] = $_POST['klasse'];
				if(CheckNachZahlen($_POST['nachname'])){$Data[] = $_POST['nachname'];}
				else{$Data[] = "Fehler"; $Fehler[] = "Ein Nachname hat keine Zalen";}
				
				if(empty(trim($_POST['password']))){$Data[] = " ";}
				else{$Data[] = hash("sha256",$_POST['password']);}
				$Data[] = $_POST['ort'];
				$Data[] = $_POST['username'];
				$Data[] = 'student';
				if(CheckNachZahlen($_POST['vorname'])){$Data[] = $_POST['vorname'];;}
				else{$Data[] = "Fehler"; $Fehler[] = "Ein Vorname hat keine Zalen";}
				
				
			
				
			    FindeFehler($Data,$Fehler,$type);
				
				if(count($Fehler)!= 0){return $Fehler;}
				else{
					$sqlresult = databasePreparedStatement("CALL AddUser(?,?,?,?,?,?,?,?,?,?);",$Data);
					return Null;
				}
				
            }else if($type == "company")
            {
				if(empty(trim($_POST['name']))){$Data[] = " ";}
				else{$Data[] = 'deactivated '.$_POST['name'];}
                
				$Data[] = $adress;
				$Data[] = $_POST['ort'];
				if(CheckNachZahlen($_POST['branche'])){$Data[] = $_POST['branche'];}
				else{$Data[] = "Fehler"; $Fehler[] = "Eine Branche hat keine Zalen";}				
				$Data[] = $_POST['email'];
				if(preg_match('/[A-Z]/i',$_POST['telefonnummer']) == 0 ){$Data[] = $_POST['telefonnummer'];}
				else{$Data[] = " ";}
				$Data[] = $_POST['webseite'];
				$Data[] = $_POST['Text'];

				
					for($i= 0; $i < count($Data);++$i)
				   {
					 if(empty(trim($Data[$i])))
				     {
					      switch($i)
						  {
							  case 0:
							  $Fehler[] = "Sie haben keinen Namen eingegeben";
							  break;
							  
							  case 1:
							  $Fehler[] = "Sie haben keine Adress eingegeben";
							  break;
							  
							  case 2:
							  $Fehler[] = "Sie haben keine Ort eingegeben";
							  break;
							  
							  case 3:
							  $Fehler[] = "Sie haben keine Branche eingegeben";
							  break;
							  
							  case 4:
							   $Fehler[] = "Sie haben keine Email eingegeben";
							  break;
							  
							  case 5:
							  $Fehler[] = "Sie haben keine Telefonnummer eingegeben";
							  break;
							  
							  case 6:
							  $Fehler[] = "Sie haben keine Webseite eingegeben";
							  break;
							  
							  case 7:
							  $Fehler[] = "Sie haben keine Text eingegeben";
							  break;

							  default: 
							  break;
							
						  }
				     }
				  }
								
				if(count($Fehler)!= 0){return $Fehler;}
				else{
					$sqlresult = databasePreparedStatement("CALL AddUnternehmen(?,?,?,?,?,?,?,?);",$Data);
					return Null;
				}
				
            }else if($type == "teacher")
            {
				$date = $_POST['geburtstag'];
                if(CheckTheDate($date,$Data,$Fehler))
				{
					if(strlen(explode('.',$date)[2])==2){$datetime = DateTime::createFromFormat('d.m.y',$_POST['geburtstag']);}
				    else if(strlen(explode('.',$date)[2])==4){$datetime = DateTime::createFromFormat('d.m.Y',$_POST['geburtstag']);}
                    $Data[] = $datetime->format('Y-m-d');	
				}
				$Data[] = $adress;
				$Data[] = $_POST['email'];
				$Data[] =  Null; //$_POST['klasse'];
			    if(CheckNachZahlen($_POST['nachname'])){$Data[] = $_POST['nachname'];}
				else{$Data[] = "Fehler"; $Fehler[] = "Ein Nachname hat keine Zalen";}
				if(empty(trim($_POST['password']))){$Data[] = " ";}
				else{$Data[] = hash("sha256",$_POST['password']);}
				$Data[] = $_POST['ort'];
				$Data[] = $_POST['username'];
				$Data[] = 'deactivated teacher';
				if(CheckNachZahlen($_POST['vorname'])){$Data[] = $_POST['vorname'];}
				else{$Data[] = "Fehler"; $Fehler[] = "Ein Vorname hat keine Zalen";}			
				
				FindeFehler($Data,$Fehler,$type);
				
				
				if(count($Fehler)!= 0){return $Fehler;}
				else
				{
					$sqlresult = databasePreparedStatement("CALL AddUser(?,?,?,?,?,?,?,?,?,?);",$Data);
					return Null;
				}
				
            }
	}
?>

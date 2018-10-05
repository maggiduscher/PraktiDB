<?php

    include_once '../utils/database.php';
    /*
        Funktionen um präperierte Information von der Datenbank abzufragen
    */
    function GetPlaceData($plz) 
    {
        $sqlresult = databaseQuery("CALL GetStadt('".$plz."')");
        $output = $sqlresult->fetch_array();
        return $output;
    }
    
    function GetUserData($id)
    {
        $sqlresult = databaseQuery("CALL GetUser(".$id.")");
        $output = $sqlresult->fetch_array();
        return $output;
    }
    
    function GetCompanyData($id)
    {
        $sqlresult = databaseQuery("CALL GetUnternehmen(".$id.")");
        $output = $sqlresult->fetch_array();
        return $output;
    }
    /*
        Funktionen zur Generierung von Formularen für das Kontrollzentrum
    */
    function generateAddFormOffer()
    {
        echo "<h1>Admin/Lehrer Kontrollraum - Angbot hinzufügen</h1>";
        $sqlresult = databaseQuery("CALL GetAllUnternehmen()");
        $companies = $sqlresult->fetch_all();
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_company_form'>"
        ."<div id='row'>"
		."<label for='company'>Firma: </label>"
        ."<select name='company' id='company'>";
        foreach ($companies as $company) 
        {   
           echo "<option value='".$company[0]."'>".$company[1]."</option>";
        }
        echo "</select><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='start'>Anfangsdatum: </label>"
        ."<input type='text' name='start' id='start' placeholder='Anfangsdatum'/><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='end'>Enddatum: </label>"
        ."<input type='text' name='end' id='end' placeholder='Enddatum'/><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='type'>Angebotsbranche: </label>"
        ."<input type='text' name='type' id='type' placeholder='Angebotsbranche'/><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='branche'>Anzahl gesuchter Bewerber: </label>"
        ."<input type='number' name='anz' id='anz'/><br/>"
		."</div>"
        ."<input id='submitAdd' name='submitAdd' type='submit' value='Speichern'/>"
        ."</form>";
    }
    function generateEdit1FormOffer()
    {
        echo "<h1>Admin/Lehrer Kontrollraum - Anzahl angenommener Schüler bearbeiten</h1>";
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_company_form'>"
		."<div id='row'>"
        ."<label for='branche'>Anzahl Angenommene Bewerber: </label>"
        ."<input type='number' name='anz' id='anz'/><br/>"
		."</div>"
        ."<input id='submitEdit1' name='submitEdit1' type='submit' value='Speichern'/>"
        ."<input id='offerID' name='offerID' type='hidden' value='".$_GET['edit']."'/>"
        ."</form>";
    }
    function generateEdit2FormOffer()
    {
        echo "<h1>Admin/Lehrer Kontrollraum - Anzahl Bewerber bearbeiten</h1>";
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_company_form'>"
		."<div id='row'>"
        ."<label for='branche'>Anzahl Bewerber: </label>"
        ."<input type='number' name='anz' id='anz'/><br/>"
		."</div>"
        ."<input id='submitEdit2' name='submitEdit2' type='submit' value='Speichern'/>"
        ."<input id='offerID' name='offerID' type='hidden' value='".$_GET['edit']."'/>"
        ."</form>";
    }
    //Company
    function generateEditFormCompany()
    {
        echo "<h1>Admin/Lehrer Kontrollraum - Unternehmen bearbeiten</h1>";
        $companydata = GetCompanyData($_GET['edit']);
        $sqlresult = databaseQuery("CALL GetAllOrt()");
        $places = $sqlresult->fetch_all();
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_company_form'>"
		."<div id='row'>"
        ."<label for='Name'>Name: </label>"
        ."<input type='text' name='name' id='name' placeholder='Name' value='".$companydata['vaName']."'/><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='ort'>Ort: </label>"
        ."<select name='ort' id='ort'>";
        foreach ($places as $place) 
        {   
           echo "<option value='".$place[0]."'";if($companydata['vaPLZ']==$place[0])echo "selected"; echo">".$place[1]." ".$place[0]."</option>";
        }
        echo "</select><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='address'>Adresse: </label>"
        ."<input type='text' name='address' id='address' placeholder='Adresse' value='".$companydata['vaAdresse']."'/><br/>"
        ."</div>"
		."<div id='row'>"
		."<label for='branche'>Branche: </label>"
        ."<input type='text' name='branche' id='branche' placeholder='Branche' value='".$companydata['vaBrache']."'/><br/>"
        ."</div>"
		."<div id='row'>"
		."<label for='email'>E-Mail: </label>"
        ."<input type='email' name='email' id='email' placeholder='E-Mail' value='".$companydata['vaEmail']."'/><br/>"
        ."</div>"
                ."<div id='row'>"
                ."<label for='tel'>Telefonnummer: </label>"
        ."<input type='text' name='tel' id='tel' placeholder='Telefonnummer'/><br/>"
        ."</div>"
		."<div id='row'>"
                ."<label for='web'>Webpr&auml;senz: </label>"
        ."<input type='text' name='web' id='web' placeholder='Webpr&auml;senz'/><br/>"
        ."</div>"
		."<div id='row'>"
		."<label for='desc'>Beschreibung: </label>"
        ."<input type='textarea' name='desc' id='desc' placeholder='Beschreibung' value='".$companydata['tText']."'/><br/>"
        ."</div>"
		."<input id='submitEdit' name='submitEdit' type='submit' value='Speichern'/>"
        ."<input id='userID' name='userID' type='hidden' value='".$_GET['edit']."'/>"
        ."</form>";
    }
    function generateAddFormCompany()
    {
        echo "<h1>Admin/Lehrer Kontrollraum - Unternehmen hinzufügen</h1>";
        $sqlresult = databaseQuery("CALL GetAllOrt()");
        $places = $sqlresult->fetch_all();
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_company_form'>"
		."<div id='row'>"
        ."<label for='Name'>Name: </label>"
        ."<input type='text' name='name' id='name' placeholder='Name'/><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='ort'>Ort: </label>"
        ."<select name='ort' id='ort'>";
        foreach ($places as $place) 
        {   
           echo "<option value='".$place[0]."'>".$place[1]." ".$place[0]."</option>";
        }
        echo "</select><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='address'>Adresse: </label>"
        ."<input type='text' name='address' id='address' placeholder='Adresse' value='".$userdata['vaAdresse']."'/><br/>"
        ."</div>"
		."<div id='row'>"
		."<label for='branche'>Branche: </label>"
        ."<input type='text' name='branche' id='branche' placeholder='Branche'/><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='email'>E-Mail: </label>"
        ."<input type='email' name='email' id='email' placeholder='E-Mail'/><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='tel'>Telefonnummer: </label>"
        ."<input type='text' name='tel' id='tel' placeholder='Telefonnummer'/><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='web'>Webpr&auml;senz: </label>"
        ."<input type='text' name='web' id='web' placeholder='Webpr&auml;senz'/><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='desc'>Beschreibung: </label>"
        ."<textarea rows='4' cols='50' name = 'desc' id= 'desc'></textarea><br />"
		."</div>"
        ."<input id='submitAdd' name='submitAdd' type='submit' value='Speichern'/>"
        ."</form>";
    }
    //User
    function generateEditFormUser()
    {
        echo "<h1>Admin Kontrollraum - Benutzer bearbeiten</h1>";
        $userdata = GetUserData($_GET['edit']);
        $sqlresult = databaseQuery("CALL GetAllOrt()");
        $places = $sqlresult->fetch_all();
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='edit_user_form'>"
		."<div id='row'>"
        ."<label for='vorname'>Vorname: </label>"
        ."<input type='text' name='vorname' id='vorname' placeholder='Vorname' value='".$userdata['vaVorname']."'/><br/>"
        ."</div>"
		."<div id='row'>"
		."<label for='nachname'>Nachname: </label>"
        ."<input type='text' name='nachname' id='nachname' placeholder='Nachname' value='".$userdata['vaNachname']."'/><br/>"
        ."</div>"
		."<div id='row'>"
		."<label for='ort'>Ort: </label>"
        ."<select name='ort' id='ort'>";
        foreach ($places as $place) 
        {   
           echo "<option value='".$place[0]."'";if($userdata['vaPLZ']==$place[0])echo "selected"; echo">".$place[1]." ".$place[0]."</option>";
        }
        echo "</select><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='address'>Adresse: </label>"
        ."<input type='text' name='address' id='address' placeholder='Adresse' value='".$userdata['vaAdresse']."'/><br/>"
        ."</div>"
		."<div id='row'>"
		."<label for='branche'>Geburtstag: </label>"
        ."<input type='text' name='geburtstag' id='geburtstag' placeholder='Geburtstag' value='".$userdata['dGeburtsjahr']."'/><br/>"
        ."</div>"
		."<div id='row'>"
		."<label for='klasse'>Klasse: </label>"
        ."<input type='text' name='klasse' id='klasse' placeholder='Klasse' value='".$userdata['vaKlasse']."'/><br/>"
        ."</div>"
		."<div id='row'>"
		."<label for='username'>Username: </label>"
        ."<input type='text' name='username' id='username' placeholder='Username' value='".$userdata['vaUsername']."'/><br/>"
        ."</div>"
		."<div id='row'>"
		."<label for='email'>Email:</label>"
        ."<input type='email' name='email' id='email' placeholder='Email' value='".$userdata['vaEmail']."'/><br/>"
        ."</div>"
		."<div id='row'>"
		."<label for='desc'>Beschreibung:</label>"
        ."<input type='textarea' name='desc' id='desc' placeholder='Beschreibung' value='".$userdata['tText']."'/><br/>"
        ."</div>"
		."<div id='row_radio'>"
		."<div id='cell'> Rolle: </div>"
			."<div id='cell'>"
            ."<input type='radio' name='role' id='student' value='student'";if($userdata['vaUserRole']=="student")echo "checked"; echo"/>"
            ."<label for='student'>Sch&uuml;ler/in</label><br/>"
            ."<input type='radio' name='role' id='teacher' value='teacher'";if($userdata['vaUserRole']=="teacher")echo "checked"; echo"/>"
            ."<label for='student'>Leherer/in</label><br/>"
            ."<input type='radio' name='role' id='admin' value='admin'";if($userdata['vaUserRole']=="admin")echo "checked"; echo"/>"
            ."<label for='student'>Admin</label><br/>"
			."</div>"
		."</div>"
        ."<input id='submitEdit' name='submitEdit' type='submit' value='Speichern'/>"
        ."<input id='userID' name='userID' type='hidden' value='".$_GET['edit']."'/>"
        ."</form>";
    }
    function generateAddFormUser()
    {
        echo "<h1>Admin Kontrollraum - Benutzer hinzufügen</h1>";
        $sqlresult = databaseQuery("CALL GetAllOrt()");
        $places = $sqlresult->fetch_all();
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_student_form'>"
		."<div id='row'>"
        ."<label for='vorname'>Vorname: </label>"
        ."<input type='text' name='vorname' id='vorname' placeholder='Vorname'/><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='nachname'>Nachname: </label>"
        ."<input type='text' name='nachname' id='nachname' placeholder='Nachname'/><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='ort'>Ort: </label>"       
        ."<select name='ort' id='ort'>";
        foreach ($places as $place) 
        {   
           echo "<option value='".$place[0]."'>".$place[1]." ".$place[0]."</option>";
        }
        echo "</select><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='address'>Adresse: </label>"
        ."<input type='text' name='address' id='address' placeholder='Adresse'/><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='branche'>Geburtstag: </label>"
        ."<input type='text' name='geburtstag' id='geburtstag' placeholder='Geburtstag'/><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='klasse'>Klasse: </label>"
        ."<input type='text' name='klasse' id='klasse' placeholder='Klasse'/><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='username'>Username: </label>"
        ."<input type='text' name='username' id='username' placeholder='Benutzername'/><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='email'>Email:</label>"
        ."<input type='email' name='email' id='email' placeholder='Email'/><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='password'>Passwort:</label>"
        ."<input type='password' name='password' id='password' placeholder='Passwort'/><br/>"
		."</div>"
		."<div id='row_radio'>"
        ."<div id='cell'> Rolle:</div>"
			."<div id='cell'>"
            ."<input type='radio' name='role' id='student' value='student'/>"
            ."<label for='student'>Sch&uuml;ler/in</label><br/>"
            ."<input type='radio' name='role' id='teacher' value='teacher'/>"
            ."<label for='student'>Leherer/in</label><br/>"
            ."<input type='radio' name='role' id='admin' value='admin'/>"
            ."<label for='student'>Admin</label><br/>"
			."</div>"
		."</div>"
        ."<input id='submitAdd' name='submitAdd' type='submit' value='Speichern'/>"
        ."</form>";
    }
    function generateEditFormPassword()
    {
        $userdata = GetUserData($_GET['editPassword']);
        echo "<h1>Admin Kontrollraum - Password von ".$userdata['vaUsername']." bearbeiten</h1>";
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_student_form'>"
		."<div id='row'>"
        ."<label for='password'>Neues Passwort: </label>"
        ."<input type='text' name='password' id='password' placeholder='Neues Passwort'/><br/>"
		."</div>"		
        ."<input id='submitEditPassword' name='submitEditPassword' type='submit' value='Speichern'/>"
        ."<input id='userID' name='userID' type='hidden' value='".$_GET['editPassword']."'/>"
        ."</form>";
    }
    //Place
    function generateAddFormPlace()
    {
        echo "<h1>Admin Kontrollraum - Ort hinzufügen</h1>";
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='edit_place_form'>"
		."<div id='row'>"
        ."<label for='plz'>PLZ: </label>"
        ."<input type='text' name='plz' id='plz' placeholder='PLZ'/><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='ort'>Ort: </label>"
        ."<input type='text' name='ort' id='ort' placeholder='Ort'/><br/>"
		."</div>"
        ."<input id='submitAdd' name='submitAdd' type='submit' value='Speichern'/>"
        ."</form>";
    }
    function generateEditFormPlace()
    {
        echo "<h1>Admin Kontrollraum - Ort bearbeiten</h1>";
        $placedata = GetPlaceData($_GET['edit']);
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='edit_place_form'>"
		."<div id='row'>"
        ."<label for='plz'>PLZ: </label>"
        ."<input type='text' name='plz' id='plz' placeholder='PLZ' value='".$placedata['vaPLZ']."'/><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='ort'>Ort: </label>"
        ."<input type='text' name='ort' id='ort' placeholder='Ort' value='".$placedata['vaStadt']."'/><br/>"
		."</div>"
        ."<input id='submitEdit' name='submitEdit' type='submit' value='Speichern'/>"
        ."</form>";
    }
    function generateUserAcceptForm()
    {
        echo "<h1>Admin/Lehrer Kontrollraum - Benutzer als angenommen markieren</h1>";
        $sqlresult = databaseQuery("CALL GetAllAngebote()");
        $offer = $sqlresult->fetch_all(MYSQLI_ASSOC);
        $sqlresult2 = databaseQuery("CALL GetAllNichtAngenommene()");
        $user = $sqlresult2->fetch_all(MYSQLI_ASSOC);
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='accept_user_form'>"
		."<div id='row'>"
        ."<label for='offer'>Angebot: </label>"       
        ."<select name='offer' id='offer'>";
        foreach ($offer as $wag) 
        {   
           echo "<option value='".$wag['biAngebotsID']."'>".$wag['vaName']." sucht ".$wag['iGesuchte_Bewerber']." Bewerber für ".$wag['vaAngebots_Art']." vom ".$wag['dAnfangsdatum']." bis zum ".$wag['dEnddatum']."</option>";
        }
        echo "</select><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='user'>Schüler: </label>"       
        ."<select name='user' id='user'>";
        foreach ($user as $wag2) 
        {   
           echo "<option value='".$wag2['biUserID']."'>".$wag2['vaUsername']."</option>";
        }
        echo "</select><br/>"
		."</div>"
        ."<input id='submitAccept' name='submitAccept' type='submit' value='Speichern'/>"
        ."</form>";
    }
    function generateUserVisitForm()
    {
        echo "<h1>Admin/Lehrer Kontrollraum - Praktikumsstelle als besucht markieren</h1>";
        $sqlresult = databaseQuery("CALL GetAllUnternehmenMitAngebot()");
        $offer = $sqlresult->fetch_all(MYSQLI_ASSOC);
        $sqlresult2 = databaseQuery("CALL GetAllNichtBesuchteLehrer()");
        $user = $sqlresult2->fetch_all(MYSQLI_ASSOC);
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='accept_user_form'>"
		."<div id='row'>"
        ."<label for='company'>Firma: </label>"       
        ."<select name='company' id='company'>";
        foreach ($offer as $wag) 
        {   
           echo "<option value='".$wag['biAngebotsID']."'>".$wag['vaName']."</option>";
        }
        echo "</select><br/>"
		."</div>"
		."<div id='row'>"
        ."<label for='user'>Lehrer: </label>"       
        ."<select name='user' id='user'>";
        foreach ($user as $wag2) 
        {   
           echo "<option value='".$wag2['biUserID']."'>".$wag2['vaUsername']."</option>";
        }
        echo "</select><br/>"
		."</div>"
        ."<input id='submitVisit' name='submitVisit' type='submit' value='Speichern'/>"
        ."</form>";
    }

?>


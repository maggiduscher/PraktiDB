<?php

    include_once '../utils/database.php';
    
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
    //Offer

    function generateAddFormOffer()
    {
        $sqlresult = databaseQuery("CALL GetAllUnternehmen()");
        $companies = $sqlresult->fetch_all();
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_company_form'>"
        ."<label for='company'>Firma: </label>"
        ."<select name='company' id='company'>";
        foreach ($companies as $company) 
        {   
           echo "<option value='".$company[0]."'>".$company[1]."</option>";
        }
        echo "</select><br/>"
        ."<label for='start'>Anfangsdatum: </label>"
        ."<input type='text' name='start' id='start' placeholder='Anfangsdatum'/><br/>"
        ."<label for='end'>Enddatum: </label>"
        ."<input type='text' name='end' id='end' placeholder='Enddatum'/><br/>"
        ."<label for='type'>Angebotsbranche: </label>"
        ."<input type='text' name='type' id='type' placeholder='Angebotsbranche'/><br/>"
        ."<label for='branche'>Anzahl gesuchter Bewerber: </label>"
        ."<input type='number' name='anz' id='anz'/><br/>"
        ."<input id='submitAdd' name='submitAdd' type='submit' value='Speichern'/>"
        ."</form>";
    }
    function generateEdit1FormOffer()
    {
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_company_form'>"
        ."<label for='branche'>Anzahl Angenommene Bewerber: </label>"
        ."<input type='number' name='anz' id='anz'/><br/>"
        ."<input id='submitEdit1' name='submitEdit1' type='submit' value='Speichern'/>"
        ."<input id='offerID' name='offerID' type='hidden' value='".$_GET['edit']."'/>"
        ."</form>";
    }
    function generateEdit2FormOffer()
    {
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_company_form'>"
        ."<label for='branche'>Anzahl Bewerber: </label>"
        ."<input type='number' name='anz' id='anz'/><br/>"
        ."<input id='submitEdit2' name='submitEdit2' type='submit' value='Speichern'/>"
        ."<input id='offerID' name='offerID' type='hidden' value='".$_GET['edit']."'/>"
        ."</form>";
    }
    //Company
    function generateEditFormCompany()
    {
        $companydata = GetCompanyData($_GET['edit']);
        $sqlresult = databaseQuery("CALL GetAllOrt()");
        $places = $sqlresult->fetch_all();
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_company_form'>"
        ."<label for='Name'>Name: </label>"
        ."<input type='text' name='name' id='name' placeholder='Name' value='".$companydata['vaName']."'/><br/>"
        ."<label for='ort'>Ort: </label>"
        ."<select name='ort' id='ort'>";
        foreach ($places as $place) 
        {   
           echo "<option value='".$place[0]."'";if($companydata['vaPLZ']==$place[0])echo "selected"; echo">".$place[1]." ".$place[0]."</option>";
        }
        echo "</select><br/>"
        ."<label for='address'>Adresse: </label>"
        ."<input type='text' name='address' id='address' placeholder='Adresse' value='".$companydata['vaAdresse']."'/><br/>"
        ."<label for='branche'>Branche: </label>"
        ."<input type='text' name='branche' id='branche' placeholder='Branche' value='".$companydata['vaBrache']."'/><br/>"
        ."<label for='email'>E-Mail: </label>"
        ."<input type='email' name='email' id='email' placeholder='E-Mail' value='".$companydata['vaEmail']."'/><br/>"
        ."<label for='desc'>Beschreibung: </label>"
        ."<input type='textarea' name='desc' id='desc' placeholder='Beschreibung' value='".$companydata['tText']."'/><br/>"
        ."<input id='submitEdit' name='submitEdit' type='submit' value='Speichern'/>"
        ."<input id='userID' name='userID' type='hidden' value='".$_GET['edit']."'/>"
        ."</form>";
    }
    function generateAddFormCompany()
    {
        $sqlresult = databaseQuery("CALL GetAllOrt()");
        $places = $sqlresult->fetch_all();
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_company_form'>"
        ."<label for='Name'>Name: </label>"
        ."<input type='text' name='name' id='name' placeholder='Name'/><br/>"
        ."<label for='ort'>Ort: </label>"
        ."<select name='ort' id='ort'>";
        foreach ($places as $place) 
        {   
           echo "<option value='".$place[0]."'>".$place[1]." ".$place[0]."</option>";
        }
        echo "</select><br/>"
        ."<label for='address'>Adresse: </label>"
        ."<input type='text' name='address' id='address' placeholder='Adresse' value='".$userdata['vaAdresse']."'/><br/>"
        ."<label for='branche'>Branche: </label>"
        ."<input type='text' name='branche' id='branche' placeholder='Branche'/><br/>"
        ."<label for='email'>E-Mail: </label>"
        ."<input type='email' name='email' id='email' placeholder='E-Mail'/><br/>"
        ."<input id='submitAdd' name='submitAdd' type='submit' value='Speichern'/>"
        ."</form>";
    }
    //User
    function generateEditFormUser()
    {
        $userdata = GetUserData($_GET['edit']);
        $sqlresult = databaseQuery("CALL GetAllOrt()");
        $places = $sqlresult->fetch_all();
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='edit_user_form'>"
        ."<label for='vorname'>Vorname: </label>"
        ."<input type='text' name='vorname' id='vorname' placeholder='Vorname' value='".$userdata['vaVorname']."'/><br/>"
        ."<label for='nachname'>Nachname: </label>"
        ."<input type='text' name='nachname' id='nachname' placeholder='Nachname' value='".$userdata['vaNachname']."'/><br/>"
        ."<label for='ort'>Ort: </label>"
        ."<select name='ort' id='ort'>";
        foreach ($places as $place) 
        {   
           echo "<option value='".$place[0]."'";if($userdata['vaPLZ']==$place[0])echo "selected"; echo">".$place[1]." ".$place[0]."</option>";
        }
        echo "</select><br/>"
        ."<label for='address'>Adresse: </label>"
        ."<input type='text' name='address' id='address' placeholder='Adresse' value='".$userdata['vaAdresse']."'/><br/>"
        ."<label for='branche'>Geburtstag: </label>"
        ."<input type='text' name='geburtstag' id='geburtstag' placeholder='Geburtstag' value='".$userdata['dGeburtsjahr']."'/><br/>"
        ."<label for='klasse'>Klasse: </label>"
        ."<input type='text' name='klasse' id='klasse' placeholder='Klasse' value='".$userdata['vaKlasse']."'/><br/>"
        ."<label for='username'>Username: </label>"
        ."<input type='text' name='username' id='username' placeholder='Username' value='".$userdata['vaUsername']."'/><br/>"
        ."<label for='email'>Email:</label>"
        ."<input type='email' name='email' id='email' placeholder='Email' value='".$userdata['vaEmail']."'/><br/>"
        ."<label for='desc'>Beschreibung:</label>"
        ."<input type='textarea' name='desc' id='desc' placeholder='Beschreibung' value='".$userdata['tText']."'/><br/>"
        ."Rolle:<br/>"
            ."<input type='radio' name='role' id='student' value='student'";if($userdata['vaUserRole']=="student")echo "checked"; echo"/>"
            ."<label for='student'>Sch&uuml;ler/in</label><br/>"
            ."<input type='radio' name='role' id='teacher' value='teacher'";if($userdata['vaUserRole']=="teacher")echo "checked"; echo"/>"
            ."<label for='student'>Leherer/in</label><br/>"
            ."<input type='radio' name='role' id='admin' value='admin'";if($userdata['vaUserRole']=="admin")echo "checked"; echo"/>"
            ."<label for='student'>Admin</label><br/>"
        ."<label for='angenommen'>Wurde der Schüler angnommen?</label><br/>";
        if($userdata['bAngenommen'] == 1){
            $angenommen1 = "checked";
            $angenommen2 = "";
        }else{
            $angenommen1 = "";
            $angenommen2 = "checked";
        }
        echo "<label for='ja'>Ja</label><input type='radio' name='angenommen' id='angenommen' value='1' ".$angenommen1."/><br/>"
        ."<label for='nein'>Nein</label><input type='radio' name='angenommen' id='angenommen' value='0' ".$angenommen2."/><br/>"
        ."<input id='submitEdit' name='submitEdit' type='submit' value='Speichern'/>"
        ."<input id='userID' name='userID' type='hidden' value='".$_GET['edit']."'/>"
        ."</form>";
    }
    function generateAddFormUser()
    {
        $sqlresult = databaseQuery("CALL GetAllOrt()");
        $places = $sqlresult->fetch_all();
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_student_form'>"
        ."<label for='vorname'>Vorname: </label>"
        ."<input type='text' name='vorname' id='vorname' placeholder='Vorname'/><br/>"
        ."<label for='nachname'>Nachname: </label>"
        ."<input type='text' name='nachname' id='nachname' placeholder='Nachname'/><br/>"
        ."<label for='ort'>Ort: </label>"       
        ."<select name='ort' id='ort'>";
        foreach ($places as $place) 
        {   
           echo "<option value='".$place[0]."'>".$place[1]." ".$place[0]."</option>";
        }
        echo "</select><br/>"
        ."<label for='address'>Adresse: </label>"
        ."<input type='text' name='address' id='address' placeholder='Adresse'/><br/>"
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
        ."Rolle:<br/>"
            ."<input type='radio' name='role' id='student' value='student'/>"
            ."<label for='student'>Sch&uuml;ler/in</label><br/>"
            ."<input type='radio' name='role' id='teacher' value='teacher'/>"
            ."<label for='student'>Leherer/in</label><br/>"
            ."<input type='radio' name='role' id='admin' value='admin'/>"
            ."<label for='student'>Admin</label><br/>"
        ."<input id='submitAdd' name='submitAdd' type='submit' value='Speichern'/>"
        ."</form>";
    }
    function generateEditFormPassword()
    {
        $userdata = GetUserData($_GET['editPassword']);
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_student_form'>"
        ."<label for='password'>Neues Passwort: </label>"
        ."<input type='text' name='password' id='password' placeholder='Neues Passwort'/><br/>"      
        ."<input id='submitEditPassword' name='submitEditPassword' type='submit' value='Speichern'/>"
        ."<input id='userID' name='userID' type='hidden' value='".$_GET['editPassword']."'/>"
        ."</form>";
    }
    //Place
    function generateAddFormPlace()
    {
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='edit_place_form'>"
        ."<label for='plz'>PLZ: </label>"
        ."<input type='text' name='plz' id='plz' placeholder='PLZ'/><br/>"
        ."<label for='ort'>Ort: </label>"
        ."<input type='text' name='ort' id='ort' placeholder='Ort'/><br/>"
        ."<input id='submitAdd' name='submitAdd' type='submit' value='Speichern'/>"
        ."</form>";
    }
    function generateEditFormPlace()
    {
        $placedata = GetPlaceData($_GET['edit']);
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='edit_place_form'>"
        ."<label for='plz'>PLZ: </label>"
        ."<input type='text' name='plz' id='plz' placeholder='PLZ' value='".$placedata['vaPLZ']."'/><br/>"
        ."<label for='ort'>Ort: </label>"
        ."<input type='text' name='ort' id='ort' placeholder='Ort' value='".$placedata['vaStadt']."'/><br/>"
        ."<input id='submitEdit' name='submitEdit' type='submit' value='Speichern'/>"
        ."</form>";
    }
    function generateUserAcceptForm()
    {
        $sqlresult = databaseQuery("CALL GetAllAngebote()");
        $offer = $sqlresult->fetch_all(MYSQLI_ASSOC);
        $sqlresult2 = databaseQuery("CALL GetAllNichtAngenommene()");
        $user = $sqlresult2->fetch_all(MYSQLI_ASSOC);
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='accept_user_form'>"
        ."<label for='offer'>Angebot: </label>"       
        ."<select name='offer' id='offer'>";
        foreach ($offer as $wag) 
        {   
           echo "<option value='".$wag['biAngebotsID']."'>".$wag['vaName']." sucht ".$wag['iGesuchte_Bewerber']." Bewerber für ".$wag['vaAngebots_Art']." vom ".$wag['dAnfangsdatum']." bis zum ".$wag['dEnddatum']."</option>";
        }
        echo "</select><br/>"
        ."<label for='user'>Schüler: </label>"       
        ."<select name='user' id='user'>";
        foreach ($user as $wag2) 
        {   
           echo "<option value='".$wag2['biUserID']."'>".$wag2['vaUsername']."</option>";
        }
        echo "</select><br/>"
        ."<input id='submitAccept' name='submitAccept' type='submit' value='Speichern'/>"
        ."</form>";
    }
    function generateUserVisitForm()
    {
        $sqlresult = databaseQuery("CALL GetAllUnternehmenMitAngebot()");
        $offer = $sqlresult->fetch_all(MYSQLI_ASSOC);
        $sqlresult2 = databaseQuery("CALL GetAllNichtBesuchteLehrer()");
        $user = $sqlresult2->fetch_all(MYSQLI_ASSOC);
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='accept_user_form'>"
        ."<label for='company'>Firma: </label>"       
        ."<select name='company' id='company'>";
        foreach ($offer as $wag) 
        {   
           echo "<option value='".$wag['biAngebotsID']."'>".$wag['vaName']."</option>";
        }
        echo "</select><br/>"
        ."<label for='user'>Lehrer: </label>"       
        ."<select name='user' id='user'>";
        foreach ($user as $wag2) 
        {   
           echo "<option value='".$wag2['biUserID']."'>".$wag2['vaUsername']."</option>";
        }
        echo "</select><br/>"
        ."<input id='submitVisit' name='submitVisit' type='submit' value='Speichern'/>"
        ."</form>";
    }

?>


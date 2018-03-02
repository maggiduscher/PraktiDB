<?php

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
    
    function generateEditFormCompany()
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
    function generateEditFormUser()
    {
        $userdata = GetUserData($_GET['edit']);
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_student_form'>"
        ."<label for='vorname'>Vorname: </label>"
        ."<input type='text' name='vorname' id='vorname' placeholder='Vorname' value='".$userdata['vaVorname']."'/><br/>"
        ."<label for='nachname'>Nachname: </label>"
        ."<input type='text' name='nachname' id='nachname' placeholder='Nachname' value='".$userdata['vaNachname']."'/><br/>"
        ."<label for='ort'>Ort: </label>"
        ."<input type='text' name='ort' id='ort' placeholder='Ort' value='".$userdata['vaStadt']."'/><br/>"
        ."<label for='plz'>PLZ: </label>"
        ."<input type='text' name='plz' id='plz' placeholder='PLZ' value='".$userdata['vaPLZ']."'/><br/>"
        ."<label for='address'>Adresse: </label>"
        ."<input type='text' name='address' id='address' placeholder='Adresse' value='".$userdata['vaAdresse']."'/>"
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
        ."<input id='submit' name='submit' type='submit' value='Speichern'/>"
        ."</form>";
        setcookie("type", "student",0);
    }

?>


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
    
    function generateEditFormCompany()
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
           echo "<option value='".$place[0]."'>".$place[0]." ".$place[1]."</option>";
        }
        echo "</select><br/>"
        ."<label for='address'>Adresse: </label>"
        ."<input type='text' name='address' id='address' placeholder='Adresse' value='".$userdata['vaAdresse']."'/>"
        ."<label for='branche'>Branche: </label>"
        ."<input type='text' name='branche' id='branche' placeholder='Branche'/><br/>"
        ."<input id='submit' name='submit' type='submit' value='Registriren'/>"
        ."</form>";
    }
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
           echo "<option value='".$place[0]."'>".$place[0]." ".$place[1]."</option>";
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
        ."<input id='submitEdit' name='submitEdit' type='submit' value='Speichern'/>"
        ."<input id='userID' name='userID' type='hidden' value='".$_GET['edit']."'/>"
        ."</form>";
    }
    function generateAddFormUser()
    {
        $userdata = GetUserData($_GET['edit']);
        $sqlresult = databaseQuery("CALL GetAllOrt()");
        $places = $sqlresult->fetch_all();
        echo "<form method='POST' action=".$_SERVER['PHP_SELF']." id='regis_student_form'>"
        ."<label for='vorname'>Vorname: </label>"
        ."<input type='text' name='vorname' id='vorname' placeholder='Vorname'/><br/>"
        ."<label for='nachname'>Nachname: </label>"
        ."<input type='text' name='nachname' id='nachname' placeholder='Nachname'/><br/>"
        ."<select name='ort' id='ort'>";
        foreach ($places as $place) 
        {   
           echo "<option value='".$place[0]."'>".$place[0]." ".$place[1]."</option>";
        }
        echo "</select><br/>"
        ."<label for='address'>Adresse: </label>"
        ."<input type='text' name='address' id='address' placeholder='Adresse'/>"
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
            ."<input type='radio' name='role' id='student' value='student' ";if($userdata['vaUserRole']=="student")echo "checked"; echo"/>"
            ."<label for='student'>Sch&uuml;ler/in</label><br/>"
            ."<input type='radio' name='role' id='teacher' value='teacher' ";if($userdata['vaUserRole']=="teacher")echo "checked"; echo"/>"
            ."<label for='student'>Leherer/in</label><br/>"
            ."<input type='radio' name='role' id='admin' value='admin' ";if($userdata['vaUserRole']=="admin")echo "checked"; echo"/>"
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

?>


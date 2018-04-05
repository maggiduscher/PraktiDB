<?php
	ini_set('include_path', '../utils');
	include_once("site_utils.php");
	include_once("database.php");
        include_once("overview_utils.php");
	IsLoggedIn();
        $sqlextention = "";
        $sqlextention2 = "";
	if(isset($_POST['ok']))
        {
	    if(isset($_POST['branche']) && $_POST['branche'] != "default")
            {
                $sqlextention .= " WHERE vaAngebots_Art = '".$_POST['branche']."'";
            }
            if(isset($_POST['sortby']) && $_POST['sortby'] == "bewertung")
            {
                $sqlextention2 .= " ORDER BY AVG(iPunkte) DESC ";
            }
		
	}
        $sqlresult2 = databaseQuery("SELECT *,AVG(iPunkte) FROM tbangebote "
                . "JOIN tbunternehmen USING(biUnternehmensID) "
                . "JOIN tbort USING(vaPLZ)"
                . "LEFT OUTER JOIN tbuser_bewertung USING(biUnternehmensID) "
                . $sqlextention
                . "GROUP BY biUnternehmensID"
                . $sqlextention2
                .";");
        $counter = 0;
        foreach ($sqlresult2 as $value) 
        {
            $start = new DateTime($value['dAnfangsdatum']);
            $end = new DateTime($value['dEnddatum']);
            $data[$counter]['name'] = $value['vaName'];
            $data[$counter]['branche'] = $value['vaAngebots_Art'];
            $data[$counter]['zeitraum'] = "Vom ".($start->format("d.m.Y"))." bis ".($end->format("d.m.Y"));
            $data[$counter]['frei'] = ($value['iGesuchte_Bewerber']-$value['iAngenommene_Bewerber']);
            //$data[$counter]['entfernung'] = (GetDistanceFromGoogleAPI(GetAddressFromUser($_SESSION['id']),$value['vaAdresse']." ".$value['vaPLZ']." ".$value['vaStadt']));
            $data[$counter]['punkte'] = $value['iPunkte'];
            $counter = $counter+1;
            echo "<br/>";
            echo "<br/>";
            
        }
        if(isset($_POST['ok']))
        {
	    if(isset($_POST['sortby']) && $_POST['sortby'] == "entfernung")
            {
                foreach($data as $value)
                {
                    $sort_array[] = $value['entfernung'];
                }
                array_multisort($sort_array, SORT_ASC, $data);
            }
		
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
                    <?php
                    $sqlresult1 = databaseQuery("CALL GetAllBranchen()");
                    if($sqlresult1 !== false)
                    {
                        foreach ($sqlresult1 as $value) 
                        {
                            echo "<option value='".$value['vaAngebots_Art']."'>".$value['vaAngebots_Art']."</option>";
                        }
                    }
                    ?>
                </select>
                <select id="entfernung" name="entfernung">
                        <option value="default" selected>---</option>
                        <option value="100">100m</option>
                        <option value="500">500m</option>
                </select>
                <select id="sortby" name="sortby">
                        <option value="default" selected>---</option>
                        <option value="entfernung">Entfernung</option>
                        <option value="bewertung">Bewertung</option>
                </select>
                <input id="ok" name="ok" type="submit" value="OK" />			
            </form>
            <table id="offers">
                <tr>
                    <th>Unternehmen</th>
                    <th>Branche</th>
                    <th>Zeitraum</th>
                    <th>Freie Pl&auml;tze</th>
                    <th>Entfernung</th>
                    <th>Bewertung</th>
                </tr>
                <?php
                    foreach ($data as $value) 
                    {
                        $output = preg_replace('/k/','00', $value['entfernung']);
                        $output=preg_replace('/\./','',$output);
                        $output=preg_replace('/m/','',$output);
                        $output=preg_replace('/\s+/','',$output);
                        echo $output;
                        if((!isset($_POST['ok']))||($_POST['entfernung']=="default")||(isset($_POST['ok'])&&($_POST['entfernung']!="default")&&$output<=$_POST['entfernung']))
                        {
                            echo "<tr><td>".$value['name']."</td><td>".$value['branche']."</td><td>".$value['zeitraum']."</td><td>".$value['frei']."</td><td>".$value['entfernung']."</td><td>".$value['punkte']."</td></tr>";
                        }
                        
                    }
                ?>
            </table>
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
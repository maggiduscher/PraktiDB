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
	
        $sqlresult2 = databaseQuery("SELECT *,AVG(IFNULL(iPunkte,0)) AS \"Punkte\" FROM tbangebote "
                . "JOIN tbunternehmen USING(biUnternehmensID) "
                . "JOIN tbort USING(vaPLZ)"
                . "LEFT OUTER JOIN tbuser_bewertung USING(biUnternehmensID) "
                . $sqlextention
                . "GROUP BY biAngebotsID"
                . $sqlextention2
                .";");
        $counter = 0;
        $counter2 = 0;
        foreach ($sqlresult2 as $value) 
        {
            $start = new DateTime($value['dAnfangsdatum']);
            $end = new DateTime($value['dEnddatum']);
            $heute = new DateTime("now");
            if($end > $heute && $start <= $heute && ($value['iGesuchte_Bewerber']-$value['iAngenommene_Bewerber']) > 0){
                $data[$counter]['id'] = $value['biUnternehmensID'];
                $data[$counter]['angebot'] = $value['biAngebotsID'];
                $data[$counter]['name'] = $value['vaName'];
                $data[$counter]['branche'] = $value['vaAngebots_Art'];
                $data[$counter]['zeitraum'] = "Vom ".($start->format("d.m.Y"))." bis ".($end->format("d.m.Y"));
                $data[$counter]['frei'] = ($value['iGesuchte_Bewerber']-$value['iAngenommene_Bewerber']);
                $data[$counter]['email'] = $value['vaEmail'];
                $data[$counter]['entfernung'] = (GetDistanceFromGoogleAPI(GetAddressFromUser($_SESSION['id']),$value['vaAdresse']." ".$value['vaPLZ']." ".$value['vaStadt']));
                $data[$counter]['punkte'] = round($value['Punkte']);
                $counter = $counter+1;
            }else if($end <= $heute){
                $remove[$counter2]['id'] = $value['biAngebotsID'];
                $counter2 = $counter2+1;
            }
        }
        if(isset($remove))
        {
            foreach ($remove as $value)
            {
               $sqlresultremove = databaseQuery("CALL DeleteAngebot(".$value['id'].")");
            }
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
                    $sqlresult1 = databaseQuery("CALL GetAllAngeboteArt()");
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
                        <option value="1000">1km</option>
                        <option value="5000">5km</option>
                        <option value="10000">10km</option>
                        <option value="50000">50km</option>
                </select>
                <select id="sortby" name="sortby">
                        <option value="default" selected>---</option>
                        <option value="entfernung">Entfernung</option>
                        <option value="bewertung">Bewertung</option>
                </select>
                <input id="ok" name="ok" type="submit" value="OK" />			
            </form>
            <?php
                if(isset($data))
                    {
                    foreach($data as $value)
                        {
                        $output=preg_replace('/k/','00', $value['entfernung']);
                        $output=preg_replace('/\./','',$output);
                        $output=preg_replace('/m/','',$output);
                        $output=preg_replace('/\s+/','',$output);
                        if(!((!isset($_POST['ok']))||($_POST['entfernung']=="default")||(isset($_POST['ok'])&&($_POST['entfernung']!="default")&&$output<=$_POST['entfernung'])))
                        {
                            unset($data[array_search($value, $data)]);
                            $counter = $counter-1;
                        }
                    }
                }
                if(!isset($data) || count($data)== 0 || $counter == 0)
                {
                    echo "Keine Angebote gefunden.";
                }else
                {
            ?>
            <table id="offers">
                <tr>
                    <th>Unternehmen</th>
                    <th>Branche</th>
                    <th>Zeitraum</th>
                    <th>Freie Pl&auml;tze</th>
                    <th>Entfernung</th>
                    <th>Bewertung</th>
                    <th></th>
                </tr>
                <?php
                    foreach ($data as $value) 
                    {
                        $output=preg_replace('/k/','00', $value['entfernung']);
                        $output=preg_replace('/\./','',$output);
                        $output=preg_replace('/m/','',$output);
                        $output=preg_replace('/\s+/','',$output);
                        if((!isset($_POST['ok']))||($_POST['entfernung']=="default")||(isset($_POST['ok'])&&($_POST['entfernung']!="default")&&$output<=$_POST['entfernung']))
                        {
                            echo "<tr><td><a href='../profiles/company/?id=".$value['id']."'>".$value['name']."</a></td><td>".$value['branche']."</td><td>".$value['zeitraum']."</td><td>".$value['frei']."</td><td>".$value['entfernung']."</td><td>".$value['punkte']."</td><td><a href='mail.php?id=".$value['angebot']."'  target='_blank' rel='noopner'>Bewerben</a></td></tr>";
                        }
                        
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
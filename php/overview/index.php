<?php

	ini_set('include_path', '../utils');
	include_once("site_utils.php");
	include_once("database.php");
        include_once("overview_utils.php");
	IsLoggedIn();
	if(isset($_POST['ok'])){
            
	    if(isset($_POST['branche']) && $_POST['branche'] != "default")
            {
                $sqlextention = "";
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
                            echo "<option value='".$value['vaBrache']."'>".$value['vaBrache']."</option>";
                        }
                    }

                    ?>
                </select>
                <select id="entfernung" name="entfernung">
                        <option value="default" selected>---</option>
                        <option value="1h">100m</option>
                        <option value="5h">500m</option>
                </select>
                <select id="sortby" name="sortby">
                        <option value="default" selected>---</option>
                        <option value="entfernung">Entfernung</option>
                        <option value="bewertung">Bewertung</option>
                </select>
                <input id="ok" name="ok" type="submit" value="OK" />			
            </form>
        </div>
        <script>	
            document.getElementById("branche").style.display = "none";
            document.getElementById("entfernung").style.display = "none";
            document.getElementById("sortby").style.display = "none";
            document.getElementById("ok").style.display = "none";
            var show = true;
        </script>
        <table id="offers">
            <tr>
                <th>Unternehmen</th>
                <th>Branche</th>
                <th>Zeitraum</th>
                <th>Freie Pl&auml;tze</th>
                <th>Entfernung</th>
            </tr>
            <?php
                $sqlresult2 = databaseQuery("CALL GetAllAngebote()");
                foreach ($sqlresult2 as $value) 
                {
                    $start = new DateTime($value['dAnfangsdatum']);
                    $end = new DateTime($value['dEnddatum']);
                    echo "<tr><td>".$value['vaName']."</td><td>".$value['vaAngebots_Art']."</td><td> Vom ".($start->format("d.m.Y"))." bis ".($end->format("d.m.Y"))."</td><td>".($value['iGesuchte_Bewerber']-$value['iAngenommene_Bewerber'])."</td><td>".(GetDistanceFromGoogleAPI(GetAddressFromUser($_SESSION['id']),$value['vaAdresse']." ".$value['vaPLZ']." ".$value['vaStadt']))."</td></tr>";
                }
            ?>
        </table>
    </body>
</html>
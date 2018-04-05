<?php

    include_once "../utils/site_utils.php";
    include_once "admin_utils.php";
    include_once "../utils/database.php";
    IsLoggedIn();
    IsRole("admin");
?>

<?php
 function ShowUser()
 {
		            $sqlresult = databaseQuery("CALL GetAllDeactivatedUser();");
                    if($sqlresult != null)
                    {
						echo '<form action="" method = "post">';
						echo '<table border = "1">';
                        foreach ($sqlresult as $item)
                        {							
						   
                            echo '<tr>
							<td>'.$item['vaNachname'].'</td>
							<td>'.$item['vaVorname'].'</td>
							<td>'.$item['vaAdresse'].'</td>
							<td><button type="submit"  name = "ErlaubUser"  id ="ErlaubUser" value = "'. $item['biUserID'].'">Erlauben</button></td>
							<td><button type="submit"  name = "LoeschenUser"  id  = "LoeschenUser" value = "'. $item['biUserID'].'">Löschen</button></td>
							</tr>';
                        }
						echo '</table>';
						echo '</form>';
                    }			
 }
 
 function ShowCompanies()
 {
	                if(isset($_POST['ErlaubenCompanie'])){$sqlresult = databaseQuery("CALL UpdateStatusUnternehmen(".$_POST['ErlaubenCompanie']." ,'USA' );");}
                    if(isset($_POST['LoeschenCompanie'])){$sqlresult = databaseQuery("CALL DeleteUnternehmen(".$_POST['LoeschenCompanie'].");");}	
					
		            $sqlresult = databaseQuery("CALL GetAllDeactivatedUnternehmen();");
					
                    if($sqlresult != null)
                    {
						echo '<form action="" method = "post">';
						echo '<table border = "1">';
                        foreach ($sqlresult as $item)
                        {							
                            $_POST['CompanieName'] = substr($item['vaName'],12);					
                            echo '<tr>
							<td>'.substr($item['vaName'],12).'</td>
							<td>'.$item['vaPLZ'].'</td>
							<td>'.$item['vaAdresse'].'</td>
							<td>'.$item['vaEmail'].'</td>
							<td><button type="submit"  name = "ErlaubenCompanie"  id ="ErlaubenCompanie" value = "'. $item['biUnternehmensID'].'">Erlauben</button></td>
							<td><button type="submit"  name = "LoeschenCompanie"  id  = "LoeschenCompanie" value = "'. $item['biUnternehmensID'].'">Löschen</button></td>
							</tr>';
                        }
						echo '</table>';
						echo '</form>';
                    }			
 }
 
?>
<html>
    <head>
        <?php
           CreateHead("AdminTools - Benutzer Liste");
        ?>
	
    </head>
    <body>
	       <form action="" method = "post">	
		    <button type="submit"  name = "User"  id ="User" value = "User">User</button>
			<button type="submit"  name = "Unternehmen"  id ="Unternehmen" value = "Unternehmen">Unternehmen</button>
		   </form>
       	<?php
		  
		  if(isset($_POST['User'])){ShowUser();}
		  if(isset($_POST['Unternehmen'])) {ShowCompanies();}		
		  
	      if(isset($_POST['ErlaubUser'])){$sqlresult = databaseQuery("CALL UpdateRoleUser(".$_POST['ErlaubUser'].",'teacher');");}
          if(isset($_POST['LoeschenUser'])){$sqlresult = databaseQuery("CALL DeleteUser(".$_POST['LoeschenUser'].");");}
		  if(isset($_POST['ErlaubenCompanie'])){$sqlresult = databaseQuery("CALL UpdateStatusUnternehmen(".$_POST['ErlaubenCompanie']." ,'USA' );");}
          if(isset($_POST['LoeschenCompanie'])){$sqlresult = databaseQuery("CALL DeleteUnternehmen(".$_POST['LoeschenCompanie'].");");}	
					
		?>
		
    </body>
</html>
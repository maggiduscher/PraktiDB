<?php
    include_once "regis_utils.php";
    include_once "../utils/site_utils.php";
?>
<html>
    <head>
            <?php            
                    CreateHead("Registrierung");
            ?>
    </head>
    <body>
        <div id="main">
            <?php
               $Fehler = Null;
                if(isset($_POST['submit']))
                {
                    if($_COOKIE['type'] == "student" || $_COOKIE['type'] == "teacher" || $_COOKIE['type'] == "company")
                    {
						$Fehler = registerUser($_COOKIE['type']);				
						
						if(count($Fehler)!= 0){
							   Switch($_COOKIE['type'])
							   {
								   case "student":
								    generateFormStudent($Fehler);
								    break;
								
								    case "teacher":
								    generateFormTeacher($Fehler);
								    break;
								
								    case "company":									
								    generateFormCompany($Fehler);
							     	break;
								
								    default:
							     	break;
							    }
							}
						else{
							 //registerUser($_COOKIE['type']);
                             unset($_COOKIE['type']);
                             setcookie('type', null, -1, '/');
						}
						
                    }
					else{Null;}

                }
                if(isset($_POST['submitSelect']))
                {
					
					unset($_COOKIE['type']);
                    setcookie('type', null, -1, '/');
                    $type = $_POST['type'];

                    if($type == "student"){ generateFormStudent(array(Null));}
					else if($type == "company"){generateFormCompany(array(Null));}
					else if($type == "teacher"){generateFormTeacher(array(Null));}
					
					else{ echo "Man! Hast du toll gemacht!";}
                }
				else{if(!(count($Fehler)!= 0)){generateFormSelect();}}
            ?>
            <div>
                <a href="../login/">Du hast schon einen Account? Dann logge dich hier ein!</a>
            </div>
        </div>
        <?php
                CreateFooter();
        ?>
    </body>
</html>
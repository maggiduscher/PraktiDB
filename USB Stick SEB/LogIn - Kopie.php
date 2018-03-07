
<form method ="Post">
Username:<br />
<input type="Text" name ="Username" id="Username" value = <?php if(isset($_COOKIE['Username']))echo $_COOKIE['Username'];?> ><br />
Password:<br />
<input type="Password" name ="Password" id="Password" value = <?php if(isset($_COOKIE['Username'])) echo $_COOKIE['Password'];?> ><br />
Erinnern
<input type="checkbox" name ="Erinnern" id="Erinnern" <?php if(isset($_COOKIE['Username'])) echo 'checked' ?>><br />
<input type="Submit" name="Senden" value="Log In">
</form>
<?php 

session_start();

 if(isset($_POST['Senden']))
 {
     $strUsername=$_POST['Username'];
     $strPassword=$_POST['Password'];
	 
	 
	 
     $servername = "localhost";
     $username = "root";
     $password = "";
     $databasename="helpdesk";

	 
     $dbc=@mysqli_connect($severname,$username,$password,$databasename)
     Or die("Nope ".mysql_error());

	 $stmt = mysqli_stmt_init($dbc);
	 $query = "CALL GetEmailRole(?,?)";
	 if(!mysqli_stmt_prepare($stmt,$query))echo 'SQL FEHLER ';
	 else
	 {
		mysqli_stmt_bind_param($stmt,"ss",$strUsername,$strPassword);
        mysqli_stmt_execute($stmt);	
		$result = mysqli_stmt_get_result($stmt);
		
		$row = mysqli_fetch_array($result);
		
		 if(!is_null($row['vaEMail']))
	      {
			  echo "Log In";
			  if(isset($_POST['Erinnern']))
			  {
				  setcookie("Username",$strUsername,time()+3600);
				  setcookie("Password",$strPassword,time()+3600);
			  }
			  else
			  {
				  setcookie("Username",$strUsername,time()-3600);
				  setcookie("Password",$strPassword,time()-3600);
			  }
			 echo  $row['vaEMail'];
	         $_SESSION['Username'] = $strUsername;
			 $_SESSION['Email'] = $row['vaEMail'];
			 $_SESSION['Role'] = $row['vaRole'];
			 //header('Location: Helpdesk.php');
	      }
		
	 }
	 
	 
     
     // $query="SELECT CheckUser('$strUsername','$strPassword')";
	 //$query="CALL GetEmailRole('$strUsername','$strPassword')";
	 //$query="SELECT * From tbuser Where vaUsername = '$strUsername' and vaPassword = '$strPassword' ";
    /* $response = @mysqli_query($dbc,$query);
	 $response = $query->execute();
      if(!is_null($response))
      {
	    $row=mysqli_fetch_array($response);
	
	      if(!is_null($row['vaEMail']))
	      {
			  echo "Log In";
			  if(isset($_POST['Erinnern']))
			  {
				  setcookie("Username",$strUsername,time()+3600);
				  setcookie("Password",$strPassword,time()+3600);
			  }
			  else
			  {
				  setcookie("Username",$strUsername,time()-3600);
				  setcookie("Password",$strPassword,time()-3600);
			  }
			 echo  $row['vaEMail'];
	         $_SESSION['Username'] = $strUsername;
			 $_SESSION['Email'] = $row['vaEMail'];
			 $_SESSION['Role'] = $row['vaRole'];
			 //header('Location: Helpdesk.php');
	      }
      }
	  else{
		  echo "G";
	  }
	  */
  @mysql_close($dbc);
/*
   $zeiger=fopen('User.txt','a+');
   
   while(!feof($zeiger))
   {
    $Dummy=fgets($zeiger, 4096);
	
	if($strUsername == explode(":", $Dummy)[0] && $strPassword==explode(":", $Dummy)[1] )
	{
	    session_start();
	    $_SESSION['Username']=$strUsername;
		break;
	}	
   }
   fclose($zeiger);
   */
 }
 
?>
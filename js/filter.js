function Filter(){
    
    if(show){
        document.getElementById("branche").style.display = "";
        document.getElementById("entfernung").style.display = "";
        document.getElementById("sortby").style.display = "";
        document.getElementById("ok").style.display = "";
    }else{		
        document.getElementById("branche").style.display = "none";
        document.getElementById("entfernung").style.display = "none";
        document.getElementById("sortby").style.display = "none";
        document.getElementById("ok").style.display = "none";					
    }
    show = !show;
}
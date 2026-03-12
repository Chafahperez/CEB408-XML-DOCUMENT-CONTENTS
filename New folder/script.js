function validateForm(){

let email = document.forms[0]["email"].value;

if(email == ""){
alert("Email is required");
return false;
}

return true;

}
<?php

include("../database/config.php");

$name = $_POST['name'];
$email = $_POST['email'];
$message = $_POST['message'];

$sql = "INSERT INTO contacts(name,email,message)
VALUES('$name','$email','$message')";

if(mysqli_query($conn,$sql)){
echo "Message Sent Successfully";
}else{
echo "Error sending message";
}

?>
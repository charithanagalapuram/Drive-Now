<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script>
 function validateForm(){
	 var customerName =document.forms["myForm"]["custName"].value;
	 var phone = document.forms["myForm"]["phone"].value;	 
	 var password = document.forms["myForm"]["password"].value;
	 if(customerName== ""){
		 
		 alert("Name can't be blank");
		 return false;
	 }
	 
		 else if(phone.length!=10){
		alert("Invalid Number!");
		return false;
		}
		else if(password.length<6){
		alert("Password must be atleast 6 characters long");
		return false;
		}
	
 }

 </script>
<style>

div {
border: 1px solid black;
padding-left: 80px;
}
</style>
<meta charset="ISO-8859-1">
<title>Register</title>
	<link rel="stylesheet" type ="text/css"href="Rstyle.css">
</head>
<center>
<body background="regi.jpg">
	<form name="myForm" action="LoginServlet" onsubmit="return validateForm()" method="post"  >
	<div class="Register">
		
		<h1>SignUp</h1>
		<input type="text" name = "custName" placeholder="customer name" >
		<input type="text" name = "phone" placeholder="phone" >
		<input type="text" name = "email" placeholder="email Id" >
		<input type="password" name = "password" placeholder="password" >
		
		<form name="myForm" action="Register.jsp" onclick="return validateForm()" method="post"  >
		<button onclick = "myfunction()">Signup</button>
		
				</form>
	</div>	 
	</body>
</center>
</html>

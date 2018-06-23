<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script>
 function validateForm(){
	 var customer_name =document.forms["myForm"]["custName"].value;
	 	 
	 var password = document.forms["myForm"]["password"].value;
	 if(customer_name== ""){
		 
		 alert("Name can't be blank");
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
	<link rel="stylesheet" type ="text/css"href="Lstyle.css">
</head>
<center>
<body background="car.jpg">
	<form name="myForm" action="LoginServlet" method="post" onsubmit="return validateForm()" >
	<div class="Login">
		<form name="myForum" action="LoginServlet" method="post" onsubmit="return validateForm()" >
		<h1>Login</h1>
		<input type="text" name = "custName" placeholder="customer name"/>
		<input type="password" name = "password" placeholder="password"/>
		<button class="btn">Submit</button>
		</form>
	</div>	 
	</body>
</center>
</html>
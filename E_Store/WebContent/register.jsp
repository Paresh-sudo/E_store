<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
        pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <link rel="stylesheet" type="text/css" href="css/main.css"/>
    <title>Register</title>
    </head>
    <body>
    <!--  <img width="100" height="100" src="Img/database.jpg" alt="not"/>-->
    <div class="topnav">
	  <a class="active" href="index.jsp">Home</a>
	  <a href="#about">About</a>
	  <a href="login.jsp" style="float:right;">login</a>
	  <a href="register.jsp" style="float:right;">register</a>
	</div>
    
    <center>
    	<form class="form" action="Register" method="post">
    		<h3>Register</h3>
    		<table style="with: 50%">
    			<tr>
    				<td>User Name</td>
    				<td><input required type="text" name="username"/></td>
    			</tr>
    			<tr>
    				<td>Email</td>
    				<td><input required type="email" name="email" /></td>
    			</tr>
    			<tr>
    				<td>Branch</td>
    				<td><input required type="text" name="branchname"/></td>
    			</tr>
    			<tr>
    				<td>Semester</td>
    				<td><input required type="text" name="sem"/></td>
    			</tr>
    			<tr>
    				<td>Mobile No</td>
    				<td><input required type="text" name="mobileno" /></td>
    			</tr>
    			<tr>
    				<td>Password</td>
    				<td><input required type="password" name="pwd"/></td>
    			</tr>
    			<tr>
    				<td>Confirm Password</td>
    				<td><input required type="password" name="cpwd" /></td>
    			</tr>
    		</table>
    		<input type="submit" value="Submit" />
    	</form>
    </center>
    </body>
    </html>
   <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<style>
</style>
   
<%@ page import="java.io.*,java.util.*,java.sql.*"%>  
<%@ page import="javax.servlet.http.*,javax.servlet.*" %> 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
        pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <link rel="stylesheet" type="text/css" href="css/main.css"/>
    <title>Login Form</title>
    </head>
    <body>
    <div class="topnav">
	  <a class="active" href="index.jsp">Home</a>
	  <a href="#about">About</a>
	  <a href="login.jsp" style="float:right;">login</a>
	  <a href="register.jsp" style="float:right;">register</a>
	</div>
	
    <center>
    	<form class="form" action="Login" method="post">
    		<h3>Login</h3>
    		<table style="width: 50%">
    			<tr>
    				<td>Email</td>
    				<td><input required type="email" name="email" /></td>
    			</tr>
    				<tr>
    				<td>Password</td>
    				<td><input required type="password" name="pwd" /></td>
    			</tr>
    		</table>
    		<input type="submit" value="Login" />
    	</form>
    </center>
    </body>
    </html>
   <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<style>
</style>
   
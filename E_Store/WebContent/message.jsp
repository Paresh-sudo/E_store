<%@ page import="java.io.*,java.util.*,java.sql.*"%>  
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>  
 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
        pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel="stylesheet" type="text/css" href="css/main.css"/>
        <title>Message</title>
    </head>
    <body>
 	
	<div class="topnav">
	  <a class="active" href="index.jsp">Home</a>
	  <a href="#about">About</a>
	  
	  <a href="logout.jsp" style="float:right;">logout</a>
	  <a href="profile.jsp" style="float:right;">Profile</a>
	  <a href="addbook.jsp" style="float:right;">Add book</a>
	  <a href="adde_book.jsp" style="float:right;">Add e-book</a>
	  <a href="e_book.jsp" style="float:right;">e-book</a>
	  <form action="index.jsp" method="post">
	      <input type="text" placeholder="Search.." name="search">
	      <button type="submit">Submit</button>
	   </form>
	</div>
        <h3>Result of the operation: ${message}</h3>
    </body>
</html>
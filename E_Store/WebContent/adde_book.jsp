<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
        pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>  
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <link rel="stylesheet" type="text/css" href="css/main.css"/>
    <title>Add e_book page</title>
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
    <!--  <img width="100" height="100" src="Img/database.jpg" alt="not"/>-->
<%
	HttpSession s =  request.getSession(false);
	if(s == null || s.getAttribute("loggedInUser")==null){
		response.sendRedirect("login.jsp");
	}
	else{
		out.print(s.getAttribute("loggedInUser"));
%>	
	<center>
		<form class="form" name="fileform" action="Add_E_book" method="post" enctype="multipart/form-data">
			<h3>Add Book</h3>
			<table style="with: 50%">
				<tr>
					<td>e-Book Name</td>
					<td><input required type="text" name="ebookname"/></td>
				</tr>
				<tr>
					<td>Author Name</td>
					<td><input required type="text" name="authorname" /></td>
				</tr>
				<tr>
					<td>e-Book Code</td>
					<td><input required type="text" name="ebookcode"/></td>
				</tr>
				<tr>
					<td>e-Book_sem</td>
					<td><input required type="text" name="ebooksem"/></td>
				</tr>
				<tr>
					<td colspan="2">
	      			upload pdf:<input type="file" name="photo"  placeholder="Upload book pdf" required/>
					</td>
				</tr>
			</table>
			
			<input type="submit" value="Upload" />
		</form>
	</center>
<% 
	}
%>
    </body>
    </html>
   <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<style>
</style>
   
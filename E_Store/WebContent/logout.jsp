<%@ page import="java.io.*,java.util.*,java.sql.*"%>  
<%@ page import="javax.servlet.http.*,javax.servlet.*" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>  
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>logout page</title>
</head>
<body>
<%
	HttpSession s =  request.getSession(false);
	if(s != null || s.getAttribute("loggedInUser")!=null){
		s.removeAttribute("loggedInUser");
		response.sendRedirect("login.jsp");
	}
%>		
</body>
</html>
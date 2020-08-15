<%@ page import="java.io.*,java.util.*,java.sql.*"%>  
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>  
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>  
<head>  
<title>index page</title> 
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="css/main.css"/>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
</head>  
<body>  

<sql:setDataSource var="db" driver="com.mysql.jdbc.Driver"  
     url="jdbc:mysql://localhost/E_store"  
     user=""  password=""/>  
  
<%
	HttpSession s =  request.getSession(false);
	if(s == null || s.getAttribute("loggedInUser")==null){
		response.sendRedirect("login.jsp");
	}
	else{
		System.out.println("hi");
		int User =(int)s.getAttribute("loggedInUser");
		System.out.println(User);
		//out.println(s.getAttribute("loggedInUser"));
%>		
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
	 <% String search = request.getParameter("search"); 
	 	if(search==null || search.equals("")){
	 	%>
	 		<sql:query dataSource="${db}" var="rs">  
	 		SELECT *  
	 		FROM User  
	 		INNER JOIN Post    
	 		ON User.user_id = Post.user_id ORDER BY Current_Time_Stamp DESC;
	 		</sql:query>  
	 	<% 
	 	}
	 	else{ //out.println(search);
	 	%>
	 		<sql:query dataSource="${db}" var="rs">  
	 		SELECT *  
	 		FROM User  
	 		INNER JOIN Post using (user_id) where 
	 		 <%
	 		 try{
	 		 %>
	 		 	book_name="<%=search%>" or
		 		 user_name="<%=search %>" or
		 		 autor_name="<%=search %>"	
	 		<% 
	 		 }catch(Exception e){
	 			// out.println("wrong book code");
	 		 }
	 		 %>
	 		 ORDER BY Current_Time_Stamp DESC;
	 		</sql:query>
	 	<% 
	 	}
		 %>
	</div>
	   <div class="grid-container1">
	   		<div class="grid-item1" action="/">
	   		
	   			<c:forEach var="table" items="${rs.rows}"> 
	   			<div class="grid-container">
	   				<div class="grid-item" class="block">
	   				<table>
	   					<tr>
	   					<c:set var="season" value="<%=User%>" />
	   					<c:if test="${table.user_id==season}">
						   <td>
	   						<a href="${pageContext.servletContext.contextPath }/deletepost.jsp?postid=${table.post_id}"><input style="background-color:#f00c2e;" type="button" value="Delete" onclick="return confirm('Are you sure you want to delete?')"/></a>
	   						</td>
	   						<td>
	   						<a href="${pageContext.servletContext.contextPath }/addbook.jsp?postid=${table.post_id}"><input style="background-color:#1a1516; color:white;" type="button" value="Update" onclick="return confirm('Are you sure you want to Update?')"/></a>
	   						</td>
						</c:if>
	   						
	   					</tr>
	   					<tr>
	   						<td rowspan="7"><img class="bookimg" src="${pageContext.servletContext.contextPath }/photoServlet?id=${table.post_id}" alt="no"/></td>
	   					</tr>
	   					<tr><td><a class="clicklink" href="${pageContext.servletContext.contextPath }/index.jsp?search=${table.user_name}">${table.user_name}</a></td>
						</tr>
	   					<tr><td><a class="clicklink" href="${pageContext.servletContext.contextPath }/index.jsp?search=${table.book_name}">${table.book_name}</a></td>
						</tr>
						<tr><td><a class="clicklink" href="${pageContext.servletContext.contextPath }/index.jsp?search=${table.Autor_name}">${table.Autor_name}</a></td>
						</tr>
						<tr><td>(+91)${table.mob_no}</td>
						</tr>
						<tr><td>${table.book_condition}%</td>
						</tr>
						<tr>
	   						<td><strike>${table.actual_price}</strike>Rs.&nbsp;
	   						<b>${table.new_price}</b>Rs. (${table.discount}%)
	   						</td>
	   					</tr>
						<tr>
	   						<td>${table.Current_Time_Stamp}</td>
	   					</tr>
	   				</table>
	   			</div> 
	   			</div>
	   		</c:forEach>
	   		
	   		</div>
	   		<div class="grid-item1">
	   			<h1>Outside bar</h1>
	   			<div class="outside_bar">
	   				<table border="3">
	   					<tr><td><a href="#">Latest Updates</a></td></tr>
	   					<tr>
	   					<td>
	   						<select>
	   							<option value="0" disbled>select branch vise</option>
	   							<option value="IT">IT</option>
	   							<option value="CSE">CSE</option>
	   							<option value="EEE">EEE</option>
	   							<option value="ME">ME</option>
	   							<option value="Civil">Civil</option>
	   						</select>
	   					</td></tr>
	   				
	   				</table>
	   			</div>
	   		</div>
	   </div>
 <% 
	}
%>

</body>  
</html>  
<script>
	function func(){
		window.alert(document.getElementById('search'));
	}
</script>
<style>
	.clicklink{
		color:black;
	}
	.bookimg{
		width:150px;
		height:150px;
		border-radius-top-left:20%;
	}
	.outside_bar{
		padding:15%;
	}
	.outside_bar tr{
		margin:10px;
	}
	.block {
		border:1px solid black;
		margin-top:10px;
		
	}
	.block tr{
		margin-top:5px;
	}
	.grid-container {
	  display: inline-grid;
	  grid-template-columns:;
	  grid-column-gap:10px;
	  grid-row-gap:10px;
	  padding: 10px;
	}
	.grid-container1 {
	  display: grid;
	  font-size:15px;
	  grid-template-columns:2fr 1fr;
	  grid-column-gap:10px;
	  grid-row-gap:10px;
	  padding-top:50px;
	   scroll-behavior: smooth;
	  padding: 10px;
	}
	.grid-item {
	  border: 1px solid rgba(0, 0, 0, 0.8);
	  padding: 20px;
	  font-size: 20px;
	  text-align: center;
	}
	
	.grid-item1 {
	  border: 1px solid rgba(0, 0, 0, 0.8);
	  padding: 20px;
	  font-size: 20px;
	  text-align: center;
	}
</style>
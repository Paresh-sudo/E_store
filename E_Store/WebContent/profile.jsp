<%@ page import="java.io.*,java.util.*,java.sql.*"%>  
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>  
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>  
<head>  
<title>profile page</title> 
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
<sql:query dataSource="${db}" var="rs">  
 		SELECT * from User where user_id=<%=User%>;
</sql:query>
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
	   <div class="grid-container1">
	   		<div class="grid-item1" action="/">
	   		
	   			<c:forEach var="table" items="${rs.rows}"> 
	   			<div class="grid-container">
	   				<div class="grid-item" class="block">
	   				<table>
	   					
						<tr>
							<td>Name:-</td>
							<td>${table.user_name}</td>
						</tr>
						<tr>
							<td>Email:-</td>
							<td>${table.email}</td>
						</tr>
						<tr>
							<td>Mobile No:-</td>
	   						<td>${table.mob_no}</td>
	   					</tr>
	   					<tr>
	   						<td>Branch:-</td>
	   						<td>${table.user_branch}</td>
	   					</tr>
	   					<tr>
	   						<td>Semester:-</td>
	   						<td>${table.sem}</td>
	   					</tr>
	   					<tr>
	   						<td>Report:-</td>
	   						<td>${table.report}</td>
	   					</tr>
	   					<tr>
	   						<td>Password:-</td>
	   						<td>${table.pwd}</td>
	   					</tr>
	   					<tr colspan="2">
	   						<td>
	   						<a href="${pageContext.servletContext.contextPath }/updateaccount.jsp?userid=${table.user_id}"><input style="background-color:#1a1516; color:white;" type="button" value="Update Account" onclick="return confirm('Are you sure you want to Update Account?')"/></a>
	   						</td>
	   					</tr>
	   				</table>
	   			</div> 
	   			</div>
	   		</c:forEach>
	   		</div> 
	   	<sql:query dataSource="${db}" var="rs">  
	 		SELECT *  
	 		FROM User  
	 		INNER JOIN Post using(user_id) 
	 		where user_id=<%=User%>
	 		ORDER BY Current_Time_Stamp DESC;
	 	</sql:query> 
	 	
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
	   						<td rowspan="9"><img class="bookimg" src="${pageContext.servletContext.contextPath }/photoServlet?id=${table.post_id}" alt="no"/></td>
	   					</tr>
	   					<tr><td><a class="clicklink" href="${pageContext.servletContext.contextPath }/index.jsp?search=${table.user_name}">${table.user_name}</a></td>
						</tr>
	   					<tr><td><a class="clicklink" href="${pageContext.servletContext.contextPath }/index.jsp?search=${table.book_name}">${table.book_name}</a></td>
						</tr>
						<tr><td><a class="clicklink" href="${pageContext.servletContext.contextPath }/index.jsp?search=${table.Autor_name}">${table.Autor_name}</a></td>
						</tr>
						<tr><td>${table.mob_no}</td>
						</tr>
						<tr><td>${table.book_condition}%</td>
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
	   		
	   	<sql:query dataSource="${db}" var="rs">  
	 		SELECT *  
	 		FROM User  
	 		INNER JOIN e_book using(user_id) 
	 		where user_id=<%=User%>
	 		ORDER BY Current_Time_Stamp DESC;
	 	</sql:query> 
	 	
	 	<c:forEach var="table" items="${rs.rows}"> 
	   			<div class="grid-container">
	   				<div class="grid-item" class="block">
	   				<table>
	   					<tr>
	   					<c:set var="season" value="<%=User%>" />
	   					<c:if test="${table.user_id==season}">
						   <td>
	   						<a href="${pageContext.servletContext.contextPath }/deleteebookpdf.jsp?postid=${table.ebookpost_id}"><input style="background-color:#f00c2e;" type="button" value="Delete" onclick="return confirm('Are you sure you want to delete?')"/></a>
	   						</td>
						</c:if>
	   						
	   					</tr>
	   					<tr>
	   						<td rowspan="2"><a class="clicklink" href="${pageContext.servletContext.contextPath }/E_book?id=${table.ebookpost_id}" alt="no"/><button>Open File</button></td>
	   						<td><a class="clicklink" href="${pageContext.servletContext.contextPath }/e_book.jsp?search=${table.ebook_name}">${table.ebook_name}</a>___
	   						<a class="clicklink" href="${pageContext.servletContext.contextPath }/e_book.jsp?search=${table.autor_name}">${table.autor_name}</a></td>
	   					</tr>
	   				</table>
	   			</div> 
	   			</div>
	   		</c:forEach>
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
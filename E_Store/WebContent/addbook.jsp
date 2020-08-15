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
    <title>Add book page</title>
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


<%
	
	if (request.getParameter("postid")!=null) {
	    // Form was submitted.
	    try{
	    	int postid = Integer.parseInt(request.getParameter("postid"));
		    Connection conn = null;
		    Class.forName("com.mysql.jdbc.Driver").newInstance ();
		    conn = DriverManager.getConnection(
		    "jdbc:mysql://localhost:3306/E_Store", "", "");
		    int id = Integer.parseInt(request.getParameter("postid"));
		    //out.println(id);
		    ResultSet rs = null;
		    Statement st = null;
		    st = conn.createStatement();
		    String sql=" select * from Post where post_id=?";
		    //out.println("yes");
		    PreparedStatement pstmtSave = conn.prepareStatement(sql);
		    pstmtSave.setInt(1, id);
		    rs = pstmtSave.executeQuery();
		    rs.first();
		    //out.println("no");
		    //out.println(rs);
		    //out.println(rs.getString(2));
		    //System.out.println(rs.getString("book_name"));
		 %>
		 	<center>
		<form class="form" name="fileform" action="update_bookinfo?postid=<%=id%>" method="post" enctype="multipart/form-data">
			<h3>Add Book</h3>
			<table style="with: 50%">
				<tr>
					<td>Book Name</td>
					<td><input required type="text" name="bookname" value=<%=rs.getString("book_name")%> /></td>
				</tr>
				<tr>
					<td>Author Name</td>
					<td><input required type="text" name="authorname" value=<%=rs.getString("autor_name")%> /></td>
				</tr>
				<tr>
					<td>Book Code</td>
					<td><input required type="text" name="bookcode" value=<%=rs.getInt("book_code")%> /></td>
				</tr>
				<tr>
					<td>Book_sem</td>
					<td><input required type="text" name="booksem" value=<%=rs.getInt("sem_book")%> /></td>
				</tr>
				<tr>
					<td>Book Condition</td>
					<td><input required type="text" name="condition" value=<%=rs.getInt("book_condition")%> /></td>
				</tr>
				<tr>
					<td>Actual Price</td>
					<td><input required type="text" name="actual_price" value=<%=rs.getInt("actual_price")%> /></td>
				</tr>
				<tr>
					<td>Discount</td>
					<td><input required type="text" name="discount" value=<%=rs.getInt("discount")%> /></td>
				</tr>
				<tr>
					<td colspan="2">
	      			upload book image:<input type="file" name="photo" value=<%=rs.getBlob("book_img")%> placeholder="Upload book Image" required/>
					</td>
				</tr>
			</table>
			
			<input type="submit" value="Upload" />
		</form>
	</center>
		 
		 <% 
	    }catch(Exception e){
	    	System.out.println(e.getMessage());
	    }
	    %>
	    <% 
	    //out.println(postid);
	} else {
%>
	
	<center>
		<form class="form" name="fileform" action="Add_book" method="post" enctype="multipart/form-data">
			<h3>Add Book</h3>
			<table style="with: 50%">
				<tr>
					<td>Book Name</td>
					<td><input required type="text" name="bookname"/></td>
				</tr>
				<tr>
					<td>Author Name</td>
					<td><input required type="text" name="authorname" /></td>
				</tr>
				<tr>
					<td>Book Code</td>
					<td><input required type="text" name="bookcode"/></td>
				</tr>
				<tr>
					<td>Book_sem</td>
					<td><input required type="text" name="booksem"/></td>
				</tr>
				<tr>
					<td>Book Condition</td>
					<td><input required type="text" name="condition" /></td>
				</tr>
				<tr>
					<td>Actual Price</td>
					<td><input required type="text" name="actual_price" /></td>
				</tr>
				<tr>
					<td>Discount</td>
					<td><input required type="text" name="discount"  /></td>
				</tr>
				<tr>
					<td colspan="2">
	      			upload book image:<input type="file" name="photo"  placeholder="Upload book Image" required/>
					</td>
				</tr>
			</table>
			
			<input type="submit" value="Upload" />
		</form>
	</center>
<% 
	}
%>
   
  <%
	}
  %>
    </body>
    </html>
   <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<style>
</style>
   
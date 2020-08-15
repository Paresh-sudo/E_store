<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Deleted</title>
</head>
<body>

<%
try {
Connection conn = null;
Class.forName("com.mysql.jdbc.Driver").newInstance ();
conn = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/E_Store", "", "");
int id = Integer.parseInt(request.getParameter("postid"));
out.println(id);
ResultSet rs = null;
Statement st = null;
st = conn.createStatement();
String sql="delete from e_book where ebookpost_id=?";
PreparedStatement pstmtSave = conn.prepareStatement(sql);
pstmtSave.setInt(1, id);
pstmtSave.executeUpdate();
response.sendRedirect("index.jsp");
} catch (SQLException e) {
System.out.println(e.getMessage());
}

%>
</body>
</html>
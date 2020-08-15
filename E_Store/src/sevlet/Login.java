package sevlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		Connection conn = null;
        Statement stmt = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/E_Store","","");
			stmt = conn.createStatement();
			out.println("connecting");
			String email = request.getParameter("email");
			String pwd = request.getParameter("pwd");
			ResultSet rs = stmt.executeQuery("select * from User");
			int count=0;
			int flag1=0,flag2=1;
			while(rs.next()) {
				int userid = rs.getInt(1);
				String e  = rs.getString(2);
				String p = rs.getString(3);
				System.out.println(e+" "+email);
				System.out.println(p+" "+pwd);
				if(e.equals(email)) {
					flag1=1;
					if(p.equals(pwd)) {
						flag2=1;
						System.out.println("yEs");
//						RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
//
//						request.setAttribute("msg", "Now you login sucessfully!!!");
//						request.setAttribute("user_id",userid);
//						rd.forward(request, response);
						request.getSession().setAttribute("loggedInUser", userid);
						response.sendRedirect("index.jsp");
//						out.println("You login sucessfully!!!");
//						out.println("<html>");
					}
				}
			}
			if(flag1==0 && flag2==0)
					out.println("password not match!!!");
			else if(flag1==0 || flag2==0)
					out.println("register fisrt!!!");
		}catch(Exception e) {
			RequestDispatcher rd = request.getRequestDispatcher("login.jsp");

			request.setAttribute("errormsg", "server down!!!");

			rd.forward(request, response);
			//out.println("Error while connecting database!!!");
//			response.sendRedirect("login.jsp");
		}
		finally {
			try {
				conn.close();
				stmt.close();
			}catch(Exception e) {
				System.out.println(e);
			}
		}
//		doGet(request, response);
	}

}

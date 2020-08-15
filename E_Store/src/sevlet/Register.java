package sevlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
/**
 * Servlet implementation class Register
 */
@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		request.getParameter("");
		PrintWriter out = response.getWriter();
		Connection conn = null;
        Statement stmt = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/E_Store","","");
			stmt = conn.createStatement();
			PreparedStatement ps = conn.prepareStatement("INSERT INTO User VALUES(?,?,?,?,?,?,?,?)");
			
			out.println("connecting");
			String name = request.getParameter("username");
			String branch = request.getParameter("branchname");
			String email = request.getParameter("email");
			String pwd = request.getParameter("pwd");
			String cpwd = request.getParameter("cpwd");
			String mob_no = request.getParameter("mobileno");
			int sem = Integer.parseInt(request.getParameter("sem"));
			int r1 = 0;
			ResultSet total = stmt.executeQuery("select * from User");
			int count=0;
			while(total.next()) {
				count++;
			}
			out.println(count);
			count = count+1;if(pwd.equals(cpwd)){
				ps.setInt(1,count);
				ps.setString(2, email);
				ps.setString(3, pwd);
				ps.setString(4, mob_no);
				ps.setString(5, name);
				ps.setString(6, branch);
				ps.setInt(7, sem);
				ps.setInt(8, r1);
				int result = ps.executeUpdate();
//				out.print(result);
				//response.sendRedirect("login.jsp");
				RequestDispatcher rd = request.getRequestDispatcher("login.jsp");

				request.setAttribute("errormsg", "now you can login!!!");

				rd.forward(request, response);
			}
			else {
				//out.print("Confirm password not match!!!");
				RequestDispatcher rd = request.getRequestDispatcher("register.jsp");

				request.setAttribute("errormsg", "confirm password not match!!!");

				rd.forward(request, response);
			}
		}catch(Exception e) {
//			out.println("Error while connecting database!!!");
			RequestDispatcher rd = request.getRequestDispatcher("register.jsp");

			request.setAttribute("errormsg", "server down!!!");

			rd.forward(request, response);
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

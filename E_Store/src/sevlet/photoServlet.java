package sevlet;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class photoServlet
 */
@WebServlet("/photoServlet")
public class photoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	    final String DB_URL = "jdbc:mysql://localhost:3306/E_Store";
	    final String User = "";
	    final String Password = "";
	    //PrintWriter pw = response.getWriter();
	    //pw.print("hello");
	    //System.out.println("hello");
	    try {
	        Class.forName(JDBC_DRIVER);
	        Connection conn = DriverManager.getConnection(DB_URL, User, Password);

	        PreparedStatement stmt = conn.prepareStatement("select book_img,book_name from Post where post_id=?");
	        stmt.setLong(1, Integer.valueOf(request.getParameter("id")));
	        System.out.println(request.getParameter("id"));
	        ResultSet rs = stmt.executeQuery();
	        if (rs.next()) {
	        //response.getOutputStream().write(rs.getBytes("book_img"));
//	        	String b_n = rs.getString("book_name");
//	        	String fileName = b_n+".jpg";

//                try (FileOutputStream fos = new FileOutputStream(fileName)) {

                    Blob blob = rs.getBlob("book_img");
                    int len = (int) blob.length();
                    
                    byte[] buf = blob.getBytes(1, len);
                    response.setContentType("image/jpg");
                    OutputStream o = response.getOutputStream();
                    o.write(buf);
                    o.flush();
                    o.close();

//                } catch (IOException ex) {
//
//                    System.out.println(ex);
//                }
	        }
	        conn.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
	}

}

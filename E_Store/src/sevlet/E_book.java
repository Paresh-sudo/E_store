package sevlet;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.cj.xdevapi.Statement;

@WebServlet("/E_book")
public class E_book extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	    //PrintWriter pw = response.getWriter();
	    //pw.print("hello");
	    //System.out.println("hello");
	    try {
	        int bookId = Integer.parseInt(request.getParameter("id"));
	        //ResultSet rs = stmt.executeQuery();

	        response.setContentType("application/pdf");
	 
	        response.setHeader("Content-disposition","inline; filename="+bookId+".pdf" );
	 
	        ServletOutputStream sos;
	        Connection  con=null;
	        PreparedStatement pstmt=null;
	         sos = response.getOutputStream();
	         
	 
	           try {
	               Class.forName("com.mysql.jdbc.Driver");
	               con = DriverManager.getConnection("jdbc:mysql://localhost:3306/E_store","","");
	          } catch (Exception e) {
	                     System.out.println(e);
	                     System.exit(0); 
	                          }
	            
	          ResultSet rset=null;
	            try {
	                pstmt = con.prepareStatement("Select ebook_pdf from e_book where ebookpost_id=?");
	                pstmt.setInt(1, bookId);
	                rset = pstmt.executeQuery();
	                if (rset.next())
	                    sos.write(rset.getBytes("ebook_pdf"));
	                else
	                    return;
	                 
	            } catch (SQLException e) {
	                // TODO Auto-generated catch block
	                e.printStackTrace();
	            }
	     
	        sos.flush();
	        sos.close();
	        con.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

}

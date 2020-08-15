package sevlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.*;
import java.sql.*;
import java.io.*;
import java.util.*; 
import java.text.*; 

@MultipartConfig
@WebServlet("/Add_E_book")
public class Add_E_book extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int BUFFER_SIZE = 4096;
    // database connection settings
    private String dbURL = "jdbc:mysql://localhost:3306/E_Store";
    private String dbUser = "";
    private String dbPass = "";

    //naive way to obtain a connection to database
    //this MUST be improved, shown for 
    private Connection getConnection() {
        Connection conn = null;
        try {
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
        } catch (Exception e) {
            //wrapping any exception and rethrowing it
            //inside a RuntimeException
            //so the method is silent to exceptions
            throw new RuntimeException("Failed to obtain database connection.", e);
        }
        return conn;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        //get values of text fields
    	System.out.println("hi");
    	 HttpSession session = request.getSession(false);
    	 if (session == null) {
    		 response.sendRedirect("login.jsp");
    	 }
    	 else {
    	int loginuserid = (int) session.getAttribute("loggedInUser");
    	 final Part filePart = request.getPart("photo");
    	   String bookname = request.getParameter("ebookname").toLowerCase();
	       String authorname = request.getParameter("authorname").toLowerCase();
	       int bookcode = Integer.parseInt(request.getParameter("ebookcode"));
	       int booksem = Integer.parseInt(request.getParameter("ebooksem"));
  
         InputStream pdfFileBytes = null;
         final PrintWriter writer = response.getWriter();
  
         try {
  
           if (!filePart.getContentType().equals("application/pdf"))
             {
                        writer.println("<br/> Invalid File");
                        return;
             }
  
             pdfFileBytes = filePart.getInputStream();  // to get the body of the request as binary data
  
             final byte[] bytes = new byte[pdfFileBytes.available()];
              pdfFileBytes.read(bytes);  //Storing the binary data in bytes array.
  
             Connection  con=null;
              Statement stmt=null;
  
                try {
                      Class.forName("com.mysql.jdbc.Driver");
                      con = DriverManager.getConnection("jdbc:mysql://localhost:3306/E_store","root","paresh123");
                   } catch (Exception e) {
                         System.out.println(e);
                         System.exit(0);
                               }
                
                 int success=0;
                 String sql = "INSERT INTO e_book(ebook_name,autor_name,ebook_code,sem_ebook,ebook_pdf,Current_Time_Stamp,user_id) values (?, ?, ?,?,?,CURRENT_TIMESTAMP,?)";
                 PreparedStatement pstmtSave = con.prepareStatement(sql);
               pstmtSave.setString(1, bookname);
               pstmtSave.setString(2, authorname);
               pstmtSave.setInt(3, bookcode);
               pstmtSave.setInt(4, booksem);
                 pstmtSave.setBytes(5, bytes);
               pstmtSave.setInt(6, loginuserid);
                 success = pstmtSave.executeUpdate();
                 if(success>=1)  System.out.println("Book Stored");
                  con.close(); 
  
                  writer.println("<br/> Book Successfully Stored");
  
         } catch (FileNotFoundException fnf) {
             writer.println("You  did not specify a file to upload");
             writer.println("<br/> ERROR: " + fnf.getMessage());
  
         } catch (SQLException e) {
             // TODO Auto-generated catch block
             e.printStackTrace();
         } finally {
  
             if (pdfFileBytes != null) {
                 pdfFileBytes.close();
             }
             if (writer != null) {
                 writer.close();
             }
         }
  
    }
    	 
    }
}

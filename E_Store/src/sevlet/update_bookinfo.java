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
@WebServlet("/update_bookinfo")
public class update_bookinfo extends HttpServlet {
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
    	PrintWriter out = response.getWriter();
    	//out.println(loginuserid);
    	int postid = Integer.parseInt(request.getParameter("postid"));
//    	PrintWriter out = response.getWriter();
    	//out.println(postid);
//    	HttpSession loggeduser_id =  (HttpSession) request.getSession().getAttribute("loggedInUser");
//    	System.out.println(loggeduser_id);
        String bookname = request.getParameter("bookname");
        String authorname = request.getParameter("authorname");
        int bookcode = Integer.parseInt(request.getParameter("bookcode"));
        int booksem = Integer.parseInt(request.getParameter("booksem"));
        int condition = Integer.parseInt(request.getParameter("condition"));
        int actual_price = Integer.parseInt(request.getParameter("actual_price"));
        int discount = Integer.parseInt(request.getParameter("discount"));
        int new_price = actual_price - (int)(actual_price*discount)/100;
        System.out.println("j");
        InputStream inputStream = null; // input stream of the upload file
        // obtains the upload file part in this multipart request
        Part filePart = request.getPart("photo");
        System.out.println(filePart);
        if (filePart != null) {
            // prints out some information for debugging
        	System.out.println("hellp");
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());

            //obtains input stream of the upload file
            //the InputStream will point to a stream that contains
            //the contents of the file
            inputStream = filePart.getInputStream();
        }
        System.out.println(inputStream);
        Connection conn = null; // connection to the database
        String message = null; // message will be sent back to client
        try {
            // connects to the database
            conn = getConnection();
            // constructs SQL statement
            String sql = "Update post set book_code=?,book_name=?,autor_name=?,sem_book=?,book_img=?,book_condition=?,actual_price=?,discount=?,new_price=?,Current_Time_Stamp=CURRENT_TIMESTAMP,user_id=? where post_id=?";
            //Using a PreparedStatement to save the file
            PreparedStatement pstmtSave = conn.prepareStatement(sql);
            pstmtSave.setInt(1, bookcode);
            pstmtSave.setString(2, bookname);
            pstmtSave.setString(3, authorname);
            pstmtSave.setInt(4, booksem);
            pstmtSave.setInt(6, condition);
            pstmtSave.setInt(7, actual_price);
            pstmtSave.setInt(8, discount);
            pstmtSave.setInt(9, new_price);
            pstmtSave.setInt(10, loginuserid);
            pstmtSave.setInt(11, postid);
            System.out.println("1");
            if (inputStream != null) {
                //files are treated as BLOB objects in database
                //here we're letting the JDBC driver
                //create a blob object based on the
                //input stream that contains the data of the file
            	pstmtSave.setBlob(5, inputStream);
            }
            System.out.println("2");
            //sends the statement to the database server
            int row = pstmtSave.executeUpdate();
            System.out.println("hi");
            if (row > 0) {
                message = "File uploaded and Updated your Data";
            }
            System.out.println("3");
            Statement stmt1 = conn.createStatement();
            int numberRow = 0;
            String query1 = "select count(*) from Post";
            PreparedStatement stt = conn.prepareStatement(query1);
            ResultSet rs = stt.executeQuery();
            while(rs.next()){
                numberRow = rs.getInt("count(*)");
            }
            numberRow+=1;
            System.out.println(numberRow);
            String filepath = "C:\\Users\\paresh panchal\\eclipse-workspace\\E_Store\\Img\\"+bookcode+"_"+bookname+"_"+booksem+"_"+numberRow+".jpg";
            //Obtaining the file from database
            //Using a second statement
            String sql1 = "SELECT book_img FROM Post WHERE post_id=?";
            PreparedStatement pstmtSelect = conn.prepareStatement(sql1);
            pstmtSelect.setInt(1, postid);
            ResultSet result = pstmtSelect.executeQuery();
            if (result.next()) {
                Blob blob = result.getBlob("book_img");
                InputStream inputStream1 = blob.getBinaryStream();
                OutputStream outputStream = new FileOutputStream(filepath);
                int bytesRead = -1;
                byte[] buffer = new byte[BUFFER_SIZE];
                while ((bytesRead = inputStream1.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
                inputStream1.close();
                outputStream.close();
                System.out.println("File saved");
            }
        } catch (SQLException ex) {
            message = "ERROR: " + ex.getMessage();
            ex.printStackTrace();
        } finally {
            if (conn != null) {
                // closes the database connection
                try {
                    conn.close();
                } catch (SQLException ex) {
                    //silent
                }
            }
//             sets the message in request scope
            request.setAttribute("message", message);

            // forwards to the message page
            getServletContext().getRequestDispatcher("/message.jsp")
                .include(request, response);
        }
    }
    } //else
}

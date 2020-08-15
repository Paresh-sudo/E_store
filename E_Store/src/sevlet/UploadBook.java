package sevlet;

import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.*;
import java.sql.*;
import java.io.*;
@MultipartConfig
@WebServlet("/UploadBook")
public class UploadBook extends HttpServlet {
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
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
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
            String sql = "INSERT INTO contacts (first_name, last_name, photo) values (?, ?, ?)";
            //Using a PreparedStatement to save the file
            PreparedStatement pstmtSave = conn.prepareStatement(sql);
            
            pstmtSave.setString(1, firstName);
            pstmtSave.setString(2, lastName);
            System.out.println("1");
            if (inputStream != null) {
                //files are treated as BLOB objects in database
                //here we're letting the JDBC driver
                //create a blob object based on the
                //input stream that contains the data of the file
            	pstmtSave.setBlob(3, inputStream);
            }
            System.out.println("2");
            //sends the statement to the database server
            int row = pstmtSave.executeUpdate();
            System.out.println("hi");
            if (row > 0) {
                message = "File uploaded and saved into database";
            }
            System.out.println("3");
            String filepath = "C:\\Users\\paresh panchal\\eclipse-workspace\\E_Store\\Img\\FromDb.jpg";
            //Obtaining the file from database
            //Using a second statement
            String sql1 = "SELECT photo FROM contacts WHERE first_name=? AND last_name=?";
            PreparedStatement pstmtSelect = conn.prepareStatement(sql1);
            pstmtSelect.setString(1, firstName);
            pstmtSelect.setString(2, lastName);
            ResultSet result = pstmtSelect.executeQuery();
            if (result.next()) {
                Blob blob = result.getBlob("photo");
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

}

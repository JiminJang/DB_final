package clothImage;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DisplayImage
 */
@WebServlet("/DisplayImage")

public class DisplayImage extends HttpServlet {

   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
      
      String id = request.getParameter("id");
      Connection conn = null;
      Statement stmt = null;
      ResultSet rs = null;
      OutputStream output = response.getOutputStream();
      InputStream input = null;

      try {
         Class.forName("com.mysql.jdbc.Driver");
         conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/joy", "root", "1234");
         stmt = conn.createStatement();
         String sql = "SELECT img FROM product where productID=" + id;

         rs = stmt.executeQuery(sql);
         if (rs.next()) {
            input = rs.getBinaryStream(1);
            int byteRead;
            while ((byteRead = input.read()) != -1) {
               output.write(byteRead);
            }
            input.close();
         }
      }catch(Exception e) {
         System.out.println(e);
      }finally {
         try {if (rs != null) rs.close();} catch (Exception ex) {} 
         try {if (stmt != null) stmt.close();} catch (Exception ex) {} 
         try {if (conn != null) conn.close();} catch (Exception ex) {}
      }
      input.close();
      output.flush();
      output.close();
   }
}



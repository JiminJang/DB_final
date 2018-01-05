

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/ImageView")
public class ImageView extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ImageView() {
        super();
        // TODO Auto-generated constructor stub
    }
    

	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
	}


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String imgname=request.getParameter("imgname");
		response.setContentType("image/gif");
		
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		try {
			Class.forName( "com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/joy", "root","1234");
           ps=conn.prepareStatement("select img from product where imgname="+imgname);
           rs=ps.executeQuery();
           if(rs.next()) {
        	   InputStream gif_data=rs.getBinaryStream(1);
        	   ServletOutputStream os=response.getOutputStream();
        	   int c;
        	   while((c=gif_data.read())!=-1) os.write(c);
        	   os.close();
        	   
           }
           rs.close();
           ps.close();
           conn.close();
           
		}catch(ClassNotFoundException e) {
		}
		catch(SQLException e) {
			
		}
		
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

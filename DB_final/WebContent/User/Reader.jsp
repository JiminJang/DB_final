<%@page contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR" errorPage="../DBError.jsp"%>
<%@page import="java.sql.* "%>
<%
	Connection conn = null;
	Statement stmt = null;
	try {
		String id = (String) session.getAttribute("userID");
		String password = (String) session.getAttribute("userPassword");
		System.out.println(id);
		System.out.println(password);
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/joy", "root", "1234");
		if (conn == null)
			throw new Exception("데이터베이스에 연결할 수 없습니다.");
		stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("select * from user where userId='" + id + "';");
		if (!rs.next())
			throw new Exception("해당 데이터가 없습니다.");

		String userName = rs.getString("name");
		String address = rs.getString("address");
		String phoneNum = rs.getString("phoneNum");

		request.setAttribute("NAME", userName);
		request.setAttribute("ID", id);
		request.setAttribute("PASSWORD", password);
		request.setAttribute("ADDRESS", address);
		request.setAttribute("PHONENUM", phoneNum);
	} finally {
		try {
			stmt.close();
		} catch (Exception ignored) {
		}
		try {
			conn.close();
		} catch (Exception ignored) {
		}
	}
	RequestDispatcher dispatcher = request.getRequestDispatcher("Edit.jsp");
	dispatcher.forward(request, response);
%>
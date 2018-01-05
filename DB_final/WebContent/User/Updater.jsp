<%@page contentType="text/html; charset=euc-kr" errorPage="../DBError.jsp"%>
<%@page import="java.sql.* "%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<%
	String name = request.getParameter("name");
	String ID = request.getParameter("id");
	String password = request.getParameter("password");
	String address = request.getParameter("address");
	String phoneNum = request.getParameter("phoneNum");

	Connection conn = null;
	Statement stmt = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/joy", "root", "1234");
		if (conn == null)
			throw new Exception("데이터베이스에 연결할 수 없습니다.");
		stmt = conn.createStatement();
		String command = String.format(
				"update user set name := '%s', userID := '%s', password := '%s', address :='%s',phoneNum :='%s' where userID = '%s';",
				name, ID, password, address, phoneNum, ID);
		int rowNum = stmt.executeUpdate(command);
		if (rowNum < 1)
			throw new Exception("데이터를 DB에 입력할 수 없습니다.");
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
	response.sendRedirect("UpdateResult.jsp?ID=" + ID);
%>

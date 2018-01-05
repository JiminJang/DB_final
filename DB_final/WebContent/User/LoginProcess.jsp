<%@ page language="java" contentType="text/html; charset=EUC-KR" errorPage="../DBError.jsp"%>
<%@ page import="java.sql.*"%>
<%
	String id = request.getParameter("id");
	String password = request.getParameter("password");

	Connection conn = null;
	Statement stmt = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/joy", "root", "1234");
		if (conn == null)
			throw new Exception("데이터베이스에 연결할 수 없습니다.");
		stmt = conn.createStatement();
		ResultSet result = stmt.executeQuery(
				"select userID from user where userID='" + id + "' and password='" + password + "' ;");
		if (!result.next()) {
%>
<script>
	self.window.alert("회원이 아닙니다.");
	location.href("Login.jsp");
</script>
<%
	} else {
			session.setAttribute("userID", id);
			session.setAttribute("userPassword", password);
			response.sendRedirect("../Main.jsp");
		}
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
%>
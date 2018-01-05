<%@ page language="java" contentType="text/html; charset=EUC-KR" errorPage="../DBError.jsp"%>
<%@page import="java.sql.*"%>
<%
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String phoneNum = request.getParameter("phoneNum");
	String address = request.getParameter("address");

	Connection conn = null;
	Statement stmt = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/joy", "root", "1234");
		if (name == null || id == null || password == null || phoneNum == null || address == null)
			throw new Exception("누락된 데이터가 있습니다.");

		if (conn == null)
			throw new Exception("데이터베이스에 연결할 수 없습니다.");

		stmt = conn.createStatement();
		String command = String.format(
				"insert into user(name, userID, password,address,phoneNum) values ( '%s', '%s', '%s','%s','%s');",
				name, id, password, address, phoneNum);
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
	response.sendRedirect("SignUpResult.jsp");
%>
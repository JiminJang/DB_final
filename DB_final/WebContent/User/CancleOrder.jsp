<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@page import="java.sql.*"%>
<%
	String id = (String) session.getAttribute("userID");
	int orderID = Integer.parseInt(request.getParameter("orderID"));

	Connection conn = null;
	Statement stmt = null;

	try {

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/joy", "root", "1234");
		if (conn == null)
			throw new Exception("데이터베이스에 연결할 수 없습니다.");
		stmt = conn.createStatement();
System.out.println(orderID);
		int rowNum = stmt
				.executeUpdate("DELETE FROM joy.order WHERE userID='" + id + "' and orderID=" + orderID + ";");
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
	response.sendRedirect("MyPage.jsp");
%>
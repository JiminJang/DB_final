<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@page import="java.sql.*"%>
<%
	int basketNum = Integer.parseInt(request.getParameter("basketNum"));

	Connection conn = null;
	Statement stmt = null;

	try {

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/joy", "root", "1234");
		if (conn == null)
			throw new Exception("데이터베이스에 연결할 수 없습니다.");
		stmt = conn.createStatement();

		int rowNum = stmt.executeUpdate("DELETE FROM basket WHERE baskNum=" + basketNum + ";");

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
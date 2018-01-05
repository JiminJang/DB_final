<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<%
	Cookie[] cookies = request.getCookies();
%>
<%
	String bid = getCookieValue(cookies, "boardID");
	int boardID = Integer.parseInt(bid);
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/joy", "root", "1234");
	Statement stmt = conn.createStatement();
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/joy", "root", "1234");

	String sql = "delete from board where boardID=?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, boardID);
	pstmt.executeUpdate();

	pstmt.close();
	conn.close();
%>
<%!private String getCookieValue(Cookie[] cookies, String name) {
		String value = null;
		if (cookies == null)
			return null;
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals(name))
				return cookie.getValue();
		}
		return null;
	}%>
<script language=javascript>
 self.window.alert("게시물을 삭제했습니다.");
 location.href="boardList.jsp";
 </script>
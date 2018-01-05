<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" errorPage="../DBError.jsp"%>
<%
	Cookie[] cookies = request.getCookies();
%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<%
	Class.forName("com.mysql.jdbc.Driver");
	request.setCharacterEncoding("euc-kr");
	String writer = getCookieValue(cookies, "writer");

	String title = request.getParameter("title");
	String content = request.getParameter("content");

	try {

		Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/joy", "root", "1234");

		String command = String.format("insert into board(title,content,writer)values(?,?,?)");
		PreparedStatement pstmt = conn.prepareStatement(command);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, writer);

		pstmt.execute();
		pstmt.close();
		conn.close();

	} catch (Exception e) {

		out.println(e.toString());

	}
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
	self.window.alert("입력한 글을 저장하였습니다.");
	location.href = "boardList.jsp";
</script>
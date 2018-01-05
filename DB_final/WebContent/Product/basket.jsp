<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%
	Cookie[] cookies = request.getCookies();
%>
<%
	Class.forName("com.mysql.jdbc.Driver");

	int productID = Integer.parseInt(getCookieValue(cookies, "productID"));
	String productname = getCookieValue(cookies, "productname");

	int number = Integer.parseInt(request.getParameter("number"));
	String userID = (String) session.getAttribute("userID");
	String password = (String) session.getAttribute("password");
	String currentUser = (String) session.getAttribute("userID");

	int newstock = 0;

	if (userID == null) {
%>
<script language=javascript>
self.window.alert("로그인이 필요합니다.");
location.href="../User/Login.jsp?";
</script>
<%
	} else {

		try {

			Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/joy", "root",
					"1234");

			Statement stmt = conn.createStatement();
			PreparedStatement pstmt1 = null;
			ResultSet rs = null;
			pstmt1 = conn.prepareStatement("SELECT stock, sales FROM product WHERE  productID =?");
			pstmt1.setInt(1, productID);
			rs = pstmt1.executeQuery();

			if (!rs.next())
				throw new Exception("해당 데이터가 없습니다.");
			else {
				int stock = rs.getInt(1);
				newstock = stock - number;

				if (newstock < 0) {
%>
<script language=javascript>
			 self.window.alert("재고가 부족합니다. 죄송합니다 .");
			 location.href="../Main.jsp?";
			 </script>
<%
	} else {
					String command = String
							.format("insert into basket(userID, productID, number,date) values(?,?,?,?)");

					PreparedStatement pstmt2 = conn.prepareStatement(command);
					pstmt2.setString(1, userID);
					pstmt2.setInt(2, productID);
					pstmt2.setInt(3, number);
					pstmt2.setTimestamp(4, new java.sql.Timestamp(new java.util.Date().getTime()));

					pstmt2.execute();
					pstmt2.close();
				}
			}

			rs.close();
			stmt.close();

			pstmt1.close();

			conn.close();
%>
<script language=javascript>
	 self.window.alert("장바구니에 담겼습니다 .");
	 location.href="../Main.jsp?";
	 </script>
<%
	} catch (Exception e) {

			out.println(e.toString());

		}
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

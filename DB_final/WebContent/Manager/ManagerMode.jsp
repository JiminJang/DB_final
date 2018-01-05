<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@page import="java.sql.*"%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../style1.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Joy 관리자모드</title>
</head>
<script type="text/javascript">
function check(){
	return confirm("삭제하시겠습니까?");
}
</script>
<body>
	<div id="wrapper">
		<div id="box">
			<div id="header">
				<a href="../Main.jsp"><img src="../images/joy.png" style="float: left; height: 100%;"></a>
				<ul class="nav justify-content-end">
					<li class="nav-item"><a class="nav-link" href="../User/Logout.jsp">로그아웃</a></li>
				</ul>
			</div>
			<div id="menu">
				<nav class="nav flex-column">
					<a class="nav-link" href="../Product/top.jsp">Top</a> <a class="nav-link" href="../Product/bottom.jsp">Bottom</a> <a class="nav-link" href="../Board/boardList.jsp">Board</a>
				</nav>
			</div>
			<div id="content">
				<%
					Connection conn = null;
					Statement stmt = null;

					String id = (String) session.getAttribute("userID");
					String password = (String) session.getAttribute("userPassword");
					System.out.println(id);

					try {
						Class.forName("com.mysql.jdbc.Driver");
						conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/joy", "root", "1234");
						if (conn == null)
							throw new Exception("데이터베이스에 연결할 수 없습니다.");
						stmt = conn.createStatement();
						ResultSet rs = stmt.executeQuery("SELECT * FROM user ;");
				%>
				<h2>회원 목록</h2>
				<table width="70%" cellpadding="0" cellspacing="0" border="0">
					<tr height="1" bgcolor="#82B5DF">
						<td colspan="6" width="752"></td>
					</tr>
					<tr height="5">
						<td width="5"></td>
					</tr>
					<tr height="5" align="center">
						<td width="73">아이디</td>
						<td width="73">비밀번호</td>
						<td width="73">이름</td>
						<td width="73">주소</td>
						<td width="85">핸드폰 번호</td>
						<td width="73">비고</td>
					</tr>
					<tr height="1" bgcolor="#82B5DF">
						<td colspan="6" width="752"></td>
					</tr>
					<%
						while (rs.next()) {
					%><tr height="25" align="center">
						<td><%=rs.getString("userID")%></td>
						<td><%=rs.getString("password")%></td>
						<td><%=rs.getString("name")%></td>
						<td><%=rs.getString("address")%></td>
						<td><%=rs.getString("phoneNum")%></td>
						<td><a href="ManagerUser.jsp?id=<%=rs.getString("userID")%>" onclick="return check();">삭제</a></td>
					</tr>
					<tr height="1" bgcolor="#D2D2D2">
						<td colspan="6"></td>
					</tr>
					<%
						}
							rs.close();
							stmt.close();
							conn.close();
						} catch (SQLException e) {
							out.println(e.toString());
						}
					%>
					<tr height="1" bgcolor="#82B5DF">
						<td colspan="6" width="752"></td>
					</tr>
				</table>
				<br>
				<%
					try {
						Class.forName("com.mysql.jdbc.Driver");
						conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/joy", "root", "1234");
						if (conn == null)
							throw new Exception("데이터베이스에 연결할 수 없습니다.");
						stmt = conn.createStatement();
						ResultSet rs = stmt.executeQuery("SELECT * FROM product ;");
				%>
				<h2>상품 목록</h2>
				<table width="70%" cellpadding="0" cellspacing="0" border="0">
					<tr height="1" bgcolor="#82B5DF">
						<td colspan="7" width="752"></td>
					</tr>
					<tr height="5">
						<td width="5"></td>
					</tr>
					<tr height="5" align="center">
						<td width="73">상품ID</td>
						<td width="73">상품이름</td>
						<td width="73">가격</td>
						<td width="73">재고</td>
						<td width="80">카테고리</td>
						<td width="73">사진</td>
						<td width="73">비고</td>
					</tr>
					<tr height="1" bgcolor="#82B5DF">
						<td colspan="7" width="752"></td>
					</tr>
					<%
						while (rs.next()) {
					%><tr height="25" align="center">
						<td><%=rs.getInt("productID")%></td>
						<td><%=rs.getString("productName")%></td>
						<td><%=rs.getInt("price")%></td>
						<td><%=rs.getInt("stock")%></td>
						<td><%=rs.getString("category")%></td>
						<td><input type="image" src="http://localhost:8080/DB_final/Img?id=<%=rs.getInt("productID")%>" width="50" height="50"></td>
						<td><a href="ManagerProduct.jsp?id=<%=rs.getString("productID")%>" onclick="return check();">삭제</a></td>
					</tr>
					<tr height="1" bgcolor="#D2D2D2">
						<td colspan="7"></td>
					</tr>
					<%
						}
							rs.close();
							stmt.close();
							conn.close();
						} catch (SQLException e) {
							out.println(e.toString());
						}
					%>
					<tr height="1" bgcolor="#82B5DF">
						<td colspan="7" width="752"></td>
					</tr>
				</table>
				<br>
				<%
					try {
						Class.forName("com.mysql.jdbc.Driver");
						conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/joy", "root", "1234");
						if (conn == null)
							throw new Exception("데이터베이스에 연결할 수 없습니다.");
						stmt = conn.createStatement();
						ResultSet rs = stmt.executeQuery("SELECT * FROM joy.order;");
				%>
				<h2>주문 목록</h2>
				<table width="70%" cellpadding="0" cellspacing="0" border="0">
					<tr height="1" bgcolor="#82B5DF">
						<td colspan="6" width="752"></td>
					</tr>
					<tr height="5">
						<td width="5"></td>
					</tr>
					<tr height="5" align="center">
						<td width="73">주문번호</td>
						<td width="90">회원아이디</td>
						<td width="90">상품아이디</td>
						<td width="73">주문수량</td>
						<td width="73">날짜</td>
						<td width="73">비고</td>
					</tr>
					<tr height="1" bgcolor="#82B5DF">
						<td colspan="6" width="752"></td>
					</tr>
					<%
						while (rs.next()) {
					%><tr height="25" align="center">
						<td><%=rs.getInt("orderID")%></td>
						<td><%=rs.getString("userID")%></td>
						<td><%=rs.getString("productID")%></td>
						<td><%=rs.getInt("number")%></td>
						<td><%=rs.getString("date")%></td>
						<td><a href="ManagerOrder.jsp?id=<%=rs.getString("orderID")%>" onclick="return check();">삭제</a></td>
					</tr>
					<tr height="1" bgcolor="#D2D2D2">
						<td colspan="6"></td>
					</tr>
					<%
						}
							rs.close();
							stmt.close();
							conn.close();
						} catch (SQLException e) {
							out.println(e.toString());
						}
					%>
					<tr height="1" bgcolor="#82B5DF">
						<td colspan="6" width="752"></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../style1.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>all</title>
</head>
<body>
	<a href="../Main.jsp"><img src="../images/joy.png" style="float: left; height: 100%;"></a>
				<ul class="nav justify-content-end">
					<%
						String userID = (String) session.getAttribute("userID");
						if (userID == null) {
					%>
					<li class="nav-item">
					<li class="nav-item"><a class="nav-link" href="../User/SignUp.jsp">회원가입</a></li>
					<li class="nav-item">
					<li class="nav-item"><a class="nav-link" href="../User/Login.jsp">로그인</a></li>
					<%
						} else {
					%>
					<li class="nav-item"><a class="nav-link" href="../User/MyPage.jsp">My Page</a></li>
					<li class="nav-item"><a class="nav-link" href="../User/Logout.jsp">로그아웃</a></li>
					<%
						}
					%>
				</ul>
				<form class="search" action="Product/Search.jsp">
					<input type="text" name="search" id="search" size="8" >
					<button type="submit" class="btn btn-secondary btn-sm" style="size: 40%; float: right;">search</button>
				</form>
	<div id="menu">
		<nav class="nav flex-column">
			<a class="nav-link" href="top.jsp">Top</a> <a class="nav-link" href="bottom.jsp">Bottom</a> <a class="nav-link" href="../Board/boardlist.jsp">Board</a>
		</nav>
	</div>
	<div id="content">
		<h2>TOP</h2>
		<div class="row">
			<%
				Blob img = null;
				byte[] imgdata = null;
				Connection conn = null;
				Statement stmt = null;
				ResultSet rs = null;
				String iurl1 = null;
				try {
					Class.forName("com.mysql.jdbc.Driver");
					conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/joy", "root", "1234");
					stmt = conn.createStatement();

					rs = stmt.executeQuery("select id,productName, price, img  from product where category='top'");

					while (rs.next()) {
						int id = rs.getInt(1);
						String productname = rs.getString(2);
						int price = rs.getInt(3);
						img = rs.getBlob(4);
			%>
			<div class="col-sm-1">
				<div class="card" style="width: 20rem;">
					<img class="card-img-top" src="..." alt="Card image cap">
					<div class="card-body">
						<h4 class="card-title"><%=productname%></h4>
						<p class="card-text"><%=price%></p>
						<a href="#" class="btn btn-primary">Go somewhere</a>
					</div>
				</div>
			</div>
			<%
				}
			%>
		</div>
		<h2>bottom</h2>
		<div class="row">
			<%
				ResultSet rs2;
					rs2 = stmt.executeQuery("select id, productname, price, img from product where category='bottom'");
					while (rs2.next()) {
						int id = rs2.getInt(1);
						String productname = rs2.getString(2);
						int price = rs2.getInt(3);
						img = rs2.getBlob(4);
			%>
			<div class="col-sm-1">
				<div class="card" style="width: 20rem;">
					<img class="card-img-top" src="..." alt="Card image cap">
					<div class="card-body">
						<h4 class="card-title"><%=productname%></h4>
						<p class="card-text"><%=price%></p>
						<a href="#" class="btn btn-primary">Go somewhere</a>
					</div>
				</div>
			</div>
			<%
				}
					rs.close();
					rs2.close();
					stmt.close();
					conn.close();
				} catch (SQLException e) {
					out.println(e.toString());
				}
			%>
		</div>
	</div>
</body>
</html>
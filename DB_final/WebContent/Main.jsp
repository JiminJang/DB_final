<%@ page language="java" contentType="text/html; charset=EUC-KR" errorPage="DBError.jsp"%>
<%@page import="java.sql.*"%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="style1.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Joy Main</title>
</head>
<body>
	<div id="wrapper">
		<div id="box">
			<div id="header">
				<a href="Main.jsp"><img src="images/joy.png" style="float: left; height: 100%;"></a>
				<ul class="nav justify-content-end">
					<%
						String id = (String) session.getAttribute("userID");
						if (id == null) {
					%>
					<li class="nav-item">
					<li class="nav-item"><a class="nav-link" href="User/SignUp.jsp">회원가입</a></li>
					<li class="nav-item">
					<li class="nav-item"><a class="nav-link" href="User/Login.jsp">로그인</a></li>
					<%
						} else if (id.equals("admin")) {
					%>
					<li class="nav-item"><a class="nav-link" href="Manager/ManagerMode.jsp">괸리자모드</a></li>
					<li class="nav-item"><a class="nav-link" href="User/Logout.jsp">로그아웃</a></li>
					<%
						} else {
					%>
					<li class="nav-item"><a class="nav-link" href="User/MyPage.jsp">My Page</a></li>
					<li class="nav-item"><a class="nav-link" href="User/Logout.jsp">로그아웃</a></li>
					<%
						}
					%>
				</ul>
				<form class="search" action="Product/Search.jsp">
					<input type="text" name="search" id="search" size="8" >
					<button type="submit" class="btn btn-secondary btn-sm" style="size: 40%; float: right;">search</button>
				</form>
			</div>
			<div id="menu">
				<nav class="nav flex-column">
					<a class="nav-link" href="Product/top.jsp">Top</a> <a class="nav-link" href="Product/bottom.jsp">Bottom</a> <a class="nav-link" href="Board/boardList.jsp">Board</a>
				</nav>
			</div>
			<div id="content">
				<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" style="width: 100%">
					<ol class="carousel-indicators">
						<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
						<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
						<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
					</ol>
					
							<img class="d-block img-fluid" src="images/top_main.png" >
						
					<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev"> <span class="carousel-control-prev-icon" aria-hidden="true"></span> <span class="sr-only">Previous</span>
					</a> <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next"> <span class="carousel-control-next-icon" aria-hidden="true"></span> <span class="sr-only">Next</span>
					</a>
				</div>
				<div id="best">
					<h3 style="text-align: center;">best item</h3>
					<div class="album text-muted">
						<div class="container">
							<div class="row">
								<%
									Connection conn = null;
									Statement stmt = null;
									try {
										int count = 0;
										Class.forName("com.mysql.jdbc.Driver");
										conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/joy", "root", "1234");
										if (conn == null)
											throw new Exception("데이터베이스에 연결할 수 없습니다.");
										stmt = conn.createStatement();
										ResultSet rs = stmt
												.executeQuery("select productID, productName, price from product order by sales desc;");
										while (rs.next() && count < 4) {
											int productID = rs.getInt(1);
											String productname = rs.getString(2);
											int price = rs.getInt(3);
											count++;
								%>
								<a href="Product/productdetail.jsp?productID=<%=productID%>">
									<div class="card" style="margin-left: 10px;">
										<input type="image" src="http://localhost:8080/DB_final/Img?id=<%=productID%>" width="210" height="210">
										<p class="card-text"><%=productname%></p>
										<p class="card-text">
											price:<%=price%>원
										</p>
									</div>
								</a>
								<%
									}
										rs.close();
										stmt.close();
										conn.close();
									} catch (SQLException e) {
										out.println(e.toString());
									}
								%>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
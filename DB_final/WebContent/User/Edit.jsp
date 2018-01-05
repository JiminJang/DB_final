<%@ page language="java" contentType="text/html; charset=EUC-KR" errorPage="../DBError.jsp"%>
<%@page import="java.sql.*"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../style1.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Joy 회원정보수정</title>
</head>
<body>
	<div id="wrapper">
		<div id="box">
			<div id="header">
				<a href="../Main.jsp"><img src="../images/joy.png" style="float: left; height: 100%;"></a>
				<ul class="nav justify-content-end">
					<%
						String id = (String) session.getAttribute("userID");
						if (id == null) {
					%>
					<li class="nav-item">
					<li class="nav-item"><a class="nav-link" href="SignUp.jsp">회원가입</a></li>
					<li class="nav-item">
					<li class="nav-item"><a class="nav-link" href="Login.jsp">로그인</a></li>
					<%
						} else {
					%>
					<li class="nav-item"><a class="nav-link" href="MyPage.jsp">My Page</a></li>
					<li class="nav-item"><a class="nav-link" href="Logout.jsp">로그아웃</a></li>
					<%
						}
					%>
				</ul>
			</div>
			<div id="menu">
				<nav class="nav flex-column">
					<a class="nav-link" href="../Product/product.jsp">All</a> <a class="nav-link" href="../Product/top.jsp">Top</a> <a class="nav-link" href="../Product/bottom.jsp">Bottom</a> <a class="nav-link" href="../Board/boardList.jsp">Board</a>
				</nav>
			</div>
			<div id="content">
			<div id="login" style="margin: 100px; auto; width:60%; border: 1px solid; padding: 100px; border-radius:25px;">
				<h2>회원정보 </h2>
				<FORM NAME="EditForm" ID="EditForm" ACTION=Updater.jsp METHOD=POST>
					이름: <INPUT TYPE=TEXT NAME=name SIZE=5 VALUE='${NAME}' required><BR> 아이디: <INPUT TYPE=TEXT NAME=id SIZE=50 VALUE='${ID}' required> <BR> 비밀번호: <INPUT TYPE=TEXT NAME=password SIZE=20 VALUE='${PASSWORD}'required> <BR> 주소: <INPUT TYPE=TEXT NAME=address SIZE=50 VALUE='${ADDRESS}' required><BR> 휴대폰 번호: <INPUT TYPE=TEXT NAME=phoneNum SIZE=50 VALUE='${PHONENUM}'required><BR> <INPUT TYPE="SUBMIT" class="btn btn-secondary btn-sm" VALUE='수정'>
				</FORM>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
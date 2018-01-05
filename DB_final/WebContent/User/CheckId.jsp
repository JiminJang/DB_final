<%@ page language="java" contentType="text/html; charset=EUC-KR" errorPage="../DBError.jsp"%>
<%@ page import="java.sql.*"%>
<%
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	//id 파라미터의 값을 가져오기
	String id = request.getParameter("id");

	try {
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/joy", "root", "1234");

		if (con == null)
			throw new Exception("데이터베이스에 연결할 수 없습니다.");

		pstmt = con.prepareStatement("select * from user where userID=?");
		pstmt.setString(1, id);
		//아이디가 존재하면 rs.next()가 true를 리턴하고
		//아이디가 존재하지 않는 다면 rs.next()가 false 리턴
		rs = pstmt.executeQuery();
	} catch (Exception e) {
		out.println(e.getMessage());
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Joy 아이디 중복확인</title>
</head>
<body>
<div id="content">	
<%
		//아이디가 중복되었을 때 출력
		if (rs.next()) {
	%>
	현재
	<%=id%>
	사용 불가능
	<br />
	<form method="get" action="CheckId.jsp" id="idCheckForm" onsubmit="return check()">
		아이디:<input type="text" name="id" id="id" /> <input type="submit" value="중복체크" />
	</form>
	<%
		} else if (id == null) {
	%>
	아이디 다시 선택
	<br />
	<form method="get" action="CheckId.jsp" id="idCheckForm" onsubmit="return check()">
		아이디:<input type="text" name="id" id="id" /> <input type="submit" value="중복체크" />
	</form>
	<%
		} else {
	%>
	현재
	<%=id%>
	사용 가능
	<br />
	<form method="get" action="CheckId.jsp" id="idCheckForm">
		<a href="CheckId.jsp">다른 아이디 선택</a><br /> <input type="button" value="현재 아이디 선택" onclick="javascript:checkIdClose('<%=id%>')" />
	</form>
	<%
		}
	%>
	<script>
		function checkIdClose(id) {
			opener.SignUpForm.id.value = id;
			opener.SignUpForm.isCheck.value = "true";
			opener.SignUpForm.password.focus();
	
			window.close();
		}
		function check() {
			var cid = document.getElementById("id").value;
			if (cid == null || cid.length == 0) {
				alert("아이디는 필수 입력입니다.");
				return false;
			}
		}
	</script>
	</div>
</body>
</html>

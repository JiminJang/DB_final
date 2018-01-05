<%@ page language="java" contentType="text/html; charset=EUC-KR" errorPage="../DBError.jsp"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../style1.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Joy 회원가입</title>
</head>
<body>
	<div id="wrapper">
		<div id="box">
			<div id="header">
				<a href="../Main.jsp"><img src="../images/joy.png" style="float: left; height: 100%;"></a>
				<ul class="nav justify-content-end">
					<li class="nav-item">
					<li class="nav-item"><a class="nav-link" href="Login.jsp">로그인</a></li>
				</ul>
			</div>
			<div id="menu">
				<nav class="nav flex-column">
					<a class="nav-link" href="../Product/top.jsp">Top</a> <a class="nav-link" href="../Product/bottom.jsp">Bottom</a> <a class="nav-link" href="../Board/boardList.jsp">Board</a>
				</nav>
			</div>
			<script>
				window.onload = function() {
					document.getElementById("isCheck").value = "false";
					document.getElementById("checkId").onclick = function() {
						var sid = document.getElementById("id").value;
						if (sid == null || sid.length == 0) {
							alert("아이디를 입력하고 검사하세요");
						} else {
							window
								.open("CheckId.jsp?id=" + sid, "",
									"width=300 height=300");
						}
					}
					
					document.getElementById("SignUpForm").onsubmit=function(){
						var isCheck=document.getElementById("isCheck").value;
						if(isCheck != "true"){
							alert("아이디 중복체크를 하지 않았습니다.");
						    return false;
						}
						return true;
					}
					//id 란에 포커스가 오면 중복체크를 다시 하도록 isCheck의 값을 변경
					document.getElementById("id").onblur = function() {
						document.getElementById("isCheck").value = "false";
					}
				}
			</script>
			<div id="content">
			<div id="login">
				<H4>회원 정보를 입력하세요</H4>
				<FORM ID="SignUpForm" ACTION=SignUpProcess.jsp Method=POST>
					<input style="border:none; border-bottom:1px solid;" type="hidden" id="isCheck" /> 아이디:<INPUT TYPE=TEXT NAME=id id="id" style="border:none; border-bottom:1px solid;" required><input type="button" class="btn btn-secondary btn-sm" value="중복확인" id="checkId" /> <BR> 패스워드:<INPUT TYPE=PASSWORD style="border:none; border-bottom:1px solid;" NAME=password id="password" required><BR> 이름:<INPUT TYPE=TEXT style="border:none; border-bottom:1px solid;" NAME=name id="name" required><BR> 전화번호:<INPUT TYPE=TEXT style="border:none; border-bottom:1px solid;" NAME=phoneNum id="phoneNum" required><BR> 주소:<INPUT TYPE=TEXT style="border:none; border-bottom:1px solid;"  NAME=address id="address" required><BR> <INPUT TYPE="SUBMIT" class="btn btn-secondary btn-sm" VALUE='회원가입'> <INPUT TYPE="RESET" class="btn btn-secondary btn-sm" VALUE='취소'>
				</FORM>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
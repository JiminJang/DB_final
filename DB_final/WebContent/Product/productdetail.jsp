<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../style1.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
<title>제품 상세보기</title>
</head>
<body>
	<div id="wrapper">
		<div id="box">
			<div id="header">
				<a href="../Main.jsp"> <input type="image" src="../images/joy.png" style="float: left; height: 100%;"></a>
				<ul class="nav justify-content-end">
					<%
						String id = (String) session.getAttribute("userID");
						if (id == null) {
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
			</div>
			<div id="menu">
				<nav class="nav flex-column">
					<a class="nav-link" href="top.jsp">Top</a> <a class="nav-link" href="bottom.jsp">Bottom</a> <a class="nav-link" href="../Board/boardList.jsp">Board</a>
				</nav>
			</div>
			<div id="content">
				<%
					Class.forName("com.mysql.jdbc.Driver");
					int productID = Integer.parseInt(request.getParameter("productID"));
					try {
						Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/joy", "root", "1234");
						Statement stmt = conn.createStatement();
						String sql = "SELECT productname, price,stock, category,detail from product where productID="
								+ productID;
						ResultSet rs = stmt.executeQuery(sql);

						if (rs.next()) {
							String productname = rs.getString(1);
							int price = rs.getInt(2);
							int stock = rs.getInt(3);
							String category = rs.getString(4);
							String detail = rs.getString(5);
				%>
				<div id="pic">
					<input type="image" src="http://localhost:8080/DB_final/Img?id=<%=productID%>" width="98%">
				</div>
				<div id="detail">
					<h2><%=productname%></h2>
					<%=detail%><br> Price
					<%=price%>
					won <br> <br>
					<form name='productnum' id="productnum" method='post'>
						<div class="value-button" id="decrease" onclick="decreaseValue()" value="Decrease Value">-</div>
						<input type="number" id="number" name="number" value="0" min="1" />
						<div class="value-button" id="increase" onclick="increaseValue()" value="Increase Value">+</div>
						<input type="button" value="buy" onClick='mySubmit(1)' class="btn btn-secondary btn-sm">
						</button>
						<input type="button" value="basket" onClick='mySubmit(2)' class="btn btn-secondary btn-sm">
						</button>
					</form>
					<script type="text/javascript">
	function mySubmit(id){

		var element=document.productnum.number.value;
		var response=confirm("진행하시겠습니까?")
		
		if(element>0){
		if(id==1){
			if(response)
			location.href="buy.jsp?number="+element;
			else return;
		}
	
		if(id==2)
			location.href="basket.jsp?number="+element;
		}else alert("양수를 입력하세요 ");
		
		
	
	}
	</script>
				</div>
			</div>
		</div>
	</div>
	<script>
function increaseValue() {
	  var value = parseInt(document.getElementById('number').value, 10);
	  value = isNaN(value) ? 0 : value;
	  value++;
	  document.getElementById('number').value = value;
	}

	function decreaseValue() {
	  var value = parseInt(document.getElementById('number').value, 10);
	  value = isNaN(value) ? 0 : value;
	  value < 1 ? value = 1 : '';
	  value--;
	  document.getElementById('number').value = value;
	}

window.onload=function(){

	//submit을 눌렀을 때 호출될 함수설정
	document.getElementById('productnum').onsubmit=function(){
		//id값이 없으면 전송하지 않기
		var snum=document.getElementById('number').value;
		if(snum==null ||snum.length==0){
			alert("개수는 필수 입력입니다.");
			return false;
		}else if(snum<0){
			alert("양수를 입력하세요 ");
			return false;
		}
		else if(snum.getClass().getName!="int"){
			alert("숫자를 입력하세요");
			return false;
		}
		return true;
	}
}
</script>
</body>
</html>
<%
	id = Integer.toString(productID);
			response.addCookie(new Cookie("productID", id));
		}
		rs.close();
		stmt.close();
		conn.close();

	} catch (SQLException e) {
	}
%>
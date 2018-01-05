<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	Class.forName("com.mysql.jdbc.Driver");

	int basketNum = Integer.parseInt(request.getParameter("basketNum"));
	String userID = (String) session.getAttribute("userID");

	Connection conn = null;
	Statement stmt = null;

	try {
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/joy", "root", "1234");
		if (conn == null)
			throw new Exception("데이터베이스에 연결할 수 없습니다.");

		stmt = conn.createStatement();
		int productID = 0;
		int number = 0;
		ResultSet result = stmt.executeQuery(
				"select * from basket where userID='" + userID + "' and baskNum=" + basketNum + ";");
		while (result.next()) {
			productID = result.getInt("productID");
			number = result.getInt("number");
		}
		int newstock = 0;

		Statement stmt1 = conn.createStatement();
		PreparedStatement pstmt1 = null;
		ResultSet rs = null;

		pstmt1 = conn.prepareStatement("SELECT stock,sales FROM product WHERE productID =?");
		pstmt1.setInt(1, productID);

		rs = pstmt1.executeQuery();
		if (!rs.next())
			throw new Exception("해당 데이터가 없습니다.");
		else {
			int stock = rs.getInt(1);
			int sales = rs.getInt(2);
			newstock = stock - number;
			if (newstock < 0) {
%>
<script language=javascript>
	self.window.alert("재고가 부족합니다. 죄송합니다 .");
	location.href = "MyPage.jsp?";
</script>
<%
	} else {
				sales += number;
				String sql2 = "update product set stock =" + newstock + " where productID =" + productID;
				stmt.executeUpdate(sql2);
				String command = String
						.format("insert into joy.order (userID, productID, number,date) values (?,?,?,?)");
				PreparedStatement pstmt2 = conn.prepareStatement(command);
				pstmt2.setString(1, userID);
				pstmt2.setInt(2, productID);
				pstmt2.setInt(3, number);
				pstmt2.setTimestamp(4, new java.sql.Timestamp(new java.util.Date().getTime()));

				pstmt2.execute();
				
				Statement stmt2 = conn.createStatement();
				int rowNum = stmt2
						.executeUpdate("DELETE FROM basket WHERE baskNum=" + basketNum + ";");
				pstmt2.close();
			}

		}

		result.close();
		rs.close();
		stmt.close();
		stmt1.close();
		pstmt1.close();
		conn.close();
%>
<script language=javascript>
			 self.window.alert("주문 완료되었습니다 .");
			 location.href="MyPage.jsp?";
			 </script>
<%
	} catch (Exception e) {

		out.println(e.toString());

	}
%>
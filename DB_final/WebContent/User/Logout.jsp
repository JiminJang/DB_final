<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
	session.invalidate();
	response.sendRedirect("../Main.jsp");
%>
<script>
	self.window.alert("로그아웃 되었습니다.");
	location.href("../Main.jsp");
</script>
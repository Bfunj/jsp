<%@page import="config.DBCP"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="bean.Customer"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
List<Customer> cst =null;
	try{
		Connection conn =DBCP.getConnection("dbcp_java1_shop");
		
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT *FROM `customer`");
		
		cst = new ArrayList<>();
		while(rs.next()){
	
			Customer ctm= new Customer();
	
	ctm.setCustid(rs.getString(1));
	ctm.setName(rs.getString(2));
	ctm.setHp(rs.getString(3));
	ctm.setAddr(rs.getString(4));
	ctm.setRdate(rs.getString(5));
	
	cst.add(ctm);			
		}	
		// 6단계
		rs.close();
		stmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>customer::list</title>
</head>
<body>
	<h3>customer 목록</h3>

	<a href="../2_DBCPTest.jsp">처음으로</a>
	<a href="./register.jsp">customer</a>
	<table border="1">
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>휴대폰</th>
			<th>주소</th>
			<th>날짜</th>
			<th>관리</th>
		</tr>
	<%
	for(Customer ctm : cst){
	%>
		<tr>
			<td><%= ctm.getCustid() %></td>
			<td><%= ctm.getName() %></td>
			<td><%= ctm.getHp() %></td>
			<td><%= ctm.getAddr() %></td>
			<td><%= ctm.getRdate().substring(0,10) %></td>
			<td>
				<a href="./modify.jsp?custid=<%= ctm.getCustid() %>">수정</a>
				<a href="./delete.jsp?custid=<%= ctm.getCustid() %>">삭제</a>
			</td>
		</tr>
		<% } %>
		
	</table>

</body>

</html>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="config.DBCP"%>
<%@page import="bean.Customer"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
List<Customer> cst =null;
	try{
		Connection conn =DBCP.getConnection();	//sql 연결
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT *FROM `customer`");	
		
		cst = new ArrayList<>();
		while(rs.next()){
			
		Customer ctm= new Customer();
		ctm.setCusId(rs.getString(1));
		ctm.setName(rs.getString(2));
		ctm.setAddress(rs.getString(3));
		ctm.setPhone(rs.getString(4));

		cst.add(ctm);			
		}	
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
	<title>Customer::list</title>
</head>
<body>
	<h3>고객 목록</h3>

	<a href="../index.jsp">처음으로</a>
	<a href="./register.jsp">고객등록</a>
	<table border="1">
		<tr>
			<th>고객번호</th>
			<th>고객명</th>
			<th>주소</th>
			<th>휴대폰</th>
			<th>관리</th>
		</tr>
	<%
	for(Customer ctm : cst){
	%>
		<tr>
			<td><%= ctm.getCusId() %></td>
			<td><%= ctm.getName() %></td>
			<td><%= ctm.getAddress() %></td>
			<td><%= ctm.getPhone() %></td>
			<td>
				<a href="./modify.jsp?cusId=<%= ctm.getCusId() %>">수정</a>
				<a href="./delete.jsp?cusId=<%= ctm.getCusId() %>">삭제</a>
			</td>
		</tr>
		<% } %>
		
	</table>

</body>

</html>
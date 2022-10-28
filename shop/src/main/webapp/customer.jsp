<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.shop.bean.ShopBean"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="kr.co.shop.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%

	List<ShopBean> shops =null;
	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		String sql ="SELECT *FROM `customer`";
		ResultSet rs = stmt.executeQuery(sql);
		
		shops = new ArrayList<>();
		
		while(rs.next()){
			
			ShopBean sb= new ShopBean();
			
			sb.setCustid(rs.getString(1));
			sb.setName(rs.getString(2));
			sb.setHp(rs.getString(3));
			sb.setAddr(rs.getString(4));
			sb.setRdate(rs.getString(5));
			shops.add(sb);
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
	<title>shop::customer</title>
</head>



<body>
<h3>고객목록</h3>

	<a href="./customer.jsp">고객목록</a>
	<a href="./order.jsp">주문목록</a>
	<a href="./product.jsp">상품목록</a>
	
	<table border="1">
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>휴대폰</th>
			<th>주소</th>
			<th>가입일</th>
		</tr>
			<% for(ShopBean sb : shops){ %>
		<tr>
			<td><%= sb.getCustid() %></td>
			<td><%= sb.getName() %></td>
			<td><%= sb.getHp() %></td>
			<td><%= sb.getAddr() %></td>
			<td><%= sb.getRdate() %></td>
		
		</tr>
		<% } %>
			
	
	</table>


</body>

</html>
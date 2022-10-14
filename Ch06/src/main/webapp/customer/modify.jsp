<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="bean.Customer"%>
<%@page import="config.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String custid = request.getParameter("custid");
	
	// 데이터베이스 처리
	
	Customer ub= null;
	
	try{
		Connection conn =DBCP.getConnection("dbcp_java1_shop");
	//3단계
	Statement stmt = conn.createStatement();
	//4단계
	ResultSet rs = stmt.executeQuery("SELECT * FROM `customer` WHERE `custid`='"+custid+"'");
	//5단계
	if(rs.next()){
		ub = new Customer();
		ub.setCustid(rs.getString(1));
		ub.setName(rs.getString(2));
		ub.setHp(rs.getString(3));
		ub.setAddr(rs.getString(4));
		ub.setRdate(rs.getString(5));
	}
	//6단계
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
	<title>customer::modify</title>
</head>
<body>
	<h3>customer 수정하기</h3>
	<a href="./list.jsp">customer 목록</a>
	<form action="./modifyProc.jsp" method="post">
		<table border="1">
			<tr>
				<td>아이디</td>
				<td><input type="text" name="custid" readonly value="<%=ub.getCustid()  %>"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="name" value="<%=ub.getName()  %>"></td>
			</tr>
			<tr>
				<td>휴대폰</td>
				<td><input type="text" name="hp"  value="<%=ub.getHp()  %>"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" name="addr" value="<%=ub.getAddr()  %>"></td>
			</tr>
			<tr>
				<td>날짜</td>
				<td><input type="text" name="rdate" value="<%=ub.getRdate()  %>"></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
				<input type="submit" value="수정하기">
				</td>
			</tr>
		</table>
	</form>

</body>

</html>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="bean.Customer"%>
<%@page import="config.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cusId = request.getParameter("cusId");
	

	Customer ub= null;
	
	try{
		Connection conn =DBCP.getConnection();

	Statement stmt = conn.createStatement();

	ResultSet rs = stmt.executeQuery("SELECT * FROM `customer` WHERE `cusId`='"+cusId+"'");

	if(rs.next()){
		ub = new Customer();
		ub.setCusId(rs.getString(1));
		ub.setName(rs.getString(2));
		ub.setAddress(rs.getString(3));
		ub.setPhone(rs.getString(4));
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
	<title>book::modify</title>
</head>
<body>
	<h3>book 수정하기</h3>
	<a href="../index.jsp">처음으로</a>
	<a href="./list.jsp">고객 목록</a>
	<form action="./modifyProc.jsp" method="post">
		<table border="1">
			<tr>
				<td>고객번호</td>
				<td><input type="text" name="cusId" readonly value="<%=ub.getCusId()  %>"></td>
			</tr>
			<tr>
				<td>고객명</td>
				<td><input type="text" name="name" value="<%=ub.getName()  %>"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" name="address"  value="<%=ub.getAddress()  %>"></td>
			</tr>
			<tr>
				<td>휴대폰</td>
				<td><input type="text" name="phone" value="<%=ub.getPhone()  %>"></td>
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
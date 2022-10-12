<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="bean.MemberBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String uid = request.getParameter("uid");
	
	// 데이터베이스 처리
		String host= "jdbc:mysql://127.0.0.1:3306/java1db";
		String user= "root";
		String pass= "1234";
	MemberBean ub= null;
	
	try{
	//1단계 생략가능
	
	//2단계
	Connection conn = DriverManager.getConnection(host, user, pass);
	//3단계
	Statement stmt = conn.createStatement();
	//4단계
	ResultSet rs = stmt.executeQuery("SELECT * FROM `member` WHERE `uid`='"+uid+"'");
	//5단계
	if(rs.next()){
		ub = new MemberBean();
		ub.setUid(rs.getString(1));
		ub.setName(rs.getString(2));
		ub.setHp(rs.getString(3));
		ub.setPos(rs.getString(4));
		ub.setDep(rs.getInt(5));
		ub.setRdate(rs.getString(6));
		
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
	<title>member::modify</title>
</head>
<body>
	<h3>member 등록하기</h3>
	<a href="./list.jsp">member 목록</a>
	<form action="./modifyProc.jsp" method="post">
		<table border="1">
			<tr>
				<td>아이디</td>
				<td><input type="text" name="uid" readonly value="<%=ub.getUid()  %>"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="name" value="<%=ub.getName()  %>"></td>
			</tr>
			<tr>
				<td>휴대폰</td>
				<td><input type="text" name="hp" value="<%=ub.getHp()  %>"></td>
			</tr>
			<tr>
				<td>직급</td>
				<td><input type="text" name="pos" value="<%=ub.getPos()  %>"></td>
			</tr>
			<tr>
				<td>부서</td>
				<td><input type="text" name="dep" value="<%=ub.getDep()  %>"></td>
			</tr>
			<tr>
				<td>날짜</td>
				<td><input type="text" name="rdate" value="<%=ub.getRdate()  %>"></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
				<input type="submit" value="등록하기">
				</td>
			</tr>
		</table>
	</form>

</body>

</html>
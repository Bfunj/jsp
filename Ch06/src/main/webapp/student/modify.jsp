<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="bean.StudentBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String stdNo = request.getParameter("stdNo");
	
	// 데이터베이스 처리
		String host= "jdbc:mysql://127.0.0.1:3306/java1_college";
		String user= "root";
		String pass= "1234";
	StudentBean ub= null;
	
	try{
	//1단계 생략가능
	
	//2단계
	Connection conn = DriverManager.getConnection(host, user, pass);
	//3단계
	Statement stmt = conn.createStatement();
	//4단계
	ResultSet rs = stmt.executeQuery("SELECT * FROM `student` WHERE `stdNo`='"+stdNo+"'");
	//5단계
	if(rs.next()){
		ub = new StudentBean();
		ub.setStdNo(rs.getString(1));
		ub.setStdName(rs.getString(2));
		ub.setStdHp(rs.getString(3));
		ub.setStdYear(rs.getInt(4));
		ub.setStdAddress(rs.getString(5));
		
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
	<title>student::modify</title>
</head>
<body>
	<h3>student 수정하기</h3>
	<a href="./list.jsp">student 목록</a>
	<form action="./modifyProc.jsp" method="post">
		<table border="1">
			<tr>
				<td>학번</td>
				<td><input type="text" name="stdNo" readonly value="<%=ub.getStdNo()  %>"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="stdName" value="<%=ub.getStdName()  %>"></td>
			</tr>
			<tr>
				<td>휴대폰</td>
				<td><input type="text" name="stdHp"  value="<%=ub.getStdHp()  %>"></td>
			</tr>
			<tr>
				<td>학년</td>
				<td><input type="text" name="stdYear" value="<%=ub.getStdYear()  %>"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" name="stdAddress" value="<%=ub.getStdAddress()  %>"></td>
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
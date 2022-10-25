
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>
<%@page import="bean.StudentBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%

	// 데이터베이스 처리
	String host= "jdbc:mysql://127.0.0.1:3306/java1_college";
	String user= "root";
	String pass= "1234";
	List<StudentBean> students =null;
	try{
		
	//Connection conn= DB.getInstance().getConnection();
		// 1단계
	Class.forName("com.mysql.cj.jdbc.Driver");
	
	// 2단계
	Connection conn = DriverManager.getConnection(host, user, pass);
	
	

	// 3단계
	Statement stmt = conn.createStatement();
	// 4단계 
	ResultSet rs = stmt.executeQuery("SELECT *FROM `student`");
	// 5단계
	students = new ArrayList<>();
	while(rs.next()){
		
		StudentBean ub= new StudentBean();
		
		ub.setStdNo(rs.getString(1));
		ub.setStdName(rs.getString(2));
		ub.setStdHp(rs.getString(3));
		ub.setStdYear(rs.getInt(4));
		ub.setStdAddress(rs.getString(5));
		
		students.add(ub);
			
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
	<title>student::list</title>
</head>
<body>
	<h3>student 목록</h3>
	<a href="./register.jsp">student 등록하기</a>
	<table border="1">
		<tr>
			<th>학번</th>
			<th>이름</th>
			<th>휴대폰</th>
			<th>학년</th>
			<th>주소</th>
		</tr>
		<% for(StudentBean ub : students){ %>
		<tr>
			<td><%= ub.getStdNo() %></td>
			<td><%= ub.getStdName() %></td>
			<td><%= ub.getStdHp() %></td>
			<td><%= ub.getStdYear() %></td>
			<td><%= ub.getStdAddress() %></td>
			<td>
				<a href="./modify.jsp?stdNo=<%= ub.getStdNo() %>">수정</a>
				<a href="./delete.jsp?stdNo=<%= ub.getStdNo() %>">삭제</a>
			</td>
		</tr>
		<% } %>
	</table>


</body>

</html>
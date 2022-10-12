<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	
	String stdNo =request.getParameter("stdNo");

	
	// 데이터베이스 처리
		String host= "jdbc:mysql://127.0.0.1:3306/java1_college";
		String user= "root";
		String pass= "1234";
	
	try{
		// 1단계
		//Class.forName("com.mysql.cj.jdbc.Driver");
		// 2단계
		Connection conn = DriverManager.getConnection(host, user, pass);
		// 3단계
		String sql = "DELETE FROM `student` WHERE `stdNo`='"+stdNo+"'";
		PreparedStatement psmt = conn.prepareStatement(sql);
		
		// 4단계
		psmt.executeUpdate();
		
		// 5단계
		// 6단계
		psmt.close();
		conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>

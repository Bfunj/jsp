<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	
	String stdNo 	=	request.getParameter("stdNo");
	String stdName =	request.getParameter("stdName");
	String stdHp 	=	request.getParameter("stdHp");
	String stdYear 	=	request.getParameter("stdYear");
	String stdAddress 	=	request.getParameter("stdAddress");
	
	// 데이터베이스 처리
	String host= "jdbc:mysql://127.0.0.1:3306/java1_college";
	String user= "root";
	String pass= "1234";
	try{
		// 1단계
		Class.forName("com.mysql.cj.jdbc.Driver");
		// 2단계
		Connection conn = DriverManager.getConnection(host, user, pass);
		// 3단계
		String sql = "INSERT INTO `student` VALUES(?,?,?,?,?)";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, stdNo);
		psmt.setString(2, stdName);
		psmt.setString(3, stdHp);
		psmt.setString(4, stdYear);
		psmt.setString(5, stdAddress);
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
	
	// 리다이렉트
	response.sendRedirect("./register.jsp");
%>
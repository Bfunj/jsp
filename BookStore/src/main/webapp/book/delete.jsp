<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	// list로부터 받은 id 데이터 저장
	String bookId =request.getParameter("bookId");
	try{
		Connection conn =DBCP.getConnection();	// SQL 연결
		// SQL 명령어 저장
		String sql = "DELETE FROM `book` WHERE `bookId`='"+bookId+"'";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.executeUpdate(); // psmt 동작수행
		psmt.close();
		conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
	}
	response.sendRedirect("./list.jsp");
%>

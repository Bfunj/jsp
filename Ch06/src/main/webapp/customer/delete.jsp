<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	
	String custid =request.getParameter("custid");

	
	
	
	try{
		Connection conn =DBCP.getConnection("dbcp_java1_shop");
		// 3단계
		String sql = "DELETE FROM `customer` WHERE `custid`='"+custid+"'";
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

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cusId =request.getParameter("cusId");
	try{
		Connection conn =DBCP.getConnection();
		String sql = "DELETE FROM `customer` WHERE `cusId`='"+cusId+"'";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.executeUpdate();
		psmt.close();
		conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
	}
	response.sendRedirect("./list.jsp");
%>

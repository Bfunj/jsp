<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="config.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%

	request.setCharacterEncoding("UTF-8");
	String cusId 		=	request.getParameter("cusId");
	String name 	=	request.getParameter("name");
	String address 		=	request.getParameter("address");
	String phone 	=	request.getParameter("phone");	
		try{
			Connection conn =DBCP.getConnection();
			String sql = "INSERT INTO `customer` VALUES(?,?,?,?)";
			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setString(1, cusId);
			psmt.setString(2, name);
			psmt.setString(3, address);
			psmt.setString(4, phone);
	
			psmt.executeUpdate();

			psmt.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		// 리다이렉트
		response.sendRedirect("./list.jsp");
%>
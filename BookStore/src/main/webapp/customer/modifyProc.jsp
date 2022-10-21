<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="bean.Customer"%>
<%@page import="config.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String cusId =	request.getParameter("cusId");
	String name =	request.getParameter("name");
	String address =	request.getParameter("address");
	String phone=	request.getParameter("phone");

	
		try{
			Connection conn =DBCP.getConnection();
		
			String sql = "UPDATE `customer` SET ";
					sql +=	"`name`=?, `address`=?,`phone`=?";
					sql += "WHERE `cusId`=?";
			PreparedStatement psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, name);
			psmt.setString(2, address);
			psmt.setString(3, phone);
			psmt.setString(4, cusId);
		
			psmt.executeUpdate();

			psmt.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
	response.sendRedirect("./list.jsp");


%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="bean.Customer"%>
<%@page import="config.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String custid =	request.getParameter("custid");
	String name =	request.getParameter("name");
	String hp =	request.getParameter("hp");
	String addr=	request.getParameter("addr");

	
		try{
			Connection conn =DBCP.getConnection("dbcp_java1_shop");
			// 3단계
			String sql = "UPDATE `customer` SET `name`=?, `hp`=?, `addr`=?,";
						sql += "WHERE `custid`=?";
			PreparedStatement psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, name);
			psmt.setString(2, hp);
			psmt.setString(3, addr);
			psmt.setString(4, custid);
		
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

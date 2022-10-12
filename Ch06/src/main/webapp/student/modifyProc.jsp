<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
	
		
	request.setCharacterEncoding("UTF-8");
	String stdNo =	request.getParameter("stdNo");
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
			//Class.forName("com.mysql.cj.jdbc.Driver");
			// 2단계
			Connection conn = DriverManager.getConnection(host, user, pass);
			// 3단계
			String sql = "UPDATE `student` SET `stdName`=?, `stdHp`=?, `stdYear`=?,`stdAddress`=?";
						sql += "WHERE `stdNo`=?";
			PreparedStatement psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, stdName);
			psmt.setString(2, stdHp);
			psmt.setString(3, stdYear);
			psmt.setString(4, stdAddress);
			psmt.setString(5, stdNo);
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

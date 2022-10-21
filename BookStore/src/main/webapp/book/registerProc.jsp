<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="config.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// register 로부터 전달 받은 데이터 저장
	request.setCharacterEncoding("UTF-8");
	String bookId 		=	request.getParameter("bookId");
	String bookName 	=	request.getParameter("bookName");
	String publisher 	=	request.getParameter("publisher");
	String price 		=	request.getParameter("price");	
		try{
			Connection conn =DBCP.getConnection();	// SQL 연결
			// SQL명령어 저장
			String sql = "INSERT INTO `book` VALUES(?,?,?,?)";
			PreparedStatement psmt = conn.prepareStatement(sql);
			// PreparedSttement로 선언하여  첫번째 ? 부터 마지막? 까지 순번으로 들어갈 데이터 선언
			psmt.setString(1, bookId);
			psmt.setString(2, bookName);
			psmt.setString(3, publisher);
			psmt.setString(4, price);
	
			psmt.executeUpdate(); // psmt 동작 실행

			psmt.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		// 리다이렉트
		response.sendRedirect("./list.jsp");
%>
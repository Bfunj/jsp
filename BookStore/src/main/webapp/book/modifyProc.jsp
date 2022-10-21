<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="bean.Book"%>
<%@page import="config.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// modify 로부터 데이터 받기
	request.setCharacterEncoding("UTF-8");
	String bookId =	request.getParameter("bookId");
	String bookName =	request.getParameter("bookName");
	String publisher =	request.getParameter("publisher");
	String price=	request.getParameter("price");

		try{
			Connection conn =DBCP.getConnection(); // SQL 연결
		
			// SQL에 요청할 명령어 저장
			String sql = "UPDATE `book` SET `bookName`=?, `publisher`=?,`price`=?";
						sql += "WHERE `bookId`=?";
			PreparedStatement psmt = conn.prepareStatement(sql);
			// PreparedSttement로 선언하여  첫번째 ? 부터 마지막? 까지 순번으로 들어갈 데이터 선언
			psmt.setString(1, bookName);
			psmt.setString(2, publisher);
			psmt.setString(3, price);
			psmt.setString(4, bookId);
			psmt.executeUpdate();	// psmt 동작실행
			psmt.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	response.sendRedirect("./list.jsp");
%>

<%@page import="config.DBCP"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%

	request.setCharacterEncoding("UTF-8");

	String uid 		=	request.getParameter("uid");
	String pass1 		=	request.getParameter("pass1");
	String name 		=	request.getParameter("name");
	String nick 		=	request.getParameter("nick");
	String email 		=	request.getParameter("email");
	String hp 		=	request.getParameter("hp");
	String zip 		=	request.getParameter("zip");
	String addr1 		=	request.getParameter("addr1");
	String addr2 		=	request.getParameter("addr2");
	String regip 		=	request.getRemoteAddr();
	
	
		try{
			
			Connection conn = DBCP.getConnection();
			// 3단계
			String sql = "INSERT INTO  `board_user` (`uid`,`pass`,`name`,`nick`,`email`,`hp`,`zip`,`addr1`,`addr2`,`regip`,`rdate`) VALUES(?,SHA2(?,256),?,?,?,?,?,?,?,?,now())";
			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setString(1, uid);
			psmt.setString(2, pass1);
			psmt.setString(3, name);
			psmt.setString(4, nick);
			psmt.setString(5, email);
			psmt.setString(6, hp);
			psmt.setString(7, zip);
			psmt.setString(8, addr1);
			psmt.setString(9, addr2);
			psmt.setString(10, regip);
		
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
		response.sendRedirect("/JBoard1/user/login.jsp");
%>
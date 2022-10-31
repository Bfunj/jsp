<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String no =request.getParameter("no");

try{
	Connection conn =DBCP.getConnection();

	String sql = "DELETE FROM `board_article` WHERE `no`='"+no+"'";
	PreparedStatement psmt = conn.prepareStatement(sql);

	psmt.executeUpdate();
	

	psmt.close();
	conn.close();
}
catch(Exception e){
	e.printStackTrace();
}

response.sendRedirect("../lsit.jsp");
%>
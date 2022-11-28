<%@page import="kr.co.Farmstory1.dao.UserDao"%>
<%@page import="kr.co.Farmstory1.db.sql"%>
<%@page import="kr.co.Farmstory1.bean.UserBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");	
	String uid = request.getParameter("uid");
	String pass = request.getParameter("pass");
	
	UserBean ub = UserDao.getInstance().selectUser(uid, pass);
	if(ub != null){
		//회원일 경우
		session.setAttribute("sessUser", ub);
		response.sendRedirect("/Farmstory1");
	}else{
		response.sendRedirect("/Farmstory1/user/login.jsp?success=100");
		//회원이 아닌 경우
	}
	
%>
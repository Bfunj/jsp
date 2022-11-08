<%@page import="kr.co.college.bean.RegisterBean"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.co.college.bean.StudentBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.college.db.sql"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.college.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.google.gson.JsonObject"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String stdNo      = request.getParameter("stdNo");
	String stdName      = request.getParameter("stdName");
	String lecNo      = request.getParameter("lecNo");
	

	RegisterBean rb = null;
	try{
		Connection conn = DBCP.getConnection();
		// 트랜잭션 시작
		conn.setAutoCommit(false);
		PreparedStatement psmt = conn.prepareStatement(sql.INSERT_REGISTER);
		Statement stmt =conn.createStatement();
		
		psmt.setString(1, stdNo);
		psmt.setString(2, lecNo);
		psmt.executeUpdate();
		
		ResultSet rs = stmt.executeQuery(sql.SELECT_REGISTER_LATEST);
		
		//작업 확정
		conn.commit();
			
		if(rs.next()) {
			rb= new RegisterBean();
			
			rb.setRegStdNo(rs.getString(1));
			rb.setRegStdNo(rs.getString(1));
			
		}
	
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	/*
	//json 출력
	JsonObject json = new JsonObject();
	json.addProperty("result", 1);
	json.addProperty("lecNo", Lb.getLecNo());
	json.addProperty("lecName", Lb.getLecName());
	json.addProperty("lecCredit", Lb.getLecCredit());
	json.addProperty("lecTime", Lb.getLecTime());
	json.addProperty("lecClass", Lb.getLecClass());
	
	String jsonData = json.toString();
	out.print(jsonData);
	*/

	
%>
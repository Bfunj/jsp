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
<%@page import="kr.co.college.bean.LectureBean"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String stdNo      = request.getParameter("stdNo");
	String stdName  = request.getParameter("stdName");
	String stdHp = request.getParameter("stdHp");
	String stdYear     = request.getParameter("stdYear");
	String stdAddress   = request.getParameter("stdAddress");

	StudentBean Lb = null;
	try{
		
		Connection conn = DBCP.getConnection();		
		// 트랜잭션 시작
		conn.setAutoCommit(false);
		
		PreparedStatement psmt = conn.prepareStatement(sql.INSERT_STUDENT);				
		Statement stmt =conn.createStatement();
		
		psmt.setString(1, stdNo);
		psmt.setString(2, stdName);
		psmt.setString(3, stdHp);
		psmt.setString(4, stdYear);
		psmt.setString(5, stdAddress);
		psmt.executeUpdate();			
		
		ResultSet rs = stmt.executeQuery(sql.SELECT_STUDENT_LATEST);
		
		//작업 확정
		conn.commit();
			
		if(rs.next()) {
			Lb= new StudentBean();
			
			Lb.setStdNo(rs.getString(1));
			Lb.setStdName(rs.getString(2));
			Lb.setStdHp(rs.getString(3));
			Lb.setStdYear(rs.getInt(4));
			Lb.setStdAddress(rs.getString(5));
		}
		
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
		

	//json 출력
	JsonObject json = new JsonObject();
	json.addProperty("result", 1);
	json.addProperty("stdNo", Lb.getStdNo());
	json.addProperty("stdName", Lb.getStdName());
	json.addProperty("stdHp", Lb.getStdHp());
	json.addProperty("stdYear", Lb.getStdYear());
	json.addProperty("stdAddress", Lb.getStdAddress());
	
	String jsonData = json.toString();
	out.print(jsonData);
	
%>
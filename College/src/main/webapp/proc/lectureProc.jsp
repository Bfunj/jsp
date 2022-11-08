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
	String lecNo      = request.getParameter("lecNo");
	String lecName  = request.getParameter("lecName");
	String lecCredit = request.getParameter("lecCredit");
	String lecTime     = request.getParameter("lecTime");
	String lecClass   = request.getParameter("lecClass");

	LectureBean Lb = null;
	try{
		
		Connection conn = DBCP.getConnection();		
		// 트랜잭션 시작
		conn.setAutoCommit(false);
		
		PreparedStatement psmt = conn.prepareStatement(sql.INSERT_LECTURE);				
		Statement stmt =conn.createStatement();
		
		psmt.setString(1, lecNo);
		psmt.setString(2, lecName);
		psmt.setString(3, lecCredit);
		psmt.setString(4, lecTime);
		psmt.setString(5, lecClass);
		psmt.executeUpdate();			
		
		ResultSet rs = stmt.executeQuery(sql.SELECT_LECTURE_LATEST);
		
		//작업 확정
		conn.commit();
			
		if(rs.next()) {
			Lb= new LectureBean();
			
			Lb.setLecNo(rs.getInt(1));
			Lb.setLecName(rs.getString(2));
			Lb.setLecCredit(rs.getInt(3));
			Lb.setLecTime(rs.getInt(4));
			Lb.setLecClass(rs.getString(5));
		}
		
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
		
	//response.sendRedirect("/JBoard1/view.jsp?no="+parent+"&pg="+pg);
	
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
	
%>
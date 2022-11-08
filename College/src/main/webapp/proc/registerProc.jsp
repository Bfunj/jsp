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
	
	List<StudentBean> students = null;
	StudentBean sb = null;
	try{
		students = new ArrayList<>();
		Connection conn = DBCP.getConnection();					
		
		PreparedStatement psmt = conn.prepareStatement(sql.SELECT_STUDENT);
		psmt.setString(1, stdNo);
		ResultSet rs = psmt.executeQuery();
		
		while(rs.next()) {
			sb= new StudentBean();
			
			sb.setStdNo(rs.getString(1));
			sb.setStdName(rs.getString(2));
			sb.setLecName(rs.getString(3));
			sb.setRegStdNo(rs.getString(4));
			sb.setRegLecNo(rs.getInt(5));
			sb.setRegMidScore(rs.getInt(6));
			sb.setRegFinalScore(rs.getInt(7));
			sb.setRegTotalScore(rs.getInt(8));
			sb.setRegGrade(rs.getString(9));
		
			students.add(sb);
		}
		
		rs.close();
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	
	//json 출력
	Gson gson = new Gson();
	String jsonData = gson.toJson(students);
	
	out.print(jsonData);
	
%>
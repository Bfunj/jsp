<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.shop.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// product에서 json객체로 정보 전달
	request.setCharacterEncoding("UTF-8");
	String prodNo = request.getParameter("prodNo");
	String prodCount = request.getParameter("prodCount");
	String prodOrderer = request.getParameter("prodOrderer");
	
	int result = 0 ;
	try{
		Connection conn = DBCP.getConnection();
		String sql = "insert into `order` (`orderid`, `orderproduct`, `ordercount`, `orderdate`) ";
		   sql += "values (?, ?, ?, NOW())";
				
		PreparedStatement psmt= conn.prepareStatement(sql);
		
		psmt.setString(1, prodOrderer);
		psmt.setString(2, prodNo);
		psmt.setString(3, prodCount);
		
		// psmt.executeUpdate가 정상적이라면 1을 아니라면 0 반환
		// sql동작 실행
		result = psmt.executeUpdate();
		psmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	//jsonobject 객체 생성
	JsonObject json = new JsonObject();
	//json data result 결과값 저장
	json.addProperty("result", result);
	
	String jsonData = json.toString();
	
	out.print(jsonData);
%>
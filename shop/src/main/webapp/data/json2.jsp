
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.co.shop.bean.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="kr.co.shop.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%

	List<ProductBean> products =null;
	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		String sql ="SELECT *FROM `product`";
		ResultSet rs = stmt.executeQuery(sql);
		
		products = new ArrayList<>();
		
		while(rs.next()){
			
			ProductBean pb= new ProductBean();
			
			pb.setProdNo(rs.getInt(1));
			pb.setProdName(rs.getString(2));
			pb.setStock(rs.getInt(3));
			pb.setPrice(rs.getInt(4));
			pb.setCompany(rs.getString(5));
			products.add(pb);
		}
		rs.close();
		stmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	//Gson 라이브러리 함수를 이용해 List를 Json으로 변환
	Gson gson = new Gson();
	String jsonData = gson.toJson(products);
	
	out.print(jsonData);
%>
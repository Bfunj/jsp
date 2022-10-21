<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="config.DBCP"%>
<%@page import="bean.Book"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
	List<Book> cst =null; // arraylist 선언
	try{
		Connection conn =DBCP.getConnection();	//sql 연결
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT *FROM `book`");
		//sql에 명령문을 보내고 받은 데이터를 rs에 저장
		
		cst = new ArrayList<>();
		
		while(rs.next()){	// rs의 데이터가 없을때까지
		Book ctm= new Book();// bean
		ctm.setBookId(rs.getString(1));		//rs의 첫번째	
		ctm.setBookName(rs.getString(2));	//rs의 두번쨰
		ctm.setPublisher(rs.getString(3));	//rs의 세번째
		ctm.setPrice(rs.getString(4));		//rs의 네번째
		cst.add(ctm);	// arraylist에서 받아온 위의 데이터를 저장
		}	//rs의 데이터가 없다면 반복문 종료
		rs.close();
		stmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>book::list</title>
</head>
<body>
	<h3>도서 목록</h3>
	<a href="../index.jsp">처음으로</a>
	<a href="./register.jsp">도서등록</a>
	<table border="1">
		<tr>
			<th>도서번호</th>
			<th>도서명</th>
			<th>출판사</th>
			<th>가격</th>
			<th>관리</th>
		</tr>
	<%
	for(Book ctm : cst){ // arraylist에 저장된 rs의 데이터가 null일때까지
	%>
		<tr>
			<td><%= ctm.getBookId() %></td>	
			<td><%= ctm.getBookName() %></td>
			<td><%= ctm.getPublisher() %></td>
			<td><%= ctm.getPrice() %></td>
			<td>
				<a href="./modify.jsp?bookId=<%= ctm.getBookId() %>">수정</a>
				<a href="./delete.jsp?bookId=<%= ctm.getBookId() %>">삭제</a>
			</td>
		</tr>
		<% } %>
		
	</table>

</body>

</html>
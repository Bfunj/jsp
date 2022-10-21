<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="bean.Book"%>
<%@page import="config.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String bookId = request.getParameter("bookId"); // 목록에서 수정버튼을 누른 라인에 있는 id 정보를 받기
	Book ub= null;
	
	try{
		Connection conn =DBCP.getConnection();		//SQL 연결
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM `book` WHERE `bookId`='"+bookId+"'");
		//sql에 명령문을 보내고 받은 데이터를 rs에 저장
		
		if(rs.next()){	// rs의 데이터가 없을때까지
			ub = new Book();	// bean
			ub.setBookId(rs.getString(1));		//rs의 첫번쨰부터 네번째 데이터 저장
			ub.setBookName(rs.getString(2));
			ub.setPublisher(rs.getString(3));
			ub.setPrice(rs.getString(4));
		}
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
	<title>book::modify</title>
</head>
<body>
	<h3>book 수정하기</h3>
	<a href="../index.jsp">처음으로</a>
	<a href="./list.jsp">도서 목록</a>
	<form action="./modifyProc.jsp" method="post">
		<table border="1">
			<tr>
				<td>도서번호</td>
				<td><input type="text" name="bookId" readonly value="<%=ub.getBookId()  %>"></td>
			</tr>
			<tr>
				<td>도서명</td>
				<td><input type="text" name="bookName" value="<%=ub.getBookName()  %>"></td>
			</tr>
			<tr>
				<td>출판사</td>
				<td><input type="text" name="publisher"  value="<%=ub.getPublisher()  %>"></td>
			</tr>
			<tr>
				<td>가격</td>
				<td><input type="text" name="price" value="<%=ub.getPrice()  %>"></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
				<input type="submit" value="수정하기">
				</td>
			</tr>
		</table>
	</form>
</body>

</html>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>customer::list</title>
</head>
<body>
	<h3>고객 목록</h3>

	<a href="../index.jsp">처음으로</a>
	<a href="./register.do">고객등록</a>
	<table border="1">
		<tr>
			<th>고객번호</th>
			<th>고객명</th>
			<th>주소</th>
			<th>휴대폰</th>
			<th>관리</th>
		</tr>
		
		<c:forEach var="customer" items="${customers }">
			<tr>
				<td>${customer.cusId }</td>
				<td>${customer.name}</td>
				<td>${customer.address}</td>
				<td>${customer.phone}</td>
				<td>
					<a href="./modify.do?cusId=${customer.cusId}">수정</a>
					<a href="./delete.do?cusId=${customer.cusId}">삭제</a>
				</td>
			</tr>
		</c:forEach>
	
		
	</table>

</body>

</html>
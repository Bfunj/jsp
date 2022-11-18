<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>book::modify</title>
</head>
<body>
	<h3>book 수정하기</h3>
	<a href="../index.jsp">처음으로</a>
	<a href="./list.do">고객 목록</a>
	<form action="/BookStore2/customer/modify.do" method="post">
		<table border="1">
			<tr>
				<td>고객번호</td>
				<td><input type="text" name="cusId" readonly value="${requestScope.cv.cusId }"></td>
			</tr>
			<tr>
				<td>고객명</td>
				<td><input type="text" name="name" value="${requestScope.cv.name }"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" name="address"  value="${requestScope.cv.address }"></td>
			</tr>
			<tr>
				<td>휴대폰</td>
				<td><input type="text" name="phone" value="${requestScope.cv.phone }"></td>
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
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>book2::modify</title>
</head>
<body>
	<h3>book2 수정하기</h3>
	<a href="../index.jsp">처음으로</a>
	<a href="./list.do">도서 목록</a>
	<form action="/BookStore2/book/modify.do" method="post">
		<table border="1">
			<tr>
				<td>도서번호</td>
				<td><input type="text" name="bookId" readonly value="${requestScope.bv.bookId }"></td>
			</tr>
			<tr>
				<td>도서명</td>
				<td><input type="text" name="bookName" value="${requestScope.bv.bookName }"></td>
			</tr>
			<tr>
				<td>출판사</td>
				<td><input type="text" name="publisher"  value="${requestScope.bv.publisher }"></td>
			</tr>
			<tr>
				<td>가격</td>
				<td><input type="text" name="price" value="${requestScope.bv.price }"></td>
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
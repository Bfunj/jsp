<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>member::register</title>
</head>
<body>
	<h3>member 등록하기</h3>
	<a href="./list.jsp">member 목록</a>
	<form action="./registerProc.jsp" method="post">
		<table border="1">
			<tr>
				<td>아이디</td>
				<td><input type="text" name="uid" placeholder="아이디 입력"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="name" placeholder="이름 입력"></td>
			</tr>
			<tr>
				<td>휴대폰</td>
				<td><input type="text" name="hp" placeholder="휴대폰 입력"></td>
			</tr>
			<tr>
				<td>직급</td>
				<td><input type="text" name="pos" placeholder="직급 입력"></td>
			</tr>
			<tr>
				<td>부서</td>
				<td><input type="text" name="dep" placeholder="부서 입력"></td>
			</tr>
			
			<tr>
				<td colspan="2" align="right">
				<input type="submit" value="등록하기">
				</td>
			</tr>
		</table>
	</form>
	
	<a href="../1_JDBCTest.jsp">목록으로 돌아가기</a>

</body>

</html>
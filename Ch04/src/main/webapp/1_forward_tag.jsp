<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>1_forward_tag</title>
	
	<!-- 
		날짜 : 2022.10.07
		이름 : 백현조
		내용 : JSP forward 액션태그 실습하기
	
	 -->
</head>
<body>
	<h3>forward 액션태그</h3>
	
	<jsp:forward page="./2_include_tag.jsp"></jsp:forward>
	<%	//page.Context.forward("./2_include_tag.jsp");
	 %>

</body>

</html>
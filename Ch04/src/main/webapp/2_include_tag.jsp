<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>2_include_tag</title>
	
	<!-- 
		날짜 : 2022.10.07
		이름 : 백현조
		내용 : JSP include 액션태그 실습하기
		
		include 태그
			- 일반적으로 UI 모듈, 공통 전역 파일을 삽일할 때 사용하는 지시자
			- 동적타임에 삽입(include 지시자는 정적타임에 삽입)

	 -->
</head>
<body>
	<h3>include 액션태그</h3>
	
	<h4>include 지시자</h4>
	<%@ include file="/inc/_header.jsp" %>
	<%@ include file="/inc/_footer.jsp" %>
	<%@ include file="/inc/_config1.jsp" %>
	<%
		out.print("num1 : "+num1+"</br>");
		out.print("num2 : "+num2+"</br>");
		out.print("num3 : "+num3+"</br>");
	%>
	
	<h4>include 태그</h4>
	<jsp:include page="/inc/_header.jsp"/>
	<jsp:include page="/inc/_footer.jsp"/>
	<jsp:include page="/inc/_config2.jsp"/>
	
	<%
	//	var1,var2,var3의 선언 파일(config2)가
	//	동적타임에 include(삽입)되기 때문에 정적타임에 참조가 불가능
	//	out.print("var1 : "+var1+"</br>");
	//	out.print("var2 : "+var2+"</br>");
	//	out.print("var3 : "+var3+"</br>");
	%>
	
	<h4>include 메서드</h4>
	<%
		pageContext.include("/inc/_header.jsp");
		pageContext.include("/inc/_footer.jsp");
	%>
</body>

</html>
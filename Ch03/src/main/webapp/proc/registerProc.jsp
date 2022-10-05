<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// 전송 파라미터 인코딩 설정 : 한글은 데이터를 post로 넘기면 깨짐
	request.setCharacterEncoding("UTF-8");

	//전송 파라미터 수신
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String addr = request.getParameter("addr");
	String gender = request.getParameter("gender");
	String[] hobby = request.getParameterValues("hobby"); // 넘기는 데이터가 여러개 일때

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원가입 처리</title>
	</head>
	<body>
		<h3>회원가입 처리</h3>
		<p>
			이름 : <%=name %><br/>
			생년월일 : <%=birth %><br/>
			주소 : <%=addr %><br/>
			성별 : <%
				if(gender.equals("1")){
					out.print("남자");
				}else out.print("여자");
			%><br/>
			취미 : <%=String.join(", ", hobby) %><br/>
		</p>
	</body>
</html>
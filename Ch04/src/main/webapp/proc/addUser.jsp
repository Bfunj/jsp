<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>register</title>
</head>
<body>
	<h3>useBean 액션태그</h3>
	
	<%
		request.setCharacterEncoding("UTF-8");
	
		String name = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
		String hp = request.getParameter("hp");
		String addr = request.getParameter("addr");
		
	%>
	
	<jsp:useBean id="u2b" class="bean.UserBean2">
		<jsp:setProperty property="name" name="u2b"/>
		<jsp:setProperty property="age" name="u2b"/>
		<jsp:setProperty property="hp" name="u2b"/>
		<jsp:setProperty property="addr" name="u2b"/>
	
	</jsp:useBean>
	
	<p>
		이름 : <%= u2b.getName() %> <br/>
		나이 : <%=  u2b.getAge()%> <br/>
		휴대폰 : <%=  u2b.getHp()%> <br/>
		주소 : <%=  u2b.getHp()%> <br/>
	</p>
	

</body>

</html>
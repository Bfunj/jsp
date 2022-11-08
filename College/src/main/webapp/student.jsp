<%@page import="kr.co.college.db.sql"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="kr.co.college.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.college.bean.StudentBean"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>


	<%

	List<StudentBean> Students = null;
	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql.SELECT_STUDENTS);
			
		Students = new ArrayList<>();		
		while(rs.next() ){
			
			StudentBean Sb= new StudentBean();		
			Sb.setStdNo(rs.getString(1));
			Sb.setStdName(rs.getString(2));
			Sb.setStdHp(rs.getString(3));
			Sb.setStdYear(rs.getInt(4));
			Sb.setStdAddress(rs.getString(5));
			
			
			Students.add(Sb);
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
	<title>Insert title here</title>
</head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<script>
	$(function(){
		$('.btnOrder').click(function(){
			$('section').show();
		});
		$('.btnClose').click(function(){
			$('section').hide();
		});
		
		$('input[type=submit]').click(function(){
			
			let stdNo		=$('input[name=stdNo]').val();
			let stdName	=$('input[name=stdName]').val();
			let stdHp	=$('input[name=stdHp]').val();
			let stdYear	=$('input[name=stdYear]').val();
			let stdAddress	=$('input[name=stdAddress]').val();
				
			let jsonData = {
					"stdNo":stdNo,
					"stdName":stdName,
					"stdHp":stdHp,
					"stdYear":stdYear,
					"stdAddress":stdAddress
			};				
			$.ajax({		
				url:'/College/proc/StudentProc.jsp',
				type:'POST',
				data:jsonData,		
				dataType:'json',
				success:function(data){				
					let lecture = "<tr>";
						lecture += "<td>"+data.stdNo+"</td>";
						lecture += "<td>"+data.stdName+"</td>";
						lecture += "<td>"+data.stdHp+"</td>";
						lecture += "<td>"+data.stdYear+"</td>";
						lecture += "<td>"+data.stdAddress+"</td>";
						lecture += "</tr>";
						$('.commentList').append(lecture);
				}
			});
			
		});
	
		
	});
</script>


<body>
<h3>학생관리</h3>
	<a href="./lecture.jsp">강좌관리</a>
	<a href="./register.jsp">수강관리</a>
	<a href="./student.jsp">학생관리</a>

	<h4>학생목록</h4>
	<button class="btnOrder" value="">등록</button>
			
	<table border="1" class="commentList">
		<tr >
			<th>학번</th>
			<th>이름</th>
			<th>휴대폰</th>
			<th>학년</th>
			<th>주소</th>
		</tr>
			<% for(StudentBean Sb : Students){ %>
		<tr>
			<td><%= Sb.getStdNo() %></td>
			<td><%= Sb.getStdName() %></td>
			<td><%= Sb.getStdHp() %></td>
			<td><%= Sb.getStdYear() %></td>
			<td><%= Sb.getStdAddress() %></td>
			</tr>
		<% } %>
		
		
		</table>
		
		
		<section style="display:none">
		<h4>학생등록</h4>				
		
			<button class="btnClose">닫기</button>		
		<table border="1">
			<tr>
				<td>학번</td>
				<td><input type="text" name="stdNo" ></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="stdName"></td>
			</tr>
			<tr>
				<td>휴대폰</td>
				<td><input type="text" name="stdHp"></td>
			</tr>
			<tr>
				<td>학년</td>
				<td><input type="text" name="stdYear"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" name="stdAddress"></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="추가">
				</td>
			</tr>
		</table>
	
	
	</section>


</body>

</html>
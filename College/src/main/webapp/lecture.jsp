<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.college.bean.LectureBean"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.college.db.sql"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="kr.co.college.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%

	List<LectureBean> Lectures = null;
	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql.SELECT_LECTURE);
	
		Lectures = new ArrayList<>();		
		while(rs.next() ){		
			LectureBean Lb= new LectureBean();		
			Lb.setLecNo(rs.getInt(1));
			Lb.setLecName(rs.getString(2));
			Lb.setLecCredit(rs.getInt(3));
			Lb.setLecTime(rs.getInt(4));
			Lb.setLecClass(rs.getString(5));		
			Lectures.add(Lb);
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
	<title>Lecture</title>
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
					
			let lecNo		=$('input[name=lecNo]').val();
			let lecName	=$('input[name=lecName]').val();
			let lecCredit	=$('input[name=lecCredit]').val();
			let lecTime	=$('input[name=lecTime]').val();
			let lecClass	=$('input[name=lecClass]').val();
				
			let jsonData = {
					"lecNo":lecNo,
					"lecName":lecName,
					"lecCredit":lecCredit,
					"lecTime":lecTime,
					"lecClass":lecClass
			};				
			$.ajax({		
				url:'/College/proc/lectureProc.jsp',
				type:'POST',
				data:jsonData,		
				dataType:'json',
				success:function(data){				
					let lecture = "<tr>";
						lecture += "<td>"+data.lecNo+"</td>";
						lecture += "<td>"+data.lecName+"</td>";
						lecture += "<td>"+data.lecCredit+"</td>";
						lecture += "<td>"+data.lecTime+"</td>";
						lecture += "<td>"+data.lecClass+"</td>";
						lecture += "</tr>";
						$('.commentList').append(lecture);
				}
			});
			
		});
	});
</script>


<body>
	<h3>????????????</h3>
	<a href="./lecture.jsp">????????????</a>
	<a href="./register.jsp">????????????</a>
	<a href="./student.jsp">????????????</a>

	<h4>????????????</h4>
	<button class="btnOrder" value="">??????</button>
			
	<table border="1" class="commentList">
		<tr >
			<th>??????</th>
			<th>?????????</th>
			<th>??????</th>
			<th>??????</th>
			<th>?????????</th>
		</tr>
		<% for(LectureBean Lb : Lectures){ %>
		<tr>
			<td><%= Lb.getLecNo() %></td>
			<td><%= Lb.getLecName() %></td>
			<td><%= Lb.getLecCredit() %></td>
			<td><%= Lb.getLecTime() %></td>
			<td><%= Lb.getLecClass() %></td>
			</tr>
		<% } %>
		
		
		</table>
		
		
		<section style="display:none">
		<h4>????????????</h4>				
		
			<button class="btnClose">??????</button>		
		<table border="1">
			<tr>
				<td>??????</td>
				<td><input type="text" name="lecNo" ></td>
			</tr>
			<tr>
				<td>?????????</td>
				<td><input type="text" name="lecName"></td>
			</tr>
			<tr>
				<td>??????</td>
				<td><input type="text" name="lecCredit"></td>
			</tr>
			<tr>
				<td>??????</td>
				<td><input type="text" name="lecTime"></td>
			</tr>
			<tr>
				<td>?????????</td>
				<td><input type="text" name="lecClass"></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="??????">
				</td>
			</tr>
		</table>
	
	
	</section>

	
</body>

</html>
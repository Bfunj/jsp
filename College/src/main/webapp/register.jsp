<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.college.db.sql"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="kr.co.college.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.college.bean.LectureBean"%>
<%@page import="java.util.List"%>
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
		
		// 학생 검색
		$('input[value=검색]').click(function(){
			
			let stdNo	=$('input[name=stdNo]').val();
			
			let jsonData = {
					"stdNo":stdNo				
			};			
			console.log('jsonData : '+jsonData);
			
			$.ajax({	
				url:'/College/proc/registerProc.jsp',
				type:'POST',
				data:jsonData,
				dataType:'json',
				success:function(data){
					for(let students of data){
					let lecture = "<tr>";
						lecture += "<td>"+students.stdNo+"</td>";
						lecture += "<td>"+students.stdName+"</td>";
						lecture += "<td>"+students.lecName+"</td>";
						lecture += "<td>"+students.regLecNo+"</td>";
						lecture += "<td>"+students.regMidScore+"</td>";
						lecture += "<td>"+students.regFinalScore+"</td>";
						lecture += "<td>"+students.regTotalScore+"</td>";
						lecture += "<td>"+students.regGrade+"</td>";
						lecture += "</tr>";						
						$('.commentList').append(lecture);
					}
				}
			});
			
		});
		
		//수강 등록
		
		$('input[value=신청]').click(function(){
			
			let stdNo2	=$('input[name=stdNo2]').val();
			let stdName	=$('input[name=stdName]').val();
			let lecNo	=$('select[name=lecNo]').val();
			 
			let jsonData = {
					"stdNo":stdNo2,		
					"stdName":stdName,		
					"lecNo":lecNo		
			};			
			console.log('jsonData : '+jsonData);
			
			$.ajax({	
				url:'/College/proc/registerProc2.jsp',
				type:'POST',
				data:jsonData,
				dataType:'json',
				success:function(data){
					for(let students of data){
					let lecture = "<tr>";
						lecture += "<td>"+students.stdNo+"</td>";
						lecture += "<td>"+students.stdName+"</td>";
						lecture += "<td>"+students.lecName+"</td>";
						lecture += "<td>"+students.regLecNo+"</td>";
						lecture += "<td>"+students.regMidScore+"</td>";
						lecture += "<td>"+students.regFinalScore+"</td>";
						lecture += "<td>"+students.regTotalScore+"</td>";
						lecture += "<td>"+students.regGrade+"</td>";
						lecture += "</tr>";						
						$('.commentList').append(lecture);
					}
				}
			});
			
		});
	});
</script>

<body>
 <h3>수강관리</h3>
 
	<a href="./lecture.jsp">강좌관리</a>
	<a href="./register.jsp">수강관리</a>
	<a href="./student.jsp">학생관리</a>

	<h4>수강현황</h4>
	<input type="text" name="stdNo" placeholder="학번을 입력해주세요.">
	<input type="submit" value="검색">
	<button class="btnOrder" value="">수강신청</button>
			
	<table border="1" class="commentList">
		<tr >
			<th>학번</th>
			<th>이름</th>
			<th>강좌명</th>
			<th>강좌코드</th>
			<th>중간시험</th>
			<th>기말시험</th>
			<th>총점</th>
			<th>등급</th>
		</tr>
		
	</table>
	
	
	<section style="display:none">
		<h4>수강신청</h4>				
		
			<button class="btnClose">닫기</button>		
		<table border="1">
			<tr>
				<td>학번</td>
				<td><input type="text" name="stdNo2" ></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="stdName"></td>
			</tr>
			<tr>
				<td>신청강좌</td>
				<td>
					<select name="lecCredit">
						
						<% for(LectureBean Sb : Lectures){ %>
								<option value="<%= Sb.getLecNo() %>"><%= Sb.getLecName() %></option>
							<% } %>
					</select>				
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="신청">
				</td>
			</tr>
		</table>
		</section>
</body>

</html>
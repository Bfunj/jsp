<%@page import="kr.co.shop.bean.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="kr.co.shop.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%

	List<ProductBean> products =null;
	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		String sql ="SELECT *FROM `product`";
		ResultSet rs = stmt.executeQuery(sql);
		
		products = new ArrayList<>();
		
		while(rs.next()){
			
			ProductBean pb= new ProductBean();
			
			pb.setProdNo(rs.getInt(1));
			pb.setProdName(rs.getString(2));
			pb.setStock(rs.getInt(3));
			pb.setPrice(rs.getInt(4));
			pb.setCompany(rs.getString(5));
			products.add(pb);
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
	<title>product::shop</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(function(){
		$('.btnOrder').click(function(){
			let prodNo = $(this).val();
			$('section').show().find('input[name=prodNo]').val(prodNo);
		});
		$('.btnClose').click(function(){
			$('section').hide();
		});
		
		// 최종 주문하기 버튼
		$('input[type=submit]').click(function(){
			alert("주문 진행 중");
			
			// name = "아무이름" name이 아무이름으로 지정된 input의 .val 값을 변수에 저장
			let prodNo		=$('input[name=prodNo]').val();
			let prodCount	=$('input[name=prodCount]').val();
			let prodOrderer	=$('input[name=prodOrderer]').val();
			
			// 저장된 변수를 json객체에 저장
			let jsonData = {
					"prodNo":prodNo,
					"prodCount":prodCount,
					"prodOrderer":prodOrderer
			};
			// json이 잘 생성되었는지 확인
			console.log('jsonData : '+jsonData);
			
			$.ajax({
				// ./registerProc.jsp로 jsonData를 전송
				// jsonData의 정보는 input의 name 
				url:'./registerProc.jsp',
				type:'POST',
				data:jsonData,
				
				// registerProc로 부터 받는 dataType은 json
				dataType:'json',
				success:function(data){
					// registerProc로 부터 받은 data의 result 값이 1인지 아닌지
					if(data.result ==1){
						alert("주문 완료 !");
					}
					else{
						alert("주문 실패 ");
					}
					
				}
			});
			
		});
		
	});
</script>


<body>
<h3>상품목록</h3>

	<a href="./customer.jsp">고객목록</a>
	<a href="./order.jsp">주문목록</a>
	<a href="./product.jsp">상품목록</a>
	
	<table border="1">
		<tr>
			<th>상품번호</th>
			<th>상품명</th>
			<th>재고량</th>
			<th>가격</th>
			<th>제조사</th>
			<th>주문</th>
		</tr>
		<% for(ProductBean pb : products){ %>
		<tr>
			<td><%= pb.getProdNo() %></td>
			<td><%= pb.getProdName() %></td>
			<td><%= pb.getStock() %></td>
			<td><%= pb.getPrice() %></td>
			<td><%= pb.getCompany() %></td>
			<td><button class="btnOrder" value="<%= pb.getProdNo()%>">주문</button></td>
			</tr>
		<% } %>
	</table>
	
	
	<section style="display:none">
	
		<h3>주문하기</h3>
		<table border="1">
			<tr>
				<td>상품번호</td>
				<td><input type="text" name="prodNo" readonly></td>
			</tr>
			<tr>
				<td>수량</td>
				<td><input type="text" name="prodCount"></td>
			</tr>
			<tr>
				<td>주문자</td>
				<td><input type="text" name="prodOrderer"></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="등록하기">
				</td>
			</tr>
		</table>
		<button class="btnClose">닫기</button>
	
	</section>

	
	

</body>

</html>
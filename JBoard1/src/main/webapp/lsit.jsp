<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.jboard1.bean.articleBean"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
List<articleBean> artiB =null;

try{
	Connection conn = DBCP.getConnection();
	
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("SELECT *FROM `board_article`");
	
	artiB = new ArrayList<>();
	while(rs.next()){
		
		articleBean ab = new articleBean();
		ab.setNo(rs.getInt(1));
		ab.setTitle(rs.getString(5));
		ab.setHit(rs.getInt(8));
		ab.setUid(rs.getString(9));
		ab.setRdate(rs.getString(11));
		
		artiB.add(ab);			
	}	

	rs.close();
	stmt.close();
	conn.close();
	
}catch(Exception e){
	e.printStackTrace();
}
%>



<%@ include file="./_header.jsp" %>
<main id="board" class="list">
         
                <table border="0">
                    <caption>글목록</caption>
                    <tbody>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>글쓴이</th>
                            <th>날짜</th>
                            <th>조회</th>
                        </tr>
                      
			                        
			          <% for(articleBean ab : artiB){ %>
					<tr>
						<td><%= ab.getNo() %></td>
						<td><a href="./view.jsp?no=<%= ab.getNo() %>"><%= ab.getTitle() %></a></td>
						<td><%= ab.getUid() %></td>
						<td><%= ab.getRdate() %></td>
						<td><%= ab.getHit() %></td>
					
			
					</tr>
					<% } %>
			                    
                    </tbody>
                </table>
            

            <div class="page">
                <a href="#" class="prev">이전</a>
                <a href="#" class="num current">1</a>
                <a href="#" class="num">2</a>
                <a href="#" class="num">3</a>
                <a href="#" class="next">다음</a>
            </div>
            <a href="/JBoard1/write.jsp" class="btnWrite">글쓰기</a>
        </main>
<%@ include file="./_footer.jsp" %>
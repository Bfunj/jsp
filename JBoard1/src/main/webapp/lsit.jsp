<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.sql"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.jboard1.bean.articleBean"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String pg = request.getParameter("pg");

	int start = 0;
	int total = 0;
	int lastPageNum=0;
	int currentPage=1;
	int currentPageGroup=1;
	int PageGroupStart=0;
	int PageGroupEnd=0;
	int pageStartNum=0;
	
	if(pg != null){
		currentPage=Integer.parseInt(pg);
	}
	
	
	
	start=(currentPage -1)*10;
	currentPageGroup =(int) Math.ceil(currentPage/10.0);
	PageGroupStart = ( currentPageGroup - 1 )*10 +1;
	PageGroupEnd =currentPageGroup*10;
	
	ArticleDAO dao =ArticleDAO.getInstance();
	
	//전체 게시물 갯수
	total = dao.selectCountTotal();
	pageStartNum= total -start;
	//마지막 페이지 번호
	if(total % 10 == 0){
		lastPageNum =total/10;
	}else{
		lastPageNum= total/10+1;
	}
	
	if(PageGroupEnd > lastPageNum){
		PageGroupEnd = lastPageNum;
	}
	
	List<articleBean> artiB = dao.selectArticles(start);
	
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
						<td><%= pageStartNum-- %></td>
						<td><a href="./view.jsp?no=<%= ab.getNo() %>"><%= ab.getTitle() %></a></td>
						<td><%= ab.getNick() %></td>
						<td><%= ab.getRdate().substring(2,10) %></td>
						<td><%= ab.getHit() %></td>							
					</tr>
					<% } %>
			                    
                    </tbody>
                </table>
            
            <div class="page">
            	<%if(PageGroupStart > 1){ %>
                <a href="/JBoard1/lsit.jsp?pg=<%= PageGroupStart-1 %>" class="prev">이전</a>
                <%} %>
                <%for(int num = PageGroupStart; num <=PageGroupEnd; num++){ %>
                <a href="/JBoard1/lsit.jsp?pg=<%= num %>" class="num <%= (num == currentPage) ? "current":"off"%>"><%= num%></a>
               <%} %>
               
          		<%if(PageGroupEnd < lastPageNum){ %>
                <a href="/JBoard1/lsit.jsp?pg=<%= PageGroupEnd+1 %>" class="next">다음</a>
        		<%} %>
            </div>
            <a href="/JBoard1/write.jsp" class="btnWrite">글쓰기</a>
        </main>
<%@ include file="./_footer.jsp" %>
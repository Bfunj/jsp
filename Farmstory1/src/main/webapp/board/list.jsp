<%@page import="kr.co.Farmstory1.bean.ArticleBean"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.Farmstory1.dao.ArticleDao"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/_header.jsp" %>
<%
	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	pageContext.include("./_"+group+".jsp");
	
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
	
	ArticleDao dao =ArticleDao.getInstance();
	
	//전체 게시물 갯수
	total = dao.selectCountTotal(cate);
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
	
	List<ArticleBean> artiB = dao.selectArticles(start, cate);
%>

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
			          <% for(ArticleBean ab : artiB){ %>
					<tr>
						<td><%= pageStartNum-- %></td>					
						<td><a href="/Farmstory1/board/view.jsp?no=<%= ab.getNo() %>&pg=<%= currentPage%>&group=<%= group %>&cate=<%= cate %>"><%= ab.getTitle() %></a></td>
						<td><%= ab.getNick() %></td>
						<td><%= ab.getRdate().substring(2,10) %></td>
						<td><%= ab.getHit() %></td>							
					</tr>
					<% } %>
			                    
                    </tbody>
                </table>
            
            <div class="page">
            	<%if(PageGroupStart > 1){ %>
                <a href="/Farmstory1/board/list.jsp?pg=<%= PageGroupStart-1 %>&group=<%= group %>&cate=<%= cate%>" class="prev">이전</a>
                <%} %>
                <%for(int num = PageGroupStart; num <=PageGroupEnd; num++){ %>
                <a href="/Farmstory1/board/list.jsp?pg=<%= num %>&group=<%= group %>&cate=<%= cate%>" class="num <%= (num == currentPage) ? "current":"off"%>"><%= num%></a>
               <%} %>
               
          		<%if(PageGroupEnd < lastPageNum){ %>
                <a href="/Farmstory1/board/list.jsp?pg=<%= PageGroupEnd+1 %>&group=<%= group %>&cate=<%= cate%>" class="next">다음</a>
        		<%} %>
            </div>
            <%if(sessUser != null){ %>
           <a href="./write.jsp?group=<%= group %>&cate=<%= cate %>" class="btnWrite">글쓰기</a>
       	<%} %>
        </main>
        
<%@ include file="/_footer.jsp" %>" %>
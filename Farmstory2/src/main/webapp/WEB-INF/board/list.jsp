<%@page import="kr.co.Farmstory2.VO.ArticleVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.Farmstory2.dao.ArticleDao"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../_header.jsp"/>
<jsp:include page="./_${group}.jsp"/>

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
                                
				<c:forEach var="ab" items="${artiB}">
				
                	<tr>
                    	<td>${pageStartNum =pageStartNum-1 }</td>
                     	<td><a href="/Farmstory2/board/view.do?no=${ab.no }&pg=${currentPage }&group=${group}&cate=${cate}">${ab.title} </a></td>
						<td>${ab.nick }</td>
						<td>${ab.rdate.substring(2,10) }</td>
						<td>${ab.hit }</td>
                    </tr>  
                 </c:forEach>
			</tbody>
	</table>
            <div class="page">
            	<c:if test="${PageGroupStart > 1 }">
            		<a href="/Farmstory2/board/list.do?pg=${PageGroupStart-1}&group=${group}&cate=${cate}" class="prev">이전</a>
            	</c:if>	
                <c:forEach var="num" begin="${pageGroupStart }" end="${pageGroupEnd }" step="1">  
                	<a href="/Farmstory2/board/list.do?pg=${num}&group=${group}&cate=${cate}" class="num  ${num eq currentPage ? 'current':'off' }">${num}</a>
                </c:forEach>    
        		<c:if test="${PageGroupEnd < lastPageNum }">
            		<a href="/Farmstory2/board/list.do?pg=${PageGroupEnd+1}&group=${group}&cate=${cate}" class="next">이전</a>
            	</c:if>
            </div>
            <c:if test="${sessUser.uid ne null }">        
          	 <a href="/Farmstory2/board/write.do?group=${group}&cate=${cate}" class="btnWrite">글쓰기</a> 
			</c:if> 
       
        </main>
        
<jsp:include page="../_footer.jsp"/>
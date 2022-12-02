<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../_header.jsp"/>
<jsp:include page="./_${group}.jsp"/>
<script src="/Farmstory2/js/comment.js"> </script>
<main id="board" class="view">
            <table>
                <caption>글보기</caption>
                 
                <tr>
                    <th>제목</th>
                    
                    <td><input type="text" value="${ab.title }" name= "title"  readonly ></td>
                </tr>
                
                <tr>
                    <th>파일</th>
                    	<c:if test="${ab.file eq 1 }">
                    		 <td><a href="/Farmstory2/board/download.do?fno=${ab.fno }">${ab.oriName} </a>&nbsp;<span>${ab.download }</span>회 다운로드</td>
                    	</c:if>
                </tr>
               
                <tr>
                    <th>내용</th>
                    <td><textarea name="content"readonly>${ab.content }</textarea></td>
                </tr>
            </table>
            <div>
            	<c:if test="${sessUser ne null }">
            		<c:if test="${ab.uid eq sessUser.uid }">
            			<a href="/Farmstory2/board/delete.do?no=${ab.no }&pg=${pg}&group=${group}&cate=${cate}" class="btn btnRemove">삭제</a>
            		</c:if>
						<a href="/Farmstory2/board/modify.do?no=${ab.no }&pg=${pg}&group=${group}&cate=${cate}" class="btn btnModify">수정</a>       		
						<a href="/Farmstory2/board/list.do?pg=${pg }&group=${group}&cate=${cate}" class="btn btnList">목록</a>       		
            	</c:if>
            </div>

            <!-- 댓글목록 -->
            <section class="commentList">
                <h3>댓글목록</h3>
                <c:forEach  var="comment" items="${comments}">
                  <article class="hidecomment">
                    <span class="nick">${comment.nick }</span>
               		<span class="date">${comment.rdate }</span> 
                    <p class="content" contentEditable="true">${comment.content }</p>
                	<c:if test="${comment.uid eq sessUser.uid }">
                		 <div>
		                <a href="#" class="remove" data-no="${comment.no }">삭제 </a>
		                <a href="#" class="modify" data-no="${comment.no }">수정</a>
            		</div>
                	</c:if>
                	</article>
                </c:forEach>
                <c:if test="${comment.size eq 0 }">
                	 <p class="empty">등록된 댓글 없습니다.</p>
                </c:if>
                
            </section>
            
            <c:if test="${sessUser ne null }">
             <section class="commentForm">
                <h3>댓글쓰기</h3>
                <form action="/Farmstory2/board/comment.do" method="post">
                   <input type="hidden" name="pg" value="${pg }">
                	<input type="hidden" name="parent" value="${no }">
                	<input type="hidden" name="uid" value="${sessUser.uid }">
                    <textarea name="content" placeholder="댓글내용 입력"></textarea>
                    <div>
                        <a href="#" class="btn btnCancel">취소</a>
                        <input type="submit" class="btn btnComplete" value="작성완료">
                    </div>
                </form>
            </section>
            </c:if>
        </main>
          </div> 
<jsp:include page="../_footer.jsp"/>
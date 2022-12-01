<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../_header.jsp"/>
<jsp:include page="./_${group}.jsp"/>

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
            			<a href="/Farmstory2/board/delete.do?no=${ab.no }&pg=${pg}" class="btn btnRemove">삭제</a>
            		</c:if>
						<a href="/Farmstory2/board/modify.do?no=${ab.no }&pg=${pg}&group=${group}&cate=${cate}" class="btn btnModify">수정</a>       		
						<a href="/Farmstory2/board/list.do?pg=${pg }&group=${group}&cate=${cate}" class="btn btnList">목록</a>       		
            	</c:if>
            </div>

            <!-- 댓글목록 -->
            <section class="commentList">
                <h3>댓글목록</h3>
                <article>
                    <span class="nick">길동이</span>
                    <span class="date">20-05-13</span>                    
                    <p class="content">댓글 샘플입니다.</p>
                    <div>
                        <a href="#" class="remove">삭제</a>
                        <a href="#" class="modify">수정</a>
                    </div>
                </article>                
                <p class="empty">등록된 댓글이 없습니다.</p>
            </section>
            
            <c:if test="${sessUser ne null }">
             <section class="commentForm">
                <h3>댓글쓰기</h3>
                <form action="#">
                    <textarea name="content" placeholder="댓글내용 입력"></textarea>
                    <div>
                        <a href="#" class="btn btnCancel">취소</a>
                        <input type="submit" class="btn btnComplete" value="작성완료"/>
                    </div>
                </form>
            </section>
            </c:if>
        </main>
          </div> 
<jsp:include page="../_footer.jsp"/>
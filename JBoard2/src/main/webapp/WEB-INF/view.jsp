<%@page import="java.util.List"%>
<%@page import="kr.co.jboard2.vo.ArticleVO"%>
<%@page import="kr.co.jboard2.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
	
	
	
%>

<jsp:include page="./_header.jsp"/>

<script>

	$(document).ready(function(){
		
		// 댓글 삭제하기
		$(document).on('click', '.remove', function(e){
			e.preventDefault;
			
			let remo=$(this);
			let result = confirm('정말 삭제 하시겠습니까?');
			if(result){
				let no = $(this).attr('data-no');
				
				$.ajax({
					url: '/JBoard1/proc/commentDeleteProc.jsp?no='+no,
					type: 'GET',
					dataType: 'json',
					success: function(data){						
						if(data.result > 0){
							alert('댓글이 삭제되었습니다.');
							remo.parent().parent().hide();
							//remo.closest('article').hide();
							// closeet(부모들중 가장 가까운)
						}
					}
				});
			}
		});// 댓글 삭제 완료
		
		
		// 댓글 수정하기
		$(document).on('click', '.modify', function(e){
			e.preventDefault();
			
			let txt = $(this).text();
			let p = $(this).parent().prev();
			
			if(txt == '수정'){
				// 수정모드
				$(this).text('수정완료');				
				p.attr('contentEditable', true);
				p.focus();
			}else{
				// 수정완료
				$(this).text('수정');
				p.attr('contentEditable', false);	
				
				let no = $(this).attr('data-no');
				let content = p.text();
				
				let jsonData = {
					"no": no,
					"content": content
				};
				
				$.ajax({
					url: '/JBoard1/proc/commentModifyProc.jsp',
					type: 'POST',
					data: jsonData,
					dataType: 'json',
					success: function(data){
						
						if(data.result > 0){
							alert('댓글이 수정되었습니다.');
						}
					}
				});
			}	
		}); // 댓글 수정 완료
			
		// 댓글 쓰기
		$('.commentForm>form').submit(function(){
			
			let pg 		= $(this).children('input[name=pg]').val();
			let parent	= $(this).children('input[name=parent]').val();
			let textarea = $(this).children('textarea[name=content]');
			let content = textarea.val();
			let uid 	= $(this).children('input[name=uid]').val();
			
			let jsonData = {
					"pg":pg,
					"parent":parent,
					"content":content,
					"uid":uid
			};
			
			console.log(jsonData);
			
			
			$.ajax({
				url : '/JBoard1/proc/commentWriteProc.jsp',
				method: 'POST',
				data: jsonData,
				dataType: 'json',
				success: function(data){
					
					console.log(data);
					
					let article = "<article>";
						article += "<span class='nick'>"+data.nick+"</span>";
						article += "<span class='date'>"+" "+data.date+"</span>";
						article += "<p class='content'>"+data.content+"</p>";
						article += "<div>";
						article += "<a href='#' class='remove' data-no='"+data.no+"'>삭제</a>";
						article += "<a href='#' class='modify' data-no='"+data.no+"'>수정</a>";
						article += "</div>";
						article += "</article>";
					
					$('.commentList>.empty').hide();
					$('.commentList').append(article);
					textarea.val('');
				}
			});
			
			return false;
		}); // 댓글쓰기 완료
		
		
	});
</script>
        <main id="board">
            <section class="view">
                
                <table>
                <caption>글보기</caption>
                 
                <tr>
                    <th>제목</th>
                    
                    <td><input type="text" value="${ab.title }" name= "title"  readonly ></td>
                </tr>
                <tr>
                    <th>파일</th>
                    <c:set var="ab.file" value='1'/>
                    <c:if test="${ab.file eq 1 }">
                    <td><a href="/JBoard2/proc/download.jsp?fno=${ab.fno }">${ab.oriName }</a>&nbsp;<span>${ab.download }</span>회 다운로드</td>
                      </c:if>
                </tr>
               
                <tr>
                    <th>내용</th>
                    <td><textarea name="content"readonly>${ab.content }</textarea></td>
                </tr>
            

            </table>
                
                <div>
                    <a href="#" class="btn btnRemove">삭제</a>
                    <a href="./modify.html" class="btn btnModify">수정</a>
                    <a href="./list.html" class="btn btnList">목록</a>
                </div>

                <!-- 댓글목록 -->
                <section class="commentList">
                    <h3>댓글목록</h3>                   

                    <article>
                        <span class="nick">길동이</span>
                        <span class="date">20-05-20</span>
                        <p class="content">댓글 샘플 입니다.</p>                        
                        <div>
                            <a href="#" class="remove">삭제</a>
                            <a href="#" class="modify">수정</a>
                        </div>
                    </article>

                    <p class="empty">등록된 댓글이 없습니다.</p>

                </section>

                <!-- 댓글쓰기 -->
                <section class="commentForm">
                    <h3>댓글쓰기</h3>
                    <form action="#">
                        <textarea name="content">댓글내용 입력</textarea>
                        <div>
                            <a href="#" class="btn btnCancel">취소</a>
                            <input type="submit" value="작성완료" class="btn btnComplete"/>
                        </div>
                    </form>
                </section>

            </section>
        </main>
        <jsp:include page="./_footer.jsp"/>
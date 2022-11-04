<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="kr.co.jboard1.db.sql"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.bean.FileBean"%>
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
	String no = request.getParameter("no");
	String pg = request.getParameter("pg");

	ArticleDAO dao = ArticleDAO.getInstance();
	
 	// 글 가져오기
	articleBean ab  = ArticleDAO.getInstance().selectArticle(no);
	
	// 댓글 가져오기
	List<articleBean> comments = dao.selectComments(no);
	
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
   <title>글보기</title>
   <link rel="stylesheet" href="/JBoard1/css/style.css">

   <style>

        #board.view{
            width: 720px;
            height: auto;
            margin: 60px auto;
            overflow: hidden;
        }
        #board.view table{
            width: 100%;
            height: auto;
            border-collapse: collapse;
            border-spacing: 0;
            border-top: 2px solid #111;
        }
        #board.view table caption{
            text-align: left;
            margin-bottom: 6px;
        }
        #board.view table tr{
            width: 100%;
            height: 50px;
            border-bottom: 1px solid #e9e9e9;
        }
        #board.view table th{
            width: 112px;
            height: 100%;
            background: #f5f8f9;
        }
        #board.view table td{
            padding: 0px;
            box-sizing: border-box;
        }
   
        #board.view table input{
            width: 100%;
            height: 24px;
            border: none;
        }
        #board.view table textarea{
            width: 100%;
            height: 280px;
            border: none;
            resize: none;
        }

        #board.view > div{
            text-align: right;
            margin-top: 10px;
        }
        #board.view > div>a{
            display: inline-block;
            padding: 8px;
            border: 1px solid #bebebe;
            background: #fdfdfd;
        }

        #board.view > section{
            width: 100%;
            height: 100%;
            border: 1px solid #e3e3e3;
            background: #f9f9f9;
            box-sizing: border-box;
            padding: 20px;
            margin-top: 10px;
        }
        #board.view > section>h3{
            font-weight: bold;
            font-size: 13px;
            border-bottom: 1px dotted #111;
            margin-bottom: 10px;
            padding-bottom: 6px;
            box-sizing: border-box;
        }

        #board.view > .commentList{}
        #board.view > .commentList > h3{}
        #board.view > .commentList > span{}
        #board.view > .commentList .content{
            width: 100%;
            height: auto;
            padding: 10px;
            box-sizing: border-box;
        }

        #board.view > .commentList>article>div {
            text-align: right;
        }
        #board.view > .commentList>div>a {}
        #board.view > .commentList> .empty {
            padding: 20px;
            text-align: center;
            box-sizing: border-box;
        }

        #board.view > .commentForm {}
        #board.view > .commentForm textarea{
            width: 100%;
            height: 60px;
            border: 1px solid #e4eaec;
            resize: none;
            padding: 6px;
            box-sizing: border-box;
        }
        #board.view > .commentForm div{
            margin-top: 10px;
            text-align: right;
        }
        #board.view > .commentForm div >.btnCancel{
            padding: 8px;
            border: 1px solid #bebebe;
        }
        #board.view > .commentForm div >.btnComplete{
            padding: 7px;
            border: 1px solid #3b3c3f;
            background:#4b545e;
            color: white;
        }


 

   </style>


<%@ include file="./_header.jsp" %>

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
     
        <main id="board" class="view">
            <table>
                <caption>글보기</caption>
                 
                <tr>
                    <th>제목</th>
                    
                    <td><input type="text" value="<%= ab.getTitle() %>" name= "title"  readonly ></td>
                </tr>
                <tr>
                    <th>파일</th>
                       <%if(ab.getFile()==1) {%>
                    <td><a href="/JBoard1/proc/download.jsp?fno=<%= ab.getFno() %>"><%= ab.getOriName() %></a>&nbsp;<span><%= ab.getDownload() %></span>회 다운로드</td>
                     <% } %>
                </tr>
               
                <tr>
                    <th>내용</th>
                    <td><textarea name="content"readonly><%= ab.getContent() %></textarea></td>
                </tr>
            

            </table>

            <div>
            	<%if( ab.getUid().equals(sessUser.getUid()) ) {%>
                <a href="/JBoard1/proc/deleteProc.jsp?no=<%= ab.getNo() %>&pg=<%= pg%>" class="btn btnRemove">삭제</a>
                <%} %>
                <a href="/JBoard1/modify.jsp?no=<%= ab.getNo() %>&pg=<%= pg%>" class="btn btnModify">수정</a>
                <a href="/JBoard1/lsit.jsp?pg=<%= pg%>" class="btn btnList">목록</a>
            </div>
            
            
            <!-- 댓글 목록-->
            <section class="commentList">
                <h3>댓글목록</h3>
                <%for(articleBean comment : comments){ %>
                <article class="hidecomment">
                    <span class="nick"><%= comment.getNick()%></span>
               		<span class="date"><%= comment.getRdate()%></span> 
                    <p class="content" contentEditable="true"><%= comment.getContent()%></p>
                    <%if( comment.getUid().equals(sessUser.getUid()) ) {%>
                    <div>
		                <a href="#" class="remove" data-no="<%= comment.getNo() %>">삭제</a>
		                <a href="#" class="modify" data-no="<%= comment.getNo() %>">수정</a>
            		</div>
            		 <%} %>
                </article>
				<%} %>
				
				<%if(comments.size()==0){ %>
                <p class="empty">등록된 댓글 없습니다.</p>
                <%} %>
            </section>


            <!-- 댓글 쓰기-->
            <section class="commentForm">
                <h3>댓글쓰기</h3>
                <form action="#" method="post">
                	<input type="hidden" name="pg" value="<%= pg%>">
                	<input type="hidden" name="parent" value="<%= no%>">
                	<input type="hidden" name="uid" value="<%= sessUser.getUid()%>">
                    <textarea name="content" placeholder="댓글내용 입력"></textarea>
                    <div>
                        <a href="/JBoard1/lsit.jsp" class="btn btnCancel">취소</a>
                        <input type="submit" class="btn btnComplete" value="작성완료">
                    </div>
                </form>
            </section>
        </main>
         
           
       
        <footer><p>copyright</p>
            </footer>
    </div>
</body>
</html>



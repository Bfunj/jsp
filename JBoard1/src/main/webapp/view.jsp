<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.bean.fileBean"%>
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
//String hit = request.getParameter("hit");



articleBean ab= null;
fileBean fb= null;
int file =0;

try{
	Connection conn =DBCP.getConnection();
	Statement stmt = conn.createStatement();
	/*
	PreparedStatement psmt = conn.prepareStatement("update `board_article` set `hit` = `hit`+1 where `no`='"+no+"'");
	psmt.executeUpdate();
	*/
	ResultSet rs = stmt.executeQuery("SELECT * FROM `board_article` WHERE `no`='"+no+"'");
	
	if(rs.next()){
		ab = new articleBean();
		ab.setNo(rs.getInt(1));
		ab.setParent(rs.getString(2));
		ab.setComment(rs.getString(3));
		ab.setCate(rs.getString(4));
		ab.setTitle(rs.getString(5));
		ab.setContent(rs.getString(6));
		ab.setFile(rs.getInt(7));
		ab.setHit(rs.getInt(8));
		ab.setUid(rs.getString(9));
		ab.setRegip(rs.getString(10));
		ab.setRdate(rs.getString(11));
	}
	
	
	
	
		rs.close();
		stmt.close();
		conn.close();
	
}catch(Exception e){
	e.printStackTrace();
}


if(ab.getFile()==1) {
try{
	Connection conn =DBCP.getConnection();

Statement stmt = conn.createStatement();

ResultSet rs = stmt.executeQuery("SELECT * FROM `board_file` WHERE `parent`='"+no+"'");

if(rs.next()){
	fb = new fileBean();
	fb.setNo(rs.getInt(1));
	fb.setParent(rs.getInt(2));
	fb.setNewname(rs.getString(3));
	fb.setOriname(rs.getString(4));
	fb.setDownload(rs.getInt(5));
	fb.setRdate(rs.getString(6));
	
}else fb.setOriname("");

	rs.close();
	stmt.close();
	conn.close();
	
}catch(Exception e){
	e.printStackTrace();
}
}


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
            padding: 10px;
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
     
        <main id="board" class="view">
            <table>
                <caption>글보기</caption>
                 
                <tr>
                    <th>제목</th>
                    <td><input type="text" name="title" value=<%= ab.getTitle() %> readonly></td>
                </tr>
              
                <tr>
                    <th>파일</th>
                       <%if(ab.getFile()==1) {%>
                    <td><a href="#"><%= fb.getOriname() %></a></td>
                     <% } %>
                </tr>
               
                <tr>
                    <th>내용</th>
                    <td><textarea name="content"readonly><%= ab.getContent() %></textarea></td>
                </tr>
            

            </table>

            <div>
                <a href="/JBoard1/lsit.jsp" class="btn btnRemove">삭제</a>
                <a href="/JBoard1/write.jsp" class="btn btnModify">수정</a>
                <a href="/JBoard1/lsit.jsp" class="btn btnList">목록</a>
            </div>
            <!-- 댓글 목록-->
            <section class="commentList">
                <h3>댓글목록</h3>
                <article>
                    <span class="nick">길동이</span>
                    <span class="date">20-05-13</span>
                    <p class="content">댓글 샘플입니다.</p>
                    <div>
                        <a href="#" class="Remove">삭제</a>
                        <a href="#" class="Modify">수정</a>
                    </div>
                </article>

                <p class="empty">등록된 댓글 없습니다.</p>
            </section>

            <!-- 댓글 쓰기-->
            <section class="commentForm">
                <h3>댓글쓰기</h3>
                <form action="#">
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
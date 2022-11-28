
<%@page import="kr.co.Farmstory2.dao.ArticleDao"%>
<%@page import="kr.co.Farmstory2.VO.ArticleVO"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp" %>

<%
	ArticleDao dao =ArticleDao.getInstance();
	List<ArticleVO> arti_story = dao.selectArticles(0, "story");
	List<ArticleVO> arti_grow = dao.selectArticles(0, "grow");
	List<ArticleVO> arti_school= dao.selectArticles(0, "school");
	List<ArticleVO> arti_notice= dao.selectArticles(0, "notice");
	List<ArticleVO> arti_faq= dao.selectArticles(0, "faq");
	List<ArticleVO> arti_qna= dao.selectArticles(0, "qna");
%>
<script>
	$(function(){
		$.get('/Farmstory2/board/proc/getLatest.jsp',function(data){});
	});
</script>
<main>
    <div class="slider">
        <ul>
            <li><img src="./img/main_slide_img1.jpg" alt="슬라이더1"></li>
            <li><img src="./img/main_slide_img2.jpg" alt="슬라이더2"></li>
            <li><img src="./img/main_slide_img3.jpg" alt="슬라이더3"></li>
        </ul>

        <img src="./img/main_slide_img_tit.png" alt="사람과 자연을 사랑하는 팜스토리"/>

        <div class="banner">
            <img src="./img/main_banner_txt.png" alt="GRAND OPEN"/>
            <img src="./img/main_banner_tit.png" alt="팜스토리 오픈기념 30% 할인 이벤트"/>
            <img src="./img/main_banner_img.png" alt="과일"/>
        </div>
    </div>

    <div class="quick">
        <a href="#"><img src="./img/main_banner_sub1_tit.png" alt="오늘의 식단"></a>
        <a href="#"><img src="./img/main_banner_sub2_tit.png" alt="나도 요리사"></a>                
    </div>

    <div class="latest">
        <div>
            <a href="/Farmstory2/board/list.do?group=croptalk&cate=grow"><img src="./img/main_latest1_tit.png" alt="텃밭 가꾸기"/></a>
            <img src="./img/main_latest1_img.jpg" alt="이미지"/>
            <table border="0">
               	<% int i=0; %>
                 <% for(ArticleVO ab : arti_grow){ i++; %>              
					<tr>
						<td>></td>
						<td><a href="/Farmstory2/board/view.do?no=<%= ab.getNo() %>&pg=1&group=croptalk&cate=grow"><%= ab.getTitle() %> [new] </a></td>	
						<td><%= ab.getRdate().substring(2,10) %></td>										
					</tr>
					<% if(i==5) break;} %>
  
                </tr>
            </table>
        </div>
        <div>
            <a href="/Farmstory2/board/list.do?group=croptalk&cate=school"><img src="./img/main_latest2_tit.png" alt="귀농학교"/></a>
            <img src="./img/main_latest2_img.jpg" alt="이미지"/>
            <table border="0">
            
                <% int j=0; %>
                 <% for(ArticleVO ab : arti_school){ j++; %>              
					<tr>
						<td>></td>
						<td><a href="/Farmstory1/board/view.do?no=<%= ab.getNo() %>&pg=1&group=croptalk&cate=school"><%= ab.getTitle() %></a></td>	
						<td><%= ab.getRdate().substring(2,10) %></td>										
					</tr>
					<% if(j==5) break;} %>
            
            </table>
        </div>
        <div>
            <a href="/Farmstory2/board/list.do?group=croptalk&cate=story"><img src="./img/main_latest3_tit.png" alt="농작물 이야기"/></a>
            <img src="./img/main_latest3_img.jpg" alt="이미지"/>
            <table border="0">
              
                	<% int k=0; %>
                 <% for(ArticleVO ab : arti_story){ k++; %>              
					<tr>
						<td>></td>
						<td><a href="/Farmstory2/board/view.do?no=<%= ab.getNo() %>&pg=1&group=croptalk&cate=story"><%= ab.getTitle() %></a></td>	
						<td><%= ab.getRdate().substring(2,10) %></td>										
					</tr>
					<% if(k==5) break;} %>
            
            </table>
        </div>
        
    </div>

    <div class="info">
        <div>
            <img src="./img/main_sub2_cs_tit.png" class="tit" alt="고객센터 안내"/>
            <div class="tel">
                <img src="./img/main_sub2_cs_img.png" alt="">
                <img src="./img/main_sub2_cs_txt.png" alt="1666-777">
                <p class="time">
                    평일: AM 09:00 ~ PM 06:00<br>
                    점심: PM 12:00 ~ PM 01:00<br>
                    토, 일요일, 공휴일 휴무
                </p>
            </div>
            <div class="btns">
                <a href="#"><img src="./img/main_sub2_cs_bt1.png" alt="1:1 고객문의"></a>
                <a href="#"><img src="./img/main_sub2_cs_bt2.png" alt="자주묻는질문"></a>
                <a href="#"><img src="./img/main_sub2_cs_bt3.png" alt="배송조회"></a>
            </div>
        </div>
        <div>
            <img src="./img/main_sub2_account_tit.png" class="tit" alt="계좌안내"/>
            <p class="account">
                기업은행 123-456789-01-01-012<br />
                국민은행 01-1234-56789<br />
                우리은행 123-456789-01-01-012<br />
                하나은행 123-456789-01-01<br />
                예 금 주 (주)팜스토리
            </p>
        </div>
        <div>
            <div id="tabs">
                <ul>
                    <li><a href="#tabs-1">공지사항</a></li>
                    <li><a href="#tabs-2">1:1 고객문의</a></li>
                    <li><a href="#tabs-3">자주묻는 질문</a></li>
                </ul>
                <div id="tabs-1">
                    <ul class="txt">
                 <% int z=0; %>
                 <% for(ArticleVO ab : arti_notice){ z++; %>              	
						<li><a href="/Farmstory2/board/view.do?no=<%= ab.getNo() %>&pg=1&group=community&cate=notice"><%= ab.getTitle() %></a></li>	
					<% if(z==3) break;} %>             
                    </ul>
                </div>
                <div id="tabs-2">
                    <ul class="txt">
                      <% int x=0; %>
                 <% for(ArticleVO ab : arti_qna){ x++; %>              	
						<li><a href="/Farmstory2/board/view.do?no=<%= ab.getNo() %>&pg=1&group=community&cate=qna"><%= ab.getTitle() %></a></li>	
					<% if(x==3) break;} %>
                  </ul>
                </div>
                <div id="tabs-3">
                    <ul class="txt">
                       <% int c=0; %>
                	 <% for(ArticleVO ab : arti_faq){ c++; %>              	
						<li><a href="/Farmstory2/board/view.do?no=<%= ab.getNo() %>&pg=1&group=community&cate=faq"><%= ab.getTitle() %></a></li>	
					<% if(c==3) break;} %>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</main>
<%@ include file="./_footer.jsp" %>
        
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="sub">
    <div><img src="/Farmstory2/img/sub_top_tit2.png" alt="MARKET"></div>
    <section class="cate2">
        <aside>
            <img src="/Farmstory2/img/sub_aside_cate2_tit.png" alt="장보기"/>

            <ul class="lnb">
				<li class="${cate eq 'market' ? 'on' : 'off'}"><a href="./list.do?group=market&cate=market">장보기</a></li>
            </ul>
        </aside>
        <article>
            <nav>
                <img src="/Farmstory2/img/sub_nav_tit_cate2_tit1.png" alt="장보기"/>
                <p>
                    HOME > 장보기 > <em>장보기</em>
                </p>
            </nav>
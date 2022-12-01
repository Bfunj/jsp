<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="sub">
    <div><img src="/Farmstory2/img/sub_top_tit4.png" alt="EVENT"></div>
    <section class="cate4">
        <aside>
            <img src="/Farmstory2/img/sub_aside_cate4_tit.png" alt="이벤트"/>

            <ul class="lnb">
                <li class="${cate eq 'event' ? 'on' : 'off'}"><a href="./list.do?group=event&cate=event">이벤트</a></li>
            </ul>

        </aside>
        <article>
            <nav>
                <img src="/Farmstory2/img/sub_nav_tit_cate4_tit1.png" alt="이벤트"/>
                <p>
                    HOME > 이벤트 > <em>이벤트</em>
                </p>
            </nav>
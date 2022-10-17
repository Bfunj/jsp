<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp" %>
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
                        <tr>
                            <td>1</td>
                            <td>
                                <a href="/JBoard1/view.jsp">테스트 제목입니다.</a>"&nbsp;[3]"
                            </td>
                            <td>길동이</td>
                            <td>20-05-12</td>
                            <td>12</td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>
                                <a href="#">테스트 제목입니다.2</a>"&nbsp;[3200]"
                            </td>
                            <td>길동이</td>
                            <td>20-05-12</td>
                            <td>12</td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>
                                <a href="#">길이테스트길이테스트길이테스트길이테스트길이테스트길이테스트길이테스트길이테스트길이테스트길이테스트길이테스트</a>"&nbsp;[1]"
                            </td>
                            <td>길동이</td>
                            <td>20-05-12</td>
                            <td>12</td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>
                                <a href="#">테스트 제목입니다.4</a>"&nbsp;[3]"
                            </td>
                            <td>길동이</td>
                            <td>20-05-12</td>
                            <td>12</td>
                        </tr>
                    </tbody>
                </table>
            

            <div class="page">
                <a href="#" class="prev">이전</a>
                <a href="#" class="num current">1</a>
                <a href="#" class="num">2</a>
                <a href="#" class="num">3</a>
                <a href="#" class="next">다음</a>
            </div>
            <a href="/JBoard1/write.jsp" class="btnWrite">글쓰기</a>
        </main>
<%@ include file="./_footer.jsp" %>
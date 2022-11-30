<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="./_header.jsp"/>
<script src="/JBoard2/js/passCheck.js"></script>

<main id="user">
    <section class="find findId register">
        <form action="/JBoard2/user/info.do" method = "post">
            <table border="0">
                <caption>비밀번호 확인</caption>
                <tr>
                    <td>비밀번호</td>
                    <td><input type="password" name="pass" placeholder="비번 입력"/></td>
                    <input type="text" name="uid" value="${sessUser.uid }" style="display: none" />
                </tr>
                          
            </table>                                        
        </form>
        
        <p>
            회원님으 정보를 보호하기 위해 비밀번호를 다시 확인합니다.
        </p>

        <div>
            <a href="/JBoard2/list.do" class="btn btnCancel">취소</a>
            <a href="/JBoard2/user/myinfo.do?uid=${sessUser.uid }" class="btn next">다음</a>
        </div>
    </section>
</main>
<jsp:include page="./_footer.jsp"/>
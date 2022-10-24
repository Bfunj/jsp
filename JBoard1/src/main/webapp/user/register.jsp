<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp" %>

	

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/JBoard1/js/postcode.js"> </script>
<script src="/JBoard1/js/validation.js"> </script>


       <main id="user" class="register">
        <form action="/JBoard1/user/proc/registerProc.jsp" method="post">
            <table border="1">
                <caption>사이트 이용정보 입력</caption>
                <tr>
                    <th>아이디</th>
                    <td>
                        <input type="text" name="uid" placeholder="아이디 입력">
                    <button type="button" id="btnUidCheck"><img src="/JBoard1/img/chk_id.gif" alt="중복확인"></button>
                    <span class="uidResult"></span>
                    </td>
                </tr>
                <tr>
                    <th>비밀번호</th>
                    <td>
                        <input type="password" name="pass1" placeholder="비밀번호 입력">
                        <span class="ResultPass"></span>
                    </td>
                </tr>
                <tr>
                    <th>비밀번호 확인</th>
                    <td>
                        <input type="password" name="pass2" placeholder="비밀번호 입력 확인">
                    </td>
                </tr>
            </table>


            <table border="1">
                <caption>개인정보입력</caption>
                <tr>
                    <th>이름</th>
                    <td>
                        <input type="text" name="name" placeholder="이름 입력">
                 		<span class="resultName"></span>
                    </td>
                </tr>
                <tr>
                    <th>별명</th>
                    <td>
                        <p>공백 없이 한글, 영문, 숫자만 입력가능</p>
                        <input type="text" name="nick" placeholder="별명 입력">
                        <button type="button" id="btnNickCheck"><img src="/JBoard1/img/chk_id.gif" alt="중복확인"></button>           
                    <span class="resultNick"></span>
                    </td>
                </tr>
             
                <tr>
                    <th>이메일</th>
                    <td>
                        <input type="email" name="email" placeholder="이메일 입력 확인">
                         <span class="resultEmail"></span>
                    </td>
                </tr>
                <tr>
                    <th>휴대폰</th>
                    <td>
                        <input type="text" name="hp" placeholder="포함 13자리 입력">
                         <span class="resultHp"></span>
                    </td>
                </tr>
                <tr>
                    <th>주소</th>
                    <td>
                        <input type="text" name="zip" placeholder="우편번호 검색" id="sample6_postcode">
                        <button type="button" onclick="Postcode()"><img src="/JBoard1/img/chk_post.gif" alt="우편번호 찾기"></button>
                        <input type="text" name="addr1" id="sample6_address" placeholder="기본주소 검색" readonly>
                        <input type="text" name="addr2" id="sample6_detailAddress" placeholder="상세주소 입력">
                    </td>
                </tr>
            </table>

            <div>
                <a href="/JBoard1/user/login.jsp" class="btnCancel">취소</a>
                <input type="submit" class="btnRegister" value="회원가입">
                
            </div>
        </form>
        
       </main>
   <%@ include file="./_footer.jsp" %>
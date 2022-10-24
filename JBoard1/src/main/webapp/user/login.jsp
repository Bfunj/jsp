<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp" %>

<script>
$(function(){
	$('.btnLogin').click(function(){
		alert('로그인 진행중!');
		let uid = $('input[name=uid]').val();
		let jsonData = {"uid":uid};
		// 0.3초 딜레이
		
			//해당 url에 json data 전송
			$.ajax({
				url: './proc/loginUid.jsp',
				method: 'get',
				data: jsonData,
				dataType: 'json',
				success:function(data){
					if(data.result==1){
					alert("로그인 성공!");}
				}
			});
		
	});
});
</script>
 <main id="user" class="login">
          <form action="/JBoard1/lsit.jsp">
               <table border="0">
                       <tr>
                            <td><img src="/JBoard1/img/login_ico_id.png" alt="로그인"></td>
                            <td><input type="text" name="uid" placeholder="아이디 입력"></td>
                       </tr>
                            
                            <tr>
                                <td><img src="/JBoard1/img/login_ico_pw.png" alt="비밀번호"></td>
                                <td><input type="text" name="pass" placeholder="비밀번호 입력"></td>
                            </tr>
                            
                    </table>
                        <input type="submit" class="btnLogin" value="로그인"/>
                </form>

                <div class="info">
                    <h3>회원 로그인 안내</h3>
                    <p>
                        아직 회원이 아니시면 회원으로 가입하세요.
                    </p>
                    <a href="/JBoard1/user/terms.jsp">회원가입</a>
                </div>

 </main>
<%@ include file="./_footer.jsp" %>
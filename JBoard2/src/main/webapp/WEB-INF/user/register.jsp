<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="./_header.jsp"/>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/JBoard2/js/postcode.js"> </script>
<script>


let isUidOk = false;
let isPassOk = false;
let isNamedOk = false;
let isNickOk = false;
let isEmailOk = false;
let isHpOk = false;

//비밀번호 정규 표현식
//숫자와 문자 포함 형태의 6~12자리 이내의 암호 정규식 (1 가지 조합)
var regExp = /^[A-Za-z0-9]{6,12}$/;
//영문, 숫자, 특수문자 중 2가지 이상 조합하여 10자리 이내의 암호 정규식 ( 2 가지 조합)
var regExp = /^(?!((?:[A-Za-z]+)|(?:[~!@#$%^&*()_+=]+)|(?:[0-9]+))$)[A-Za-z\d~!@#$%^&*()_+=]{10,}$/;
//특수문자 / 문자 / 숫자 포함 형태의 8~15자리 이내의 암호 정규식 ( 3 가지 조합)
var regExp = /^.*(?=^.{5,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

// 이메일 정규 표현식
var regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
// 휴대폰 정규 표현식
var regHp = /^\d{3}-\d{3,4}-\d{4}$/;

// 아이디 정규 표현식
var idReg = /^[A-za-z0-9]{5,15}$/g;

// 한글 이름 정규식
var regName = /^[가-힣]{2,4}$/;

// 닉네임
var regNick = /^[\w\Wㄱ-ㅎㅏ-ㅣ가-힣]{2,20}$/;

	$(function(){
	
		//아이디 중복 체크
		$('#btnUidCheck').click(function(){
			
			let uid = $('input[name=uid]').val();
			
			$.ajax({
				url: '/JBoard2/user/checkUid.do',
				method: 'GET',
				data: {"uid":uid},
				dataType: 'json',
				success: function(data){
					if(data.result > 0){
						$('.uidResult').css('color', 'red').text('이미 사용중인 아이디 입니다.');
						isUidOk=false;
					}else{
						$('.uidResult').css('color', 'green').text('사용 가능한 아이디 입니다.');
						isUidOk=true;
					}
				}
			});		
		});// 아이디 체크 종료
		
		// 비밀번호 확인
		$('input[name=pass2]').focusout(function(){
			let pass1 = $('input[name=pass1]').val();
			let pass2 = $(this).val();
			if( pass1 == pass2){
		
				// 영문자, 숫자, 특수문자 및 5자 이상 확인
				if(pass2.match(regExp) == null){
					isPassOk=false;
					$('.ResultPass').css('color','orange').text('비밀번호가 올바르지 않습니다.(영문, 숫자, 특수문자를 포함하여 5자 이상)');
					
				}else{
					isPassOk=true;
					$('.ResultPass').css('color','green').text('비밀번호가 일치합니다.');
				}
			}else{
				isPassOk=false;
				$('.ResultPass').css('color','red').text('비밀번호가 일치하지 않습니다.');
			}
		});// 비밀번호 체크 종료
		
		// 이름 유효성 검증
		$('input[name=name]').focusout(function(){
			let name = $(this).val();
			if(!name.match(regName)){
				isNameOk=false;
				$('.resultName').css('color','orange').text('형식이 올바르지 않습니다.');
			}else{
				isNameOk=true;
				$('.resultName').css('color','green').text('OK');
			}
		});// 이름 유효성 체크 종료
		
		
		// 이메일 유효성 검사
		$('input[name=email]').focusout(function(){
			let email = $(this).val();
			
			if(!email.match(regEmail)){
				isEmailOk=false;
				$('.resultEmail').css('color', 'red').text('유효하지 않습니다.');
			}else{
				isEmailOk=true;
				$('.resultEmail').css('color','green').text('OK');
			}
		});
		
		//별명 중복 체크
		$('#btnNickCheck').click(function(){
			
			let nick = $('input[name=nick]').val();
			
			$.ajax({
				url: '/JBoard2/user/checkNick.do',
				method: 'GET',
				data: {"nick":nick},
				dataType: 'json',
				success: function(data){
					if(data.result > 0){
						$('.nickResult').css('color', 'red').text('이미 사용중인 별명 입니다.');
						isNickOk=false;
					}else{
						$('.nickResult').css('color', 'green').text('사용 가능한 별명 입니다.');
						isNickOk=true;
					}
				}
			});		
		});// 별명 중복 체크 종료
		
		// 휴대폰 유효성 검사
		$('input[name=hp]').focusout(function(){
				let hp = $(this).val();
			if(!hp.match(regHp)){
				isHpOk=false;
				$('.resultHp').css('color', 'red').text('유효하지 않습니다. (ex : 000-0000-0000)');
			}else{
				isHpOk=true;
				$('.resultHp').css('color','green').text('OK');
			}
		});// 휴대폰 유효성 종료
		
		
		$('.register > form').submit(function(){
			
			////////////////////////////////////////////
			// 폼 데이터 유효성 검증(Validation)
			////////////////////////////////////////////
			// 아이디 검증
			if(!isUidOk){
				alert('아이디를 확인하십시오.');
				return false;
			}
			// 비밀번호 검증
			if(!isPassOk){
				alert('비밀번호를 확인하십시오.');
				return false;
			}
			// 이름 검증
			if(!isNameOk){
				alert('이름을확인하십시오.');
				return false;
			}
			// 별명 검증
			if(!isNickOk){
				alert('별명을 확인하십시오.');
				return false;
			}
			// 이메일 검증
			if(!isEmailOk){
				alert('메일을 확인하십시오.');
				return false;
			}
			// 휴대폰 검증
			if(!isHpOk){
				alert('휴대폰을 확인하십시오.');
				return false;
			}		
			//최종 전송
			return true;
		});
		
		
	});
	
	
	
	
</script>
<main id="user">
    <section class="register">

        <form action="/JBoard2/user/register.do" method="post">
            <table border="1">
                <caption>사이트 이용정보 입력</caption>
                <tr>
                    <td>아이디</td>
                    <td>
                        <input type="text" name="uid" placeholder="아이디 입력"/>
                        <button type="button" id="btnUidCheck"><img src="../img/chk_id.gif" alt="중복확인"/></button>
                        <span class="uidResult"></span>
                    </td>
                </tr>
                <tr>
                   <td>비밀번호</td>
                    <td>
                        <input type="password" name="pass1" placeholder="비밀번호 입력">
                        <span class="ResultPass"></span>
                    </td>
                </tr>
                <tr>
                    <td>비밀번호 확인</td>
                    <td><input type="password" name="pass2" placeholder="비밀번호 입력 확인"/></td>
                </tr>
            </table>

            <table border="1">
                <caption>개인정보 입력</caption>
                <tr>
                    <td>이름</td>
                    <td>
                        <input type="text" name="name" placeholder="이름 입력"/> 
                         <span class="resultName"></span>                       
                    </td>
                </tr>
                <tr>
                    <td>별명</td>
                    <td>
                        <p class="nickInfo">공백없는 한글, 영문, 숫자 입력</p>
                        <input type="text" name="nick" placeholder="별명 입력"/>
                        <button type="button" id="btnNickCheck"><img src="../img/chk_id.gif" alt="중복확인"/></button>
                        <span class="nickResult"></span>
                    </td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td>
                        
                        <input type="email" name="email" placeholder="이메일 입력"/>
                        <button type="button"><img src="../img/chk_auth.gif" alt="인증번호 받기"/></button>
                        <div class="auth">
                            <input type="text" name="auth" placeholder="인증번호 입력"/>
                            <button type="button"><img src="../img/chk_confirm.gif" alt="확인"/></button>
                        </div>
                        <span class="resultEmail"></span>          
                    </td>
                </tr>
                <tr>
                    <td>휴대폰</td>
                    <td><input type="text" name="hp" placeholder="휴대폰 입력"/>
                    	 <span class="resultHp"></span>    
                    </td>
               	 
                </tr>
                <tr>
                   <td>주소</td>
                    <td>
                        <input type="text" name="zip" placeholder="우편번호 검색" id="sample6_postcode">
                        <button type="button" onclick="Postcode()"><img src="/JBoard1/img/chk_post.gif" alt="우편번호 찾기"></button>
                        <input type="text" name="addr1" id="sample6_address" placeholder="기본주소 검색" readonly>
                        <input type="text" name="addr2" id="sample6_detailAddress" placeholder="상세주소 입력">
                    </td>
                </tr>
            </table>

            <div>
                <a href="/JBoard2/user/login.do" class="btn btnCancel">취소</a>
                <input type="submit" value="회원가입" class="btn btnRegister"/>
            </div>

        </form>

    </section>
</main>
<jsp:include page="./_footer.jsp"/>
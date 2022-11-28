/**
 * 
 */
 
 
 
	// 폼 데이터 검증 결과 상태변수
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
	
	//아이디 유효성 검증 & 중복 체크
	$('input[name=uid]').keydown(function(){
		isUidOk = false;
	});
	
	$('#btnUidCheck').click(function(){
		let uid = $('input[name=uid]').val();
		// 중복확인 버튼 
		if(isUidOk == true){
			return;				
		}
		if(!uid.match(idReg)){
			isUidOk  = false;
			$('.uidResult').css('color', 'red').text('아이디가 유효하지 않습니다.');
			return;
		}
		// 입력받은 uid를 json 데이터로 변환
		let jsonData = {"uid":uid};
		
		$('.uidResult').text('...');
		// 0.3초 딜레이
		setTimeout(()=>{
			
			//해당 url에 json data 전송
			$.ajax({
				url: './proc/checkUid.jsp',
				method: 'get',
				data: jsonData,
				dataType: 'json',
				success:function(data){
					if(data.result == 0){
						isUidOk=true;
						$('.uidResult').css('color', 'green').text('사용 가능한 아이디 입니다.');
					}else{
						isUidOk=false;
						$('.uidResult').css('color', 'red').text('이미 사용중인 아이디 입니다.');
					}
				}
			});
			
			
		},500);
		
		
		
	});
	
	// 비밀번호 일치여부 확인
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
	
	});
	
	// 이름 유효성 검증
	$('input[name=name]').focusout(function(){
		let name = $(this).val();
		if(!name.match(regName)){
			isNameOk=false;
			$('.resultName').css('color','orange').text('형식이 올바르지 않습니다.');
		}else{
			isNameOk=true;
			$('.resultName').text('');
		}
	});
	
	// 별명 유효성 검증
	
	$('input[name=nick]').keydown(function(){
		isNickOk = false;
	});
	$('#btnNickCheck').click(function(){
		let nick = $('input[name=nick]').val();
		
		if(isNickOk){
			return;
		}
		if(!nick.match(regNick)){
			isNickOk  = false;
			$('.resultNick').css('color', 'red').text('유효하지 않습니다.');
			return;
		}
	
		let jsonData = {"nick":nick};
		
		$('.resultNick').text('...');
		
		setTimeout(()=>{
			$.ajax({
				url:'./proc/checkNick.jsp',
				type:'get',
				data:jsonData,
				dataType:'json',
				success:function(data){
					if(data.result == 0){
						isNickOk=true;
						$('.resultNick').css('color', 'green').text('사용 가능한 별명 입니다.');
					}else{
						isUidOk=false;
						$('.resultNick').css('color', 'red').text('이미 사용중인 별명 입니다.');
					}
				}
			});
				
		},300);
	
	});
	
	
	// 이메일 유효성 검사
	$('input[name=email]').focusout(function(){
		let email = $(this).val();
		
		if(!email.match(regEmail)){
			isEmailOk=false;
			$('.resultEmail').css('color', 'red').text('유효하지 않습니다.');
		}else{
			isEmailOk=true;
			$('.resultEmail').text('');
		}
	});
	// 휴대폰 유효성 검사
	$('input[name=hp]').focusout(function(){
			let hp = $(this).val();
		if(!hp.match(regHp)){
			isHpOk=false;
			$('.resultHp').css('color', 'red').text('유효하지 않습니다.');
		}else{
			isHpOk=true;
			$('.resultHp').text('');
		}
	});
	
	
	
	
	
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

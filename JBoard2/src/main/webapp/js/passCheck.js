let regUid   = /^[a-z]+[a-z0-9]{4,19}$/g;
let regName  = /^[가-힣]{2,4}$/;
let regNick  = /^[가-힣a-zA-Z0-9]+$/;
let regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
let regHp	 = /^\d{3}-\d{3,4}-\d{4}$/;
let regPass  = /^.*(?=^.{5,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

// 폼 데이터 검증 결과 상태변수
let isPassOk  = false;

$(function(){

	// 비밀번호 일치여부 확인
	$('input[name=pass]').focusout(function(){			
		let pass = $('input[name=pass]').val();
		let uid = $('input[name=uid]').val();

		let jsonData = {"pass":pass,
			"uid":uid};
				
			$.ajax({
				url: '/JBoard2/user/checkpass.do',
				type: 'get',
				data: jsonData,
				dataType: 'json',
				success: function(data){
				console.log(data);
					if(data.result != 0){
						isPassOk = true;				
					}else{
						isPassOk = false;			
					}
				}
			});
	});

	$('.next').click(function(){					
		if(!isPassOk){
			alert('비밀번호를 확인 하십시요.');
			return false;
		}			
		// 최종 전송
		return true;
	});
});
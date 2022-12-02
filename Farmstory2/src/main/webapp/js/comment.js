$(document).ready(function(){
	
	// 댓글 삭제하기
	$(document).on('click', '.remove', function(e){
		e.preventDefault;
		
		let remo=$(this);
		let result = confirm('정말 삭제 하시겠습니까?');
		if(result){
			let no = $(this).attr('data-no');
			
			$.ajax({
				url: '/Farmstory2/board/commentDelete.do?no='+no,
				type: 'GET',
				dataType: 'json',
				success: function(data){						
					if(data.result > 0){
						alert('댓글이 삭제되었습니다.');
						remo.parent().parent().hide();
						//remo.closest('article').hide();
						// closeet(부모들중 가장 가까운)
					}
				}
			});
		}
	});// 댓글 삭제 완료
	
	
	// 댓글 수정하기
	$(document).on('click', '.modify', function(e){
		e.preventDefault();
		
		let txt = $(this).text();
		let p = $(this).parent().prev();
		
		if(txt == '수정'){
			// 수정모드
			$(this).text('수정완료');				
			p.attr('contentEditable', true);
			p.focus();
		}else{
			// 수정완료
			$(this).text('수정');
			p.attr('contentEditable', false);	
			
			let no = $(this).attr('data-no');
			let content = p.text();
			
			let jsonData = {
				"no": no,
				"content": content
			};
			
			$.ajax({
				url: '/Farmstory2/board/commentModify.do',
				type: 'POST',
				data: jsonData,
				dataType: 'json',
				success: function(data){
					
					if(data.result > 0){
						alert('댓글이 수정되었습니다.');
					}
				}
			});
		}	
	}); // 댓글 수정 완료
		
	// 댓글 쓰기
	$('.commentForm>form').submit(function(){
		
		let pg 		= $(this).children('input[name=pg]').val();
		let parent	= $(this).children('input[name=parent]').val();
		let textarea = $(this).children('textarea[name=content]');
		let content = textarea.val();
		let uid 	= $(this).children('input[name=uid]').val();
		
		let jsonData = {
				"pg":pg,
				"parent":parent,
				"content":content,
				"uid":uid
		};
		
		console.log(jsonData);
		
		
		$.ajax({
			url : '/Farmstory2/board/comment.do',
			method: 'POST',
			data: jsonData,
			dataType: 'json',
			success: function(data){
				
				console.log(data);
				console.log(data.nick);
				
				
				let article = "<article>";
					article += "<span class='nick'>"+data.nick+"</span>";
					article += "<span class='date'>"+" "+data.date+"</span>";
					article += "<p class='content'>"+data.content+"</p>";
					article += "<div>";
					article += "<a href='#' class='remove' data-no='"+data.no+"'>삭제 </a>";
					article += "<a href='#' class='modify' data-no='"+data.no+"'>수정</a>";
					article += "</div>";
					article += "</article>";
				
				$('.commentList>.empty').hide();
				$('.commentList').append(article);
				textarea.val('');
			}
		});
		
		return false;
	}); // 댓글쓰기 완료
	
	
});
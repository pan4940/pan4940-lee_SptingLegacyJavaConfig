$('#rePwdBtn').click(function(){
	if($('#memOption').val()=='Email'){
		$.ajax({
			url : "/member/tempPwdByEmail",
			headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
			type : "POST",
			data : {
				'member_id' : $("#member_id").val(),
				//'email' : $("#memKeyword").val()
			},
			success : function() {
				location.href = 'tempAlert';
			},
			error:function(err){
				alert(err);
			}
		});
		
	} else if($('#memOption').val()=='휴대폰번호'){
		$.ajax({
			url : "/member/tempPwdByPhone",
			headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
			type : "POST",
			data : {
				'member_id' : $("#member_id").val()
			},
			success : function(data) {
				console.log(data);
				location.href = 'tempAlert';
			},
			error:function(err){
				alert(err);
			}
		});
	}	
});




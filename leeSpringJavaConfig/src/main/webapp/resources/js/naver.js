const naverLogin = new naver.LoginWithNaverId({
	clientId: "",
	callbackUrl: "http://localhost:8080/member/loginForm",
	loginButton: {color: "green", type: 2, height: 40}
});

naverLogin.init();


//$("#naverIdLogin").click(function(){
	naverLogin.getLoginStatus(function(status) {
		if (status) {
			const naverId = naverLogin.user.getId() + '@n';
			const name = naverLogin.user.getName();
			const email = naverLogin.user.getEmail();
			const mobile = naverLogin.user.getMobile();
		
			//닉네임을 선택하지 않으면 선택창으로 돌아갑니다.
			if (name === null || name === undefined) {
				alert("이름이 필요합니다. 정보제공을 동의해주세요.");
				naverLogin.reprompt();
				return;
			} else {
				console.log("모든정보 제공");
				//모든 필수 정보 제공 동의하면 실행하는 함수
				$.ajax({
					type: 'post',
					url: '/member/checkId',
					data: 'member_id=' + naverId,
					dataType: 'text',
					success: function(data) {
						data = data.trim();
	
						if (data == "exist") {
							console.log("회원가입되어있음");
							checkSocial(naverId, name);
						} else if (data == 'non_exist') {
							console.log("미가입");
							//미가입 상태이므로 서비스에 정보 연계해 가입해야함.
							$.ajax({
								type: 'post',
								url: '/member/socialJoin',
								data: {
									'member_id' : naverId,
									'email' : email,
									'member_name' : name,
									'member_pwd' : naverId
								},
								success: function() {
									
									Swal.fire({
										icon: 'success',
										title: name + "님 가입성공! 회원정보를 수정해주세요!",
										closeOnClickOutside: false
									});
									checkSocial(naverId, name);
								},
								error: function(err) {
									
								}
							});
						}
					},
					error: function(err) {
						alert('난가?');
					}
	
				}); // end ajax
			}
		}
	});
//});


/*function checkNaver(naverId, name){
	$.ajax({
		type: 'post',
		url: '/member/socialLoginOk',
		data: 'member_id=' + naverId,
		dataType: 'text',
		success: function(data) {
			if (data == "ok") {
				Swal.fire({
					icon: 'success',
					title: name + "님 로그인 성공!",
					closeOnClickOutside: false
				}).then(function() {
					location.href = '/';
				});
			} else if (data == 'fail') {
				Swal.fire({
					icon: 'warning',
					title: '소셜 로그인 실패!',
				});
			}
		},
		error: function(err) {
			
		}

	});
}*/

/*var testPopUp;
function openPopUp() {
    testPopUp= window.open("https://nid.naver.com/nidlogin.logout", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,width=1,height=1");
}

function closePopUp(){
    testPopUp.close();
}

function naverLogout(){
	openPopUp();
	setTimeout(function() {
		closePopUp();
	}, 1000);
}*/


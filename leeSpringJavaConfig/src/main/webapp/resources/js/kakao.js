$('#kakaoLogin').click(kakaoLogin);

Kakao.init(''); //발급받은 키 중 javascript키를 사용해준다./*
console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
//로그인
function kakaoLogin() {
    Kakao.Auth.loginForm({
		success: function (response) {
			
			console.log(response);
			Kakao.API.request({
				url: '/v2/user/me',
				data: {
					property_keys: ["kakao_account.email","properties.nickname"]
				},
				success: function (response) {
					let kakaoId = response.id+'@k'
					let email = response.kakao_account.email;
					let name = response.properties.nickname;
					$.ajax({
						type: 'post',
						url: '/member/checkId',
						data: 'member_id=' + kakaoId,
						dataType: 'text',
						success: function(data) {
							data = data.trim();

							if (data == "exist") {
								console.log("회원가입되어있음");
								checkSocial(kakaoId, name);
							} else if (data == 'non_exist') {
								console.log("미가입");
								//미가입 상태이므로 서비스에 정보 연계해 가입해야함.
								$.ajax({
									type: 'post',
									url: '/member/socialJoin',
									data: {
										'member_id' : kakaoId,
										'email' : email,
										'member_name' : name,
										'member_pwd' : kakaoId
									},
									success: function() {
										
										Swal.fire({
											icon: 'success',
											title: name + "님 가입성공! 회원정보를 수정해주세요!",
											closeOnClickOutside: false
										});
										checkSocial(kakaoId, name);
									},
									error: function(err) {
										
									}
								});
							}
						},
						error: function(err) {
							
						}
					}); // end ajax
					
				},
	          	fail: function (error) {
	            		console.log(error)
				},
			}); //end request
		},
		fail: function (error) {
			console.log(error)
		},
    }); //end Kakao.Auth.login
}
  

/*function checkKakao(kakaoId, name){
	$.ajax({
		type: 'post',
		url: '/member/socialLoginOk',
		data: 'member_id=' + kakaoId,
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
					title: '카카오 로그인 실패!',
				});
			}
		},
		error: function(err) {
			
		}

	});
}*/


//로그아웃
function kakaoLogout() {
	if (Kakao.Auth.getAccessToken()) {
		Kakao.API.request({
			url: '/v1/user/unlink',
			success: function(response) {
				console.log(response)
			},
			fail: function(error) {
				console.log(error)
			},	
		})
		Kakao.Auth.setAccessToken(undefined)
	}
}  

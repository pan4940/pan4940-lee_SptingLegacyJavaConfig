window.onload = function() {
	google.accounts.id
		.initialize({
			client_id : "",
			callback : handleCredentialResponse
		});
	google.accounts.id.renderButton(document
			.getElementById("googleBtn"), {
		theme : "outline",
		size : "large"
	}// customization attributes
	);
	//google.accounts.id.prompt(); // also display the One Tap dialog
}


function handleCredentialResponse(response) {
	// decodeJwtResponse() is a custom function defined by you
	// to decode the credential response.
	const responsePayload = parseJwt(response.credential);
	console.log(response);
	console.log(responsePayload);
	console.log("ID: " + responsePayload.sub);
	console.log('Full Name: ' + responsePayload.name);
	console.log("Email: " + responsePayload.email);
	
	$.ajax({
		type: 'post',
		url: '/member/checkId',
		data: 'member_id=' + responsePayload.sub + '@g',
		dataType: 'text',
		success: function(data) {
			data = data.trim();

			if (data == "exist") {
				console.log("회원가입 되어있음");
				checkSocial(responsePayload.sub + '@g', name);
			} else if (data == 'non_exist') {
				console.log("미가입");
				//미가입 상태이므로 서비스에 정보 연계해 가입해야함.
				$.ajax({
					type: 'post',
					url: '/member/socialJoin',
					data: {
						'member_id' : responsePayload.sub + '@g',
						'email' : responsePayload.email,
						'member_name' : responsePayload.name,
						'member_pwd' : responsePayload.sub + '@g'
					},
					success: function() {
						
						Swal.fire({
							icon: 'success',
							title: responsePayload.name + "님 가입성공! 회원정보를 수정해주세요!",
							closeOnClickOutside: false
						});
						checkSocial(responsePayload.sub + '@g', name);
					},
					error: function(err) {
						
					}
				});
			}
		},
		error: function(err) {
			
		}
	}); // end ajax
}



function parseJwt(token) {
	var base64Url = token.split('.')[1];
	var base64 = base64Url.replace(/-/g, '+')
			.replace(/_/g, '/');
	var jsonPayload = decodeURIComponent(atob(base64).split('')
			.map(
					function(c) {
						return '%'
								+ ('00' + c.charCodeAt(0)
										.toString(16))
										.slice(-2);
					}).join(''));

	return JSON.parse(jsonPayload);
};

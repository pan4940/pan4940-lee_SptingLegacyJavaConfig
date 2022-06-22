
$('#DELETEbtn').click(function(){


	if(!$("input:checkbox[name=deleteAddress]").is(":checked")){
		Swal.fire({
			  icon: 'warning',
			  title: '삭제할 주소를 선택해주세요!',
			})
			
	}else{
		Swal.fire({
  			title: '주소를 삭제하시겠습니까??',
  			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: '삭제할래요',
			cancelButtonText: '아니요',
		}).then((result) => {
  			
			if (result.isConfirmed) {
				$.ajax({
					type: 'post',
					headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
					url: '/member/deleteAddress',
					data:$("#addressForm").serialize(),
					success: function() {
						Swal.fire({
							icon: 'success',
							title: '삭제 완료!',
						}).then(function(){
							location.href='/member/addresses'
						})
					},
					error: function(err) {
						alert(err);
						console.log(err)
					}
				}); //end ajax
			}
		})
	}
});	
		
		
		
	
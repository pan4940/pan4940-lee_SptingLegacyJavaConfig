$(function(){
	
	$.ajax({
		type:'post',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		url:'/order/getCartList',
		dataType: 'json',
		success:function(data){
			
			console.log(data)
			var totalValue=0;
			var subTotalValue=0;
			var shippingValue=0;
			if(data.length==0){
				$('#mid').hide()
				$('#side').hide()
				$('#noCart').show()
			}
			
			if(data.length === 0){
				console.log("데이터 없음");
				
			} else {
				$.each(data,function(index,item){
					let fileCallPath = encodeURIComponent(item.fileList[0].uploadPath + "/" + item.fileList[0].uuid + "_" +  item.fileList[0].fileName);
					$('<div/>',{class:'product'}).append(
						$('<div/>',{class:'detail'}).append(
							$('<div/>',{class:'img'}).append($('<img/>',{src:'/file/display?fileName=/'+ fileCallPath}))
						).append(
							$('<div/>',{class:'detailDiv'}).append(
								$('<a/>',{href:"/produec/detail?product_num="+item.product_num,text:item.product_name})
							).append(
								$('<span/>').text(item.productSizeDTO.product_size)
							).append(
								$('<span/>').text(item.product_price.toLocaleString()+'원')
							)/*.append(
								$('<div/>',{class:'number'}).append($('<span/>').text(item.product_count+' 개'))
							)*/
						)
						
					).append($('<div/>',{class:'remove',value:item.productSizeDTO.detailProductDTO.detail_product_id}).text('remove')).appendTo($('#mid'));
						subTotalValue += item.product_price;
				});// end each
			}
			
				
			totalValue=subTotalValue+shippingValue;
			$('#totalvalue').text(totalValue.toLocaleString()+'원')
			$('#subtotalvalue').text(subTotalValue.toLocaleString()+'원')
			$('#shippingvalue').text(shippingValue.toLocaleString()+'원')
			
			$('.remove').click(function(event){
				const swalWithBootstrapButtons = Swal.mixin({
                  customClass: {
                     confirmButton: 'btn btn-success',
                     cancelButton: 'btn btn-danger'
                  },
                  buttonsStyling: false
               });
               swalWithBootstrapButtons.fire({
                  title: '상품을 삭제하시겠습니까?',
                  icon: 'warning',
                  showCancelButton: true,
                  confirmButtonText: '네!!',
                  cancelButtonText: '아니요!!',
                  reverseButtons: false
               }).then((result) => {
                  if (result.isConfirmed) {
                    console.log(result.isConfirmed); 
					$.ajax({
                        type: 'post',
						headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
                        url: '/order/deleteDetailProductFromCart',
                        data: {
                           'detail_product_id': event.target.getAttribute("value")
                        },
                        success: function() {
                       
                           Swal.fire({
                              icon: 'success',
                              title: '항목 1개가 삭제되었습니다.',
                              closeOnClickOutside: false
                           }).then(function() {
                              location.href = '/order/cart';
                           });

                        },

                        error: function(err) {
                           console.log(err);
                        }
                     });

                  } else if (
                     /* Read more about handling dismissals below */

                     result.dismiss === Swal.DismissReason.cancel
                  ) {
                     
                  }
               });
			}) // end remove click event
		},
		error:function(err){
			$('#mid').hide()
				$('#side').hide()
				$('#noCart').show()
		}
	})
});


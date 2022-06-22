var total = 0;
$(function() {
	$.ajax({
		type: 'post',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		url: '/order/getCartList',
		dataType: 'json',
		success: function(data) {
			console.log(data)

			let subtotal = 0;
			let shipping = 0;
			$.each(data, function(index, item) {
				let fileCallPath = encodeURIComponent(item.fileList[0].uploadPath + "/" + item.fileList[0].uuid + "_" +  item.fileList[0].fileName);
				$('<div/>', { class: 'youcartDiv' }).append(
					$('<div/>', { class: 'col-2' }).append($('<img/>', { 'src': '/file/display?fileName=/' + fileCallPath }))
				).append(
					$('<div/>', { class: 'youcartName col-6' }).append(
						$('<p/>', { style: 'margin: 0px 0px 10px 20px' }).text(item.product_name)
					).append(
						$('<span/>').text(item.product_size)
					)
				).append(
					$('<div/>', { class: 'col-2' })
						.append($('<input/>', { type: 'hidden', name: 'detailOrderDTOList['+ index +'].detail_product_id', value: item.productSizeDTO.detailProductDTO.detail_product_id}))
						.append($('<input/>', { type: 'hidden', name: 'detailOrderDTOList['+ index +'].product_price', value: item.product_price}))
				).append(
					$('<div/>', { class: 'col-2', id: 'amount_' + index, 'data-val': item.product_price }).text(item.product_price.toLocaleString() + '원')
				).appendTo($('#cartList'));
				subtotal = subtotal + item.product_price;
				$('#subtotal').text(subtotal.toLocaleString() + '원');
				$('#shipping').text(shipping.toLocaleString() + '원');
				total = subtotal + shipping;
				$('#total').text(total.toLocaleString() + '원');
				$('#lastTotal').text((total - $('#mileageInput').val()).toLocaleString() + '원');
				$('#deliveryCost').val('2500');
				$('#status').val('1');
				$('#totalPrice').val((total - $('#mileageInput').val()));
								
			});

			

		},
		error: function(err) {

		}
	});
});
$('#mileageInput').change(function() {
	if ($('#mileageInput').val() > Number($('#mileageInput').attr('max'))) {
		$('#mileageInput').val(2000)
		Swal.fire({
			icon: 'error',
			title: $('#mileageInput').attr('max') + '이하의 숫자를 입력해주세요.',
		});
	}
	if ($('#mileageInput').val() < Number($('#mileageInput').attr('min'))) {
		$('#mileageInput').val(0)
		Swal.fire({
			icon: 'error',
			title: $('#mileageInput').attr('min') + '이상의 숫자를 입력해주세요.',
		});
	}
	$('#lastTotal').text((total - $('#mileageInput').val()).toLocaleString() + '원')
	$('#totalPrice').val((total - $('#mileageInput').val()))
})
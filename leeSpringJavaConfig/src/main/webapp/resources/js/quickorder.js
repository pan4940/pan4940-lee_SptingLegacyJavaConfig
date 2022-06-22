var total = 0;
$(function() {
	$.ajax({
		type: 'post',
		url: '/order/getQuickorder',
		data: {
			'product_size_id': window.location.search.split('=')[1]
		},
		dataType: 'json',
		success: function(data) {
			console.log(data)
			total = 0;
			let subtotal = 0;
			let shipping = 0;
			let fileCallPath = encodeURIComponent(data.fileList[0].uploadPath + "/" + data.fileList[0].uuid + "_" +  data.fileList[0].fileName);
			$('<div/>', { class: 'youcartDiv' }).append(
				$('<div/>', { class: 'col-2' }).append($('<img/>', { 'src': '/file/display?fileName=/'+ fileCallPath}))
			).append(
				$('<div/>', { class: 'youcartName col-6' }).append(
					$('<p/>', { style: 'margin: 0px 0px 10px 20px' }).text(data.product_name)
				).append(
					$('<span/>').text(data.product_size)
				)
			).append(
				$('<div/>', { class: 'col-2' })
					.append($('<input/>', { type: 'hidden', id: 'detail_product_id', name: 'detailOrderDTOList[0].detail_product_id', value: data.productSizeDTO.detailProductDTOList[0].detail_product_id}))
					.append($('<input/>', { type: 'hidden', id: 'product_price', name: 'detailOrderDTOList[0].product_price', value: data.product_price}))
			).append(
				$('<div/>', { class: 'col-2', id: 'amount', 'data-val': data.product_price }).text(data.product_price.toLocaleString() + '원')
			).appendTo($('#quickorderList'))
			subtotal = subtotal + data.product_price;
			$('#subtotal').text(subtotal.toLocaleString() + '원')
			$('#shipping').text(shipping.toLocaleString() + '원')
			total = subtotal + shipping;
			$('#total').text(total.toLocaleString() + '원')
			$('#lastTotal').text((total - $('#mileageInput').val()).toLocaleString() + '원')
			$('#deliveryCost').val('2500');
			$('#status').val('1');
			$('#totalPrice').val((total - $('#mileageInput').val()));
			
			/*$('input[name=number]').change(function() {
				let subtotal = 0;
				subtotal = subtotal + ($('#countInput').val() * Number($('#amount').attr('data-val')))
				$('#amount').text(($('#countInput').val() * Number($('#amount').attr('data-val'))).toLocaleString() + '원')

				$('#subtotal').text(subtotal.toLocaleString() + '원')
				$('#shipping').text(shipping.toLocaleString() + '원')
				total = subtotal + shipping;
				$('#total').text(total.toLocaleString() + '원');
				$('#lastTotal').text((total - $('#mileageInput').val()).toLocaleString() + '원');
				$('#deliveryCost').val('2500');
				$('#status').val('1');
				$('#totalPrice').val((total - $('#mileageInput').val()));
			})*/

		},
		error: function(err) {

		}
	});
});

$('#mileageInput').change(function() {
	if ($('#mileageInput').val() > Number($('#mileageInput').attr('max'))) {
		Swal.fire({
			icon: 'error',
			title: $('#mileageInput').attr('max') + '이하의 숫자를 입력해주세요.',
		});
		$('#mileageInput').val(2000)
	}
	if ($('#mileageInput').val() < Number($('#mileageInput').attr('min'))) {
		$('#mileageInput').val(0)
		Swal.fire({
			icon: 'error',
			title: $('#mileageInput').attr('min') + '이상의 숫자를 입력해주세요.',
		});
	}
	console.log(total)
	$('#lastTotal').text((total - $('#mileageInput').val()).toLocaleString() + '원')
})
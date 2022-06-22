//아무 값이 없는데도 enter키를 누르면 이동하는 것 방지


$(function() {
	$.ajax({
		type: 'post',
		url: '/product/getProductsByProductName',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		dataType: 'json',
		data: {
			'product_name': $('#product_name').val()
		},
		success: function(data) {
			console.log(data);
			
			$.each(data, function(index, productDTO) {
				let fileCallPath = encodeURIComponent(productDTO.fileList[0].uploadPath + "/" + productDTO.fileList[0].uuid + "_" +  productDTO.fileList[0].fileName);
				$('<div/>',	{ 
					class: 'col-12 col-sm-6 col-md-3', 
					style: 'border:none; padding:10px' })
					.append($('<a/>',
						{'href':'/product/detail?product_num='+productDTO.product_num})
						.append($('<img/>', { 
							src: '/file/display?fileName=/' + fileCallPath , 
							style: 'border:none' }))
						.append($('<div/>', {
							html: productDTO.product_name + '<br>' + productDTO.product_price.toLocaleString() + '원' })))
					.appendTo($('#searchListsDiv'));
			});		 
			$('<p/>', { style: "font-size:18px; text-align:left; font-weight: bold; padding-top:25px; padding-left:25px", html: data.length + '&nbsp' + "items" }).appendTo($('#searchResultDiv'));
		},
		error: function(err) {
			console.log(err);
		}
	});
});
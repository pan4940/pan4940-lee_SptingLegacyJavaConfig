$(function() {
	let member_id = $("#member_id").val();
	console.log(member_id);
	
	if(member_id == ''){
		$("#moveReviewWriteForm").hide();
	} else {
		$("#moveReviewWriteForm").show();
	}
	
	$.ajax({
		url: '/board/getProductReview',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		data: {
			'product_num': $('#product_num').val()
		},
		type: 'post',
		dataType: 'json',
		success: function(data) {
			console.log(data)
			if (data.length > 0) {
				$('#nothingContent').hide();
				$('#reviewTableDiv').show();
				$.each(data, function(index, item) {
					$('<tr/>').append(
						$('<td/>', { text: item.board_num })
					).append(
						$('<td/>').append($('<a/>', { class:"getReview",'data-board_num':item.board_num,text:item.subject}))
					).append(
						$('<td/>', { text: item.member_name })
					).append(
						$('<td/>', { text: item.regDate})
					).appendTo($('#reviewTable'));
				})
				
				$('.getReview').on("click",function(e){
					e.preventDefault();
					console.log()
					$('#actionForm').attr("action", "/board/get");
					$('#board_num').val(e.target.getAttribute("data-board_num"))
					$('#actionForm').submit();
				})
			} //end if
		},
		error: function(err) {
			console.log(err)
		}
	});


	$.ajax({
		url: '/product/getProductDTO',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		type: 'post',
		data: {
			'product_num': $('#product_num').val()
		},
		dataType: 'json',
		success: function(data) {
			console.log(data);
			let str = "";
			let fileCallPath = "";
			$.each(data.fileList, function(index, item) {
				fileCallPath = encodeURIComponent(item.uploadPath + "/" +item.uuid + "_" + item.fileName);
				str += "<div class='col-12 col-sm-6 target'>";
				str += "<img src='/file/display?fileName=/" +  fileCallPath  +  "' class='thumb-img'></div>"
			});
			console.log(str);
			$('#productDetailImage').append(str);
			
			console.log(data.product_name);
			$('#productNameDiv').text(data.product_name);
			$('<span/>').text(data.product_price.toLocaleString() + '원').prependTo($('#orderDiv'));
			$('<pre/>', { text: data.product_descrip }).appendTo($('#details'));


			$.each(data.productSizeList, function(index, item) {
				$('<option/>', { value: item.product_size_id, 'text': '' + item.product_size }).appendTo($('#sizesSelect'))
				$('<th/>', { text: item.product_size }).appendTo($('#product_size'));
				if (item.product_top_length != null)
					$('<td/>', { text: item.product_top_length }).appendTo($('#product_top_length'))
				if (item.product_shoulder != null)
					$('<td/>', { text: item.product_shoulder }).appendTo($('#product_shoulder'))
				if (item.product_chest != null)
					$('<td/>', { text: item.product_chest }).appendTo($('#product_chest'))
				if (item.product_sleeve != null)
					$('<td/>', { text: item.product_sleeve }).appendTo($('#product_sleeve'))
				
				if (item.product_waist_width != null)
					$('<td/>', { text: item.product_waist_width }).appendTo($('#product_waist_width'))
				if (item.product_thigh_width != null)
					$('<td/>', { text: item.product_thigh_width }).appendTo($('#product_thigh_width'))
				if (item.product_bottom_length != null)
					$('<td/>', { text: item.product_thigh_width }).appendTo($('#product_bottom_length'))	
				if (item.product_ankle_circumference != null)
					$('<td/>', { text: item.product_ankle_circumference }).appendTo($('#product_ankle_circumference'))
				if (item.product_front_rise != null)
					$('<td/>', { text: item.product_front_rise }).appendTo($('#product_front_rise'))
					
				if (item.product_cap_length != null)
					$('<td/>', { text: item.product_cap_length }).appendTo($('#product_cap_length'))
				if (item.product_cap_circumference != null)
					$('<td/>', { text: item.product_cap_circumference }).appendTo($('#product_cap_circumference'))
				if (item.product_cap_depth != null)
					$('<td/>', { text: item.product_cap_depth }).appendTo($('#product_cap_depth'))	
				
				if (item.product_detail != null)
					$('<td/>', { text: item.product_detail, 'colspan': 'auto' }).appendTo($('#product_detail'))
			});
			
			
			
			$.each($('table tr'), function(index, item) {
				if (item.childElementCount == 1 || item.childElementCount == 0) {
					item.style.display = 'none';
				}
				if (item.childElementCount == 1) {
					if (item.getAttribute('id') == 'product_detail')
						item.style.display = 'block';
				}

			});
			
			/**/
			
			$('.target').append('<div class="photo"></div>').children('.photo').css({
            	'background-image': 'url(' + $('.target img').attr('src') + ')'
    		});
   		},
		error: function(err) {
			console.log(err);
		}
	});
	
	
	
	
	$(document).on("click", "#addCart", function(){
		console.log("클릭");
		console.log($('#sizesSelect').val());
		
		if ($('#sizesSelect').val() == '') {
			alert('사이즈를 선택해 주세요');
		} else {
			
			$.ajax({
				url: '/order/addCart',
				headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
				type: 'post',
				data: {
					'product_size_id': $('#sizesSelect').val()
				},
				success: function() {
					alert('상품을 담았습니다');
				},
				error: function(err) {
					alert('로그인후 이용해주세요!');
				},
			}); //end ajax
		}
		
	});	
	
	$(document).on("click", "#quickOrder", function(){
		
		if ($('#sizesSelect').val() == '') {
			alert('사이즈를 선택해 주세요');
		} else {
			location.href = "/order/quickOrder?product_num=" + $('#sizesSelect').val();
		}
		
	});	

});


	
// Select all tabs
$('.nav-tabs a').click(function() {
	$(this).tab('show');
})



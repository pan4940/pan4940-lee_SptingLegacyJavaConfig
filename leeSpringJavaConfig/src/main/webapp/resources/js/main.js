$(function() {
	
	$.ajax({
		type: 'post',
		url: '/product/recommendBrand',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		dataType: 'json',
		success: function(data) {
			
			$.each(data, function(index, item) {
				let fileCallPath = encodeURIComponent(item.fileList[0].uploadPath + "/" +item.fileList[0].uuid + "_" + item.fileList[0].fileName);
				$('#recommendBrand' + index + ' a').attr({class: 'move',  href: '/product/list-brand?product_category_num=' + item.product_category_num});	
				$('#recommendBrand' + index + ' img').attr('src', '/file/display?fileName=/' + fileCallPath);
			});
		},
		error: function(err) {
			console.log(err)
		}
	})
	
	$.ajax({
		type: 'post',
		url: '/board/getNewPost',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		dataType: 'json',
		success: function(boardDTO) {
			$('<a/>', { href: boardDTO.board_num, class: 'move' }).append(
				$('<img/>', { src: '/file/display?fileName=/' + boardDTO.fileList[0].uploadPath + '/' + boardDTO.fileList[0].uuid + '_' + boardDTO.fileList[0].fileName })
			).appendTo($('#post_image'));
			$('<a/>', { href: boardDTO.board_num, class: 'move' }).append(
				$('<span/>').text(boardDTO.subject)
			).appendTo($('#post_content'));
			$('<p/>').html(boardDTO.content).appendTo($('#post_content'));
			$('<a/>', { href: boardDTO.board_num, class: 'move' }).text('Read more').appendTo($('#post_content'));
			
			let actionForm = $("#actionForm");
			
			$(".move").on("click", function(e) {
				e.preventDefault();
				console.log($(this).attr("href"));
				$("input[name='board_num']").val($(this).attr('href'));
				actionForm.attr("action", "/board/get");
				console.log(actionForm);
				actionForm.submit();
			});
		},
		error: function(err) {
			console.log(err)
		}
	});
	
	$.ajax({
		type: 'post',
		url: '/product/getRecommendShoesBrand',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		dataType: 'json',
		success: function(data) {
			console.log(data)
			$.each(data, function(index, item) {
				let fileCallPath = encodeURIComponent(item.fileList[0].uploadPath + "/" +item.fileList[0].uuid + "_" + item.fileList[0].fileName);
				$('#recommendShoesBrand' + index + ' img').attr('src', '/file/display?fileName=/' + fileCallPath);
				$('#recommendShoesBrand' + index + ' a').attr({class: 'move',  href: '/product/list-brand?product_category_num=' + item.brandCategory});
			});
		},
		error: function(err) {
			console.log(err)
		}
	});
	
	
	
	/*$.ajax({
		type: 'post',
		url: '/getMainProduct',
		success: function(data) {
			console.log(data)
			$.each(data, function(index, items) {
				if (index < 8) {
					$('<div/>', {style:"position: relative", class: 'col-6 col-sm-3 product_infoDiv' }).append(
						$('<a/>', { 'href': '/detail?seq=' + items.product_number }).append($('<img/>', { src: '/storage/' + items.stored_thumbnail,height:'100%' }))
					).append($('<div/>',{style:"position: absolute; bottom: 0; display:none",html:items.product_name+'<br>'+items.product_price.toLocaleString()+ '원'})).appendTo($('#ourproductSample'))
				}

			});
			$('.product_infoDiv').hover(function(){
				if(this.children[1].style.display=='none')
					this.children[1].style.display='block';
				else
					this.children[1].style.display='none';
			})
		},
		error: function(data) {
			console.log(data)
		}
	});*/
})
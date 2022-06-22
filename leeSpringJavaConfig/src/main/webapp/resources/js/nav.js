
$(function() {
	if (window.innerWidth < 800) {
		$('#second_large').hide();
	} else {
		$('#second_small').hide();
	}
	$("#fourth").hide();
	
});


$("#second_large span").mouseover(function(event) {
	$("#third_largen").css("display", "flex");
	$("#third_large").empty();
	if (event.currentTarget.innerText == "MEN") {
		$("<div/>", { class: 'col-3' })
			.append(
				$("<ul/>")
					.append($("<li/>").append($("<a/>", { text: "TOP", href: "/product/list?product_category_num=1100" })))
					.append($("<li/>").append($("<a/>", { text: "BOTTOM", href: "/product/list?product_category_num=1200" })))
					.append($("<li/>").append($("<a/>", { text: "BAG", href: "/product/list?product_category_num=1300" })))
					.append($("<li/>").append($("<a/>", { text: "HANDWEAR", href: "/product/list?product_category_num=1400" })))
					.append($("<li/>").append($("<a/>", { text: "ACCESSORIES", href: "/product/list?product_category_num=1500" })))
					.append($("<li/>").append($("<a/>", { text: "SHOES", href: "/product/list?product_category_num=1600" })))
					.append($("<li/>").append($("<a/>", { text: "COLLABORATIONS", href: "/product/list?product_category_num=1700" }))
				)
			)
		.appendTo($("#third_large"));
		
		$("<div/>", { class: 'col-3' })
			.appendTo($("#third_large"));
			
		//반복문. 2개의 남성브랜드 정보 가져와서 2번 반복하게 할 것. 
		$.ajax({
			type: 'post',
			headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
			url: '/product/getNavMenProductCategoryDTO',
			dataType: 'json',
			success: function(data) {
				$.each(data, function(index,item){
					let fileCallPath = encodeURIComponent(item.fileList[0].uploadPath + "/" + item.fileList[0].uuid + "_" +  item.fileList[0].fileName);
					$("<div/>", { "id": "menuimage" + index, class: "col-3" })
						.append($("<a/>", {href: '/product/list-brand?product_category_num=' + item.product_category_num}).append($("<p/>")).append($("<img/>",{style:'margin-left:10px;height:80%', src: '/file/display?fileName=/' + fileCallPath})))
						.append($("<a/>", {href: '/product/list-brand?product_category_num=' + item.product_category_num}).append($("<p/>", {text: item.product_category_name})))
						.appendTo($("#third_large"));	
				});
			},
			error: function(err) {
				console.log(err)
			}
		}); //end ajax
		
	
	} else if (event.currentTarget.innerText == "WOMEN") {
		$("<div/>", { class: 'col-3' })
			.append(
				$("<ul/>")
					.append($("<li/>").append($("<a/>", { text: "TOP", href: "/product/list?product_category_num=2100" })))
					.append($("<li/>").append($("<a/>", { text: "BOTTOM", href: "/product/list?product_category_num=2200" })))
					.append($("<li/>").append($("<a/>", { text: "BAG", href: "/product/list?product_category_num=2300" })))
					.append($("<li/>").append($("<a/>", { text: "HANDWEAR", href: "/product/list?product_category_num=2400" })))
					.append(
						$("<li/>").append($("<a/>", { text: "ACCESSORIES", href: "/product/list?product_category_num=2500" }))
					)
					.append($("<li/>").append($("<a/>", { text: "SHOES", href: "/product/list?product_category_num=2600" })))
			)
			.appendTo($("#third_large"));
			
			
		$("<div/>", { class: 'col-3' })
			.appendTo($("#third_large"));
			
		//반복문. 2개의 여성브랜드 정보 가져와서 2번 반복하게 할 것. 
		$.ajax({
			type: 'post',
			headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
			url: '/product/getNavWomenProductCategoryDTO',
			dataType: 'json',
			success: function(data) {
				$.each(data, function(index,item){
					let fileCallPath = encodeURIComponent(item.fileList[0].uploadPath + "/" + item.fileList[0].uuid + "_" +  item.fileList[0].fileName);
					$("<div/>", { "id": "menuimage" + index, class: "col-3" })
						//.append($("<a/>").append($("<p/>")).append($("<img/>",{style:'margin-left:10px;height:80%', src: '/file/display?fileName=/' + fileCallPath})))
						.append($("<a/>", {href: '/product/list-brand?product_category_num=' + item.product_category_num}).append($("<p/>")).append($("<img/>",{style:'margin-left:10px;height:80%', src: '/file/display?fileName=/' + fileCallPath})))
						.append($("<a/>", {href: '/product/list-brand?product_category_num=' + item.product_category_num}).append($("<p/>", {text: item.product_category_name})))
						.appendTo($("#third_large"));	
				});
			},
			error: function(err) {
				console.log(err)
			}
		}); //end ajax
			
	
	} else if (event.currentTarget.innerText == "BRANDS") {
		$("<div/>", { class: 'col-3', id:'navBrands'}).append($("<ul/>")).appendTo($("#third_large"));
			
		$.ajax({
			type: 'post',
			headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
			url: '/product/getNavBrandProductCategoryDTO',
			dataType: 'json',
			success: function(data) {
				
				$.each(data.brandCategory, function(index,item){
					$("#navBrands ul").
						append($("<li/>")
							.append($("<a/>", { text: item.product_category_name, href: "/product/list-brand?product_category_num=" + item.product_category_num}))
					)
				});
				$("#navBrands").appendTo($("#third_large"));
				
				
				$.each(data.threeProductCategoryDTO, function(index,item){
					let fileCallPath = encodeURIComponent(item.fileList[0].uploadPath + "/" + item.fileList[0].uuid + "_" +  item.fileList[0].fileName);
					$("<div/>", { "id": "menuimage" + index, class: "col-3" })
						//.append($("<a/>").append($("<p/>")).append($("<img/>",{style:'margin-left:10px;height:80%', src: '/file/display?fileName=/' + fileCallPath})))
						.append($("<a/>", {href: '/product/list-brand?product_category_num=' + item.product_category_num}).append($("<p/>")).append($("<img/>",{style:'margin-left:10px;height:80%', src: '/file/display?fileName=/' + fileCallPath})))
						.append($("<a/>", {href: '/product/list-brand?product_category_num=' + item.product_category_num}).append($("<p/>", {text: item.product_category_name})))
						.appendTo($("#third_large"));	
				});
			},
			error: function(err) {
				console.log(err)
			}
		}); //end ajax
			
	} else if (event.currentTarget.innerText == "POST") {
		
		//반복문. 4개의 포스트 정보 가져와서 2번 반복하게 할 것. 
		$.ajax({
			type: 'post',
			headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
			url: '/board/getNavPostBoardDTO',
			dataType: 'json',
			success: function(data) {
				$.each(data, function(index,item){
					
					let fileCallPath = encodeURIComponent(item.fileList[0].uploadPath + "/" + item.fileList[0].uuid + "_" +  item.fileList[0].fileName);
					$("<div/>", { "id": "menuimage" + index, class: "col-3" })
						.append($("<a/>", {href: '/board/get?board_category_num=7&board_num=' + item.board_num}).append($("<p/>")).append($("<img/>",{style:'margin-left:10px;height:80%', src: '/file/display?fileName=/' + fileCallPath})))
						.append($("<a/>").append($("<p/>", {text: item.subject})))
						.appendTo($("#third_large"));	
				});
			},
			error: function(err) {
				console.log(err)
			}
		}); //end ajax
	}

	$("li a").mouseenter(function(event) {
		event.currentTarget.setAttribute(
			"style",
			"color:gray;text-decoration:underline"
		);
	});
	
	$("li a").mouseleave(function(event) {
		event.currentTarget.setAttribute("style", "color:black");
	});
	
});

$("nav").mouseleave(function() {
	$("#third_large").attr("style", "display:none");
});


$(".search").click(function() {
	$("#fourth ").animate({ height: "toggle" }, 300, "linear");
});
$("#searchCloseBtn").click(function() {
	$("#fourth").animate({ height: "toggle" }, 200, "linear");
});


$(window).resize(function() {
	if (window.innerWidth < 810) {
		$('#second_large').hide();
		$('#second_small').show();
		$('#third_large').hide();
		$('#third_small').hide();
	} else {
		$('#second_large').show();
		$('#second_small').hide();
		$('#third_large').hide();
		$('#third_small').hide();
	}
});

$('#menu').hover(function() {
	$('#menu i').toggleClass("fa-bars fa-bars-staggered");
});
$("#menu").click(function() {
	$("#third_small").toggle();
});
$("#account").hover(function() {
	$("#account_drop").css("display", "block");
});
$("#account_drop").mouseleave(function() {
	$("#account_drop").css("display", "none");
});

//로그아웃  
$('.logoutBtn').click(function() {
	kakaoLogout();
    naverLogin.logout();
	
	$("#logoutForm").submit();
	
	/*$.ajax({
		type: 'post',
		url: '/member/logout',
		success: function() {
			Swal.fire({
				icon: 'success',
				title: '로그아웃 되었습니다',
				closeOnClickOutside: false
			}).then(function() {
				location.href = '/';
			});


		},

		error: function(err) {
			alert(err);
		}
	});*/
});

$('input[id="keyword"]').keydown(function(event) {
	//Javascript 키보드 키코드 값.. enter는 13이다. 
	if (event.keyCode === 13) {
		if ($('#keyword').val() === '') {
			event.preventDefault();
			Swal.fire({
				icon: 'warning',
				title: '검색어를 입력하세요!',
			});
		}
	};
});

$('.cart').click(function() {
	location.href = '/order/cart'
})


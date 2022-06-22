<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>Admin</title>
	

<link rel="stylesheet" href="/resources/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="/resources/bootstrap/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="/resources/bootstrap/bootstrap.min.js"></script>
	
<style>
	body { font-family:'맑은 고딕', verdana; padding:0; margin:0; }
	ul { padding:0; margin:0; list-style:none;  }
 
	div#root { width:90%; margin:0 auto; }
	
	header#header { font-size:60px; padding:20px 0; }
	header#header h1 a { color:#000; font-weight:bold; }
	
	nav#nav { padding:10px; text-align:right; }
	nav#nav ul li { display:inline-block; margin-left:10px; }
 
 		section#container { padding:20px 0; border-top:2px solid #eee; border-bottom:2px solid #eee; }
	section#container::after { content:""; display:block; clear:both; }
	aside { float:left; width:200px; }
	div#container_box { float:right; width:calc(100% - 200px - 20px); }
	
	aside ul li { text-align:center; margin-bottom:10px; }
	aside ul li a { display:block; width:100%; padding:10px 0;}
	aside ul li a:hover { background:#eee; }
	
	footer#footer { background:#f9f9f9; padding:20px; }
	footer#footer ul li { display:inline-block; margin-right:10px; } 
	
.uploadResult {
width: 100%;
background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 100px;
}

.uploadResult ul li span {
	color: white;
}

.bigPictureWrapper{
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background:rgba(255,255,255,0.5);
}

.bigPicture{
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img{
	width: 600px;
}
.psize label{
	width: 100px;
}

</style>


<style>
.inputArea { margin:10px 0; }
select { width:100px; }
label { display:inline-block; width:70px; padding:5px; }
label[for='gdsDes'] { display:block; }
input { width:150px; }
textarea#gdsDes { width:400px; height:180px; }

.select_img img { width:500px; margin:20px 0; }

</style>

</head>
<body>
<div id="root">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<header id="header">
		<div id="header_box">
			<%@ include file="../admin/include/header.jsp" %>
		</div>
	</header>

	<nav id="nav">
		<div id="nav_box">
			<%@ include file="../admin/include/nav.jsp" %>
		</div>
	</nav>
	
	<section id="container">
		<aside>
			<%@ include file="../admin/include/aside.jsp" %>
		</aside>
		
		<div id="container_box">
			<h2>사이즈 관리</h2>
			<form id="searchForm" method="post" autocomplete="off">
				<div class="searchInputArea">	
				<label>1차 분류</label>
				<select class="searchCategory1" name="cateCode1">
					<option value="">전체</option>
				</select>			
				<label>2차 분류</label>
				<select class="searchCategory2" name="cateCode2">
					<option value="">전체</option>
				</select>
				<label>3차 분류</label>
				<select class="searchCategory3" name="cateCode3">
					<option value="">전체</option>
				</select>
					
				<label>브랜드명</label>
				<select class="searchBrandCategory" name="brandCategory">
					<option value="">전체</option>
				</select>
				
				<button type="button" id="search_Btn" class="btn btn-primary">검색</button>
			</div>
			</form>
			
			<div class="searchResult">
				<table border="1">
					
				</table>
			</div>
			
			
			<%-- 사이즈 등록 수정 --%>
			
			<div>
			<h2>사이즈 관리</h2>
			
				<div class="searchSizeResult">
					<table border="1">
						
					</table>
				</div>
			
				<form id="productSize" action="/product/registerProductSize" method="post">
					
					<div class="tab-pane container" id="size">
						<input type="hidden" id="product_num" name="product_num" value="">
						<input type="hidden" id="product_size_id" name="product_size_id" value="0">
						<div class="psize">
							<label>상품명</label>
							<input type="text" id="product_name" name="product_name" value="">
						</div>
						
						<div class="psize">
							<label>SIZE</label>
							<input type="text" id="product_size" name="product_size" value="">
						</div>
						
						<div class="top">
							<div class="psize">
								<label>기장</label>
								<input type="text" id="product_top_length" name="product_top_length" value="">
							</div>
							<div class="psize">
								<label>어깨</label>
								<input type="text" id="product_shoulder" name="product_shoulder" value="">
							</div>
							<div class="psize">
								<label>가슴</label>
								<input type="text" id="product_chest" name="product_chest" value="">
							</div>
							<div class="psize">
								<label>소매</label>
								<input type="text" id="product_sleeve" name="product_sleeve" value="">
							</div>
						</div>
						
						<div class="bottom">
							<div class="psize">
								<label>허리</label>
								<input type="text" id="product_waist_width" name="product_waist_width" value="">
							</div>
							<div class="psize">
								<label>허벅지</label>
								<input type="text" id="product_thigh_width" name="product_thigh_width" value="">
							</div>
							<div class="psize">
								<label>기장</label>
								<input type="text" id="product_bottom_length" name="product_bottom_length" value="">
							</div>
							<div class="psize">
								<label>밑단</label>
								<input type="text" id="product_ankle_circumference" name="product_ankle_circumference" value="">
							</div>
							<div class="psize">
								<label>밑위</label>
								<input type="text" id="product_front_rise" name="product_front_rise" value="">
							</div>
						</div>
						
						<div class="cap">
							<div class="psize">
								<label>챙길이</label>
								<input type="text" id="product_cap_length" name="product_cap_length" value="">
							</div>
							<div class="psize">
								<label>챙둘레</label>
								<input type="text" id="product_cap_circumference" name="product_cap_circumference" value="">
							</div>
							<div class="psize">
								<label>깊이</label>
								<input type="text" id="product_cap_depth" name="product_cap_depth" value="">
							</div>
						</div>
						
						<div id="product_detail" style="border-style: none;">
						</div>
						
					</div>				
				</form>
			</div>
			
			
			<div class="inputArea">
				<button type="button" id="register_Btn" class="btn btn-primary">등록</button>
				<button type="button" id="update_Btn" class="btn btn-primary">수정</button>
				<button type="button" id="back_Btn" class="btn btn-warning">초기화</button>			

			</div>
			
			</form>
			
		</div> 
	</section>


	<footer id="footer">
		<div id="footer_box">
			<%@ include file="../admin/include/footer.jsp" %>
		</div>		
	</footer>

</div>
<script>
// 컨트롤러에서 데이터 받기
// 필요한 배열과 오브젝트 변수 생성
let ProductsCategoryList;
let BrandsCategoryList;
var cate1Arr = new Array();
var cate1Obj = new Object();

$(document).ready(function(){
	
	$.ajax({
		type: 'post',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		url: '/product/getProductCategoryList',
		dataType: 'json',
		success: function(result){
			ProductsCategoryList = result;
			createCate(ProductsCategoryList);
		},
	});

	$.ajax({
		type: 'post',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		url: '/product/getBrandsCategoryList',
		dataType: 'json',
		success: function(result){
			BrandsCategoryList = result;
			createBrandCategory(BrandsCategoryList);
		},
	});
	//jsonData = $("#list").val();
	//console.log(jsonData[0]);
	
	$(".top").hide();
	$(".bottom").hide();
	$(".cap").hide();
}());



//브랜드명 셀렉트 박스에 삽입할 데이터 준비
function createBrandCategory(jsonData){
	
	var brandCateArr = new Array();
	var brandCateObj = new Object();
	
	for(var i = 0; i < jsonData.length; i++) {
		
		if(jsonData[i].level == "2") {  // 레벨이 1인 데이터가 있다면 
			brandCateObj = new Object();  // 초기화
			
			// brandCateObj에 cateCode와 cateName를 저장
			brandCateObj.product_category_num = jsonData[i].product_category_num; 
			brandCateObj.product_category_name = jsonData[i].product_category_name;
			
			// brandCateObj에 저장된 값을 brandCateArr 배열에 저장
			brandCateArr.push(brandCateObj);
		}
	}
	//console.log(brandCateArr);

	// 검색조건 브랜드명 셀렉트 박스에 데이터 삽입
	var brandSelect1 = $("select.searchBrandCategory")

	for(var i = 0; i < brandCateArr.length; i++) {

		// cate1Arr에 저장된 값을 cate1Select에 추가
		brandSelect1.append("<option value='" + brandCateArr[i].product_category_num + "'>"
							+ brandCateArr[i].product_category_name + "</option>");	
	}
	
};













function createCate(ProductsCategoryList){
	for(var i = 0; i < ProductsCategoryList.length; i++) {
		
		if(ProductsCategoryList[i].level == "1") {  // 레벨이 1인 데이터가 있다면 
			cate1Obj = new Object();  // 초기화
			
			// cate1Obj에 cateCode와 cateName를 저장
			cate1Obj.product_category_num = ProductsCategoryList[i].product_category_num; 
			cate1Obj.product_category_name = ProductsCategoryList[i].product_category_name;
			
			// cate1Obj에 저장된 값을 cate1Arr 배열에 저장
			cate1Arr.push(cate1Obj);
		}
	}
	console.log(cate1Arr);

	// 1차 분류 셀렉트 박스에 데이터 삽입
	var cate1Select1 = $("select.searchCategory1")

	for(var i = 0; i < cate1Arr.length; i++) {

		// cate1Arr에 저장된 값을 cate1Select에 추가
		cate1Select1.append("<option value='" + cate1Arr[i].product_category_num + "'>"
							+ cate1Arr[i].product_category_name + "</option>");	
	}
	
};


//1차 분류 카테고리
// 클래스가 category1인 select변수의 값이 바뀌었을 때 실행
$(document).on("change", "select.searchCategory1", function(){
	change1("search");
});

$(document).on("change", "select.searchCategory2", function(){
	change2("search");
});

$(document).on("change", "select.category1", function(){
	change1("noSearch");
});

$(document).on("change", "select.category2", function(){
	change2("noSearch");
});


function change1(lee){
	// 필요한 배열과 오브젝트 변수를 생성
	console.log("change method")
	var cate2Arr = new Array();
	var cate2Obj = new Object();
	
	// 2차 분류 셀렉트 박스에 삽입할 데이터 준비
	for(var i = 0; i < ProductsCategoryList.length; i++) {
		
		if(ProductsCategoryList[i].level == "2") {  // 레빌이 2인 데이터가 있다면
			cate2Obj = new Object();  // 초기화
			
			// cate2Obj에 cateCode, cateName, cateCodeRef를 저장
			cate2Obj.product_category_num = ProductsCategoryList[i].product_category_num;
			cate2Obj.product_category_name = ProductsCategoryList[i].product_category_name;
			cate2Obj.product_category_num_ref = ProductsCategoryList[i].product_category_num_ref;
			
			// cate2Obj에 저장된 값을 cate1Arr 배열에 저장
			cate2Arr.push(cate2Obj);
		} 
	}
	
	console.log(cate2Arr);
	
	var cate1Select;
	var cate2Select;
	
	
	if(lee == 'search'){
		console.log("성공");
		cate1Select = $("select.searchCategory1");
		cate2Select = $("select.searchCategory2");
	} else {
		console.log("실패");
		cate1Select = $("select.category1");
		cate2Select = $("select.category2");
	}
	console.log(cate2Select);
	
	cate2Select.children().remove();
	// cate2Select의 값을 제거함(초기화)
 
	// cate1Select에서 선택한 값을 기준으로 cate2Select의 값을 조정
	$("option:selected", cate1Select).each(function(){
		var selectVal = cate1Select.val();  // 현재 선택한 cate1Select의 값을 저장
		console.log(selectVal);
		cate2Select.append("<option value='" + selectVal + "'>전체</option>");  // cate2Select의 '전체'에 현재 선택한 cate1Select와 같은 값 부여
		// cate2Arr의 데이터를 cate2Select에 추가
		for(var i = 0; i < cate2Arr.length; i++) {
			// 현재 선택한 cate1Select의 값과 일치하는 cate2Arr의 데이터를 가져옴
			if(selectVal == cate2Arr[i].product_category_num_ref) {
				cate2Select.append("<option value='" + cate2Arr[i].product_category_num + "'>"
									+ cate2Arr[i].product_category_name + "</option>");
			}
		}		
	});
}



function change2(lee){
	// 필요한 배열과 오브젝트 변수를 생성
	var cate3Arr = new Array();
	var cate3Obj = new Object();
	
	// 2차 분류 셀렉트 박스에 삽입할 데이터 준비
	for(var i = 0; i < ProductsCategoryList.length; i++) {
		
		if(ProductsCategoryList[i].level == "3") {  // 레빌이 2인 데이터가 있다면
			cate3Obj = new Object();  // 초기화
			
			// cate2Obj에 cateCode, cateName, cateCodeRef를 저장
			cate3Obj.product_category_num = ProductsCategoryList[i].product_category_num;
			cate3Obj.product_category_name = ProductsCategoryList[i].product_category_name;
			cate3Obj.product_category_num_ref = ProductsCategoryList[i].product_category_num_ref;
			
			// cate2Obj에 저장된 값을 cate1Arr 배열에 저장
			cate3Arr.push(cate3Obj);
		} 
	}
	
	var cate2Select;
	var cate3Select;
	if(lee == 'search'){
		cate2Select = $("select.searchCategory2");
		cate3Select = $("select.searchCategory3");
	} else {
		cate2Select = $("select.category2");
		cate3Select = $("select.category3");
	}
	
	// cate3Select의 값을 제거함(초기화)
	cate3Select.children().remove();
	
	
 
	$("option:selected", cate2Select).each(function(){
		var selectVal = cate2Select.val();  
	
		cate3Select.append("<option value='" + selectVal + "'>전체</option>");  // cate3Select의 '전체'에 현재 선택한 cate2Select와 같은 값 부여
		
		for(var i = 0; i < cate3Arr.length; i++) {
			
			if(selectVal == cate3Arr[i].product_category_num_ref) {
				cate3Select.append("<option value='" + cate3Arr[i].product_category_num + "'>"
									+ cate3Arr[i].product_category_name + "</option>");
			}
		}		
	});
	
}




var regExp = /[^0-9]/gi;

$("#product_price").keyup(function(){ numCheck($(this)); });
$("#product_price").keyup(function(){ numCheck($(this)); });

function numCheck(selector) {
	var tempVal = selector.val();
	selector.val(tempVal.replace(regExp, ""));
}

//검색버튼 클릭

let productList;

$("#search_Btn").on("click", function(){
	$.ajax({
		type: 'post',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		data: $("#searchForm").serialize(),
		url: '/product/getProductByCategory',
		dataType: 'json',
		success: function(result){
			productList = result;
			console.log(productList);
			
			$(".searchResult").children('table').children().remove();
			
			$(".searchResult").children('table').append("<tr>" +
					"<td>목록추가</td>" +
					"<td>상품명</td>" +
					"<td>브랜드명</td>" +
					"<td>카테고리1</td>" + 
					"<td>카테고리2</td>" +
					"<td>카테고리3</td>" +
					"<td>카테고리4</td>" +
					"<td>가격</td>" +
					"</tr>");
			
			$.each(result, function(index, item){
				$(".searchResult").children('table').append(
								"<tr><td><input type='checkbox' id='checkProduct_num' name='checkProduct_num' value='" + item.product_num + "'></td>" +
								"<td><a class='searchProductMove' href='" + item.product_num +"'>" + item.product_name + "</a></td>"+
								"<td>" + item.brand_name + "</td>"+
								"<td>" + item.cateCode1 + "</td>"+
								"<td>" + item.cateCode2 + "</td>"+
								"<td>" + item.cateCode3 + "</td>"+
								"<td>" + item.brandCategory + "</td>"+
								"<td>" + item.product_price + "</td>"+
								"</td></tr>"
				);
			});
		},
		error: function(e) {
			console.log(e);
		}
	});
});


$(document).on("click", "a.searchProductMove", function(e){
	e.preventDefault();
	
	
	$.ajax({
		type: 'post',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		data: 'product_num=' + $(this).attr("href"),
		url: '/product/getProductByProductNum',
		dataType: 'json',
		
		success: function(result){
			console.log(result.productSizeList);
			
			$(".searchSizeResult").children('table').children().remove();
			
			$(".searchSizeResult").children('table').append("<tr>" +
					"<td>목록추가</td>" +
					"<td>상품명</td>" +
					"<td>사이즈</td>" +
					"<td>삭제</td>" +
					"</tr>"
			);
			
			$.each(result.productSizeList, function(index, item){
				$(".searchSizeResult").children('table').append(
					"<tr><td><input type='checkbox' id='searchProduct_size_id' name='searchProduct_size_id' value='" + item.product_size_id + "'></td>" +
					"<td>" + result.product_name + "</td>"+
					"<td><a class='searchProductSizemove' href='" + item.product_size_id +"'>" + item.product_size + "</a></td>" +
					"<td><button type='button' id='delete_Btn' value='" + item.product_size_id + "'>삭제</button></td>" + 
					"</tr>"
				);
			});
			
			$("#product_name").val(result.product_name);
			$("#product_num").val(result.product_num);
			
			if (result.cateCode2 == 1100 || result.cateCode2 == 2100) {
				$(".top").show();
								
			} else if (result.cateCode2 == 1200 || result.cateCode2 == 2200) {
				$(".bottom").show();
			} else if (result.cateCode2 == 1400 || result.cateCode2 == 2400) {
				$(".cap").show();
			} 
		},
		
		error: function(e) {
			console.log(e);
		},
	}); //end ajax
	
	
});

$(document).on("click", "a.searchProductSizemove", function(e){
	e.preventDefault();
	
	$("#register_Btn").hide();
	
	$.ajax({
		type: 'post',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		data: 'product_size_id=' + $(".searchProductSizemove").attr("href"),
		url: '/product/getProductSizeByProductSizeId',
		dataType: 'json',
		success: function(result){
			console.log(result);
			$("#product_size_id").val(result.product_size_id);
			$("#product_size").val(result.product_size);
			$("#product_top_length").val(result.product_top_length);
			$("#product_shoulder").val(result.product_shoulder);
			$("#product_chest").val(result.product_chest);
			$("#product_sleeve").val(result.product_sleeve);
			$("#product_waist_width").val(result.product_waist_width);
			$("#product_thigh_width").val(result.product_thigh_width);
			$("#product_bottom_length").val(result.product_bottom_length);
			$("#product_ankle_circumference").val(result.product_ankle_circumference);
			$("#product_front_rise").val(result.product_front_rise);
			$("#product_cap_length").val(result.product_cap_length);
			$("#product_cap_circumference").val(result.product_cap_length);
			$("#product_cap_depth").val(result.product_cap_length);

			/* if (result.cateCode2 == 1100 || result.cateCode2 == 2100) {
				$(".top").show();
								
			} else if (result.cateCode2 == 1200 || result.cateCode2 == 2200) {
				$(".bottom").show();
			} else if (result.cateCode2 == 1400 || result.cateCode2 == 2400) {
				$(".cap").show();
			}  */
			
		},
		error: function(e) {
			console.log(e);
		}
	});
}); 

$(document).on("click", "#delete_Btn", function(e){
	console.log("delete click");
	console.log($(this).val());
	$.ajax({
		type: 'post',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		data: 'product_size_id=' +  $(this).val(),
		url: '/product/deleteProductSize',
		success: function(){
			alert("사이즈를 삭제했습니다.");
			location.href = "/product/productSizeForm";
		},
		error: function(e) {
			console.log(e);
		}
	});	
	
});

</script>

<script type="text/javascript">
//수정 버튼 클릭시 이벤트
$("#update_Btn").on("click", function(e){
   e.preventDefault();
   $("#productSize").attr("action", "/product/modifyProductSize");
   
	$.ajax({
		type: 'post',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		data: $("#productSize").serialize(),
		url: '/product/modifyProductSize',
		success: function(){
			console.log("사이즈 정보 수정");
			alert("수정이 완료되었습니다.");
			location.href = "/product/productSizeForm";
		},
		error: function(e) {
			console.log(e);
		}
	});	
  
});


$("#register_Btn").on("click", function(){
	$.ajax({
		type: 'post',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		data: $("#productSize").serialize(),
		url: '/product/registerProductSize',
		success: function(){
			alert("사이즈가 등록되었습니다.");
			location.href = "/product/productSizeForm";
		},
		error: function(e) {
			console.log(e);
		}
	});	
	
});



$("#back_Btn").click(function(){
	//history.back();
	console.log("back_Btn");
	location.href = "/product/productSizeForm";
});		


</script>


</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>Admin</title>
	

<link rel="stylesheet" href="/resources/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="/resources/bootstrap/bootstrap-theme.min.css">
<script src="/resources/bootstrap/bootstrap.min.js"></script>

<script src="/resources/ckeditor/ckeditor.js"></script>
	
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
			<h2>상품 검색</h2>
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

				<input id="searchProduct" type="text" value="">
				<table id="tr" border="1">
					
					 <tr id="tr"></tr> -->
				</table>
			</div>
			
			
			<h2>상품 수정</h2>
			
			<form id="productModifyForm" method="post" action="/product/modify" autocomplete="off">
			<input type="hidden" id="product_num" name="product_num" value="" />
			
			<div class="inputArea">
				<div id="category1">	
					<label>1차 분류</label>
					<select class="category1" name="cateCode1">
						<option value="">전체</option>
					</select>
				</div>
				
				<div id="category2">	
					<label>2차 분류</label>
					<select class="category2" name="cateCode2">
						<option value="">전체</option>
					</select>
				</div>
				<div id="category3">	
					<label>3차 분류</label>
					<select class="category3" name="cateCode3">
						<option value="">전체</option>
					</select>
				</div>
				
				<div id="category4">	
					<label>브랜드명</label>
					<select class="category4" name="brandCategory">
						<option value="">전체</option>
					</select>
				</div>
			</div>
			
			<div class="inputArea">
				<label for="gdsName">상품명</label>
				<input type="text" id="product_name" name="product_name" style="width:300px"/>
			</div>
			
			<div class="inputArea">
				<label for="gdsPrice">상품가격</label>
				<input type="text" id="product_price" name="product_price" style="width:300px"/>
			</div>
			
			 <div class="inputArea">
				<label for="gdsStock">상품수량</label>
				<input type="text" id="gdsStock" name="gdsStock" style="width:300px"/>
			</div> -->
			
			<div class="inputArea">
				<label for="product_descrip">상품소개</label>
				<textarea rows="5" cols="50" id="product_descrip" name="product_descrip"></textarea>
				
				
			</div>
			
						
			<div class="uploadDiv">
				<input type="file" name="uploadFile" multiple>
			</div>   
			             
			<div class="uploadResult">
				<ul>
				</ul>
			</div>
			             
			<div class="bigPictureWrapper">
				<div class="bigPicture">
				</div>
			</div>
			
			
			
			
			<div class="inputArea">
				<button type="button" id="delete_Btn" class="btn btn-primary">삭제</button>
				<button type="button" id="update_Btn" class="btn btn-primary">수정</button>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
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

	// 검색조건 브랜드명 셀렉트 박스에 데이터 삽입
	var brandSelect1 = $("select.searchBrandCategory")

	for(var i = 0; i < brandCateArr.length; i++) {

		// cate1Arr에 저장된 값을 cate1Select에 추가
		brandSelect1.append("<option value='" + brandCateArr[i].product_category_num + "'>"
							+ brandCateArr[i].product_category_name + "</option>");	
	}
	
	
	//수정 폼 내의 브랜드명 셀렉트 박스에 데이터 삽입
	var brandSelect2 = $("select.category4")

	for(var i = 0; i < brandCateArr.length; i++) {

		// cate1Arr에 저장된 값을 cate1Select에 추가
		brandSelect2.append("<option value='" + brandCateArr[i].product_category_num + "'>"
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

	// 1차 분류 셀렉트 박스에 데이터 삽입
	var cate1Select1 = $("select.searchCategory1")

	for(var i = 0; i < cate1Arr.length; i++) {

		// cate1Arr에 저장된 값을 cate1Select에 추가
		cate1Select1.append("<option value='" + cate1Arr[i].product_category_num + "'>"
							+ cate1Arr[i].product_category_name + "</option>");	
	}
	
	var cate1Select2 = $("select.category1")

	for(var i = 0; i < cate1Arr.length; i++) {

		// cate1Arr에 저장된 값을 cate1Select에 추가
		cate1Select2.append("<option value='" + cate1Arr[i].product_category_num + "'>"
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
	
	cate2Select.children().remove();
	// cate2Select의 값을 제거함(초기화)
 
	// cate1Select에서 선택한 값을 기준으로 cate2Select의 값을 조정
	$("option:selected", cate1Select).each(function(){
		var selectVal = cate1Select.val();  // 현재 선택한 cate1Select의 값을 저장
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
			
			$("#tr").children().remove();
			
			$("#tr").append("<tr>" +
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
				$("#tr").append(
								"<tr><td><input type='checkbox' id='checkProduct_num' name='checkProduct_num' value='" + item.product_num + "'></td>" +
								"<td><a class='move' href='" + item.product_num +"'>" + item.product_name + "</a></td>"+
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


//검색된 상품 이름 클릭
$(document).on("click", "a.move", function(e){
	e.preventDefault();
	uploadResult.children().remove();
	$.ajax({
		type: 'post',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		data: 'product_num=' + $(this).attr("href"),
		url: '/product/getProductByProductNum',
		dataType: 'json',
		success: function(result){
			
			console.log(result);
			$("#product_num").val(result.product_num);
			$("#product_name").val(result.product_name);
			$("#product_price").val(result.product_price);
			$(".category4").val(result.brandCategory);
			$("#product_descrip").val(result.product_descrip);
			showUploadedFile(result.fileList);
			
			
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
   
   let str = ""
   $(".uploadResult ul li").each(function(i, obj) {
      let jobj = $(obj);
      
      str += "<input type='hidden' name='fileList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
      str += "<input type='hidden' name='fileList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
      str += "<input type='hidden' name='fileList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
      str += "<input type='hidden' name='fileList["+i+"].product_num' value='"+jobj.data("product_num")+"'>";
   });
   
   
   //$("#productModifyForm").append(str).submit();
   $("#productModifyForm").append(str); 
   
   $.ajax({
		url : '/product/modify',
		type: 'post',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		data: $("#productModifyForm").serialize(),
		//contentType: "application/json; charset=UTF-8;",
		success: function(){
			console.log("성공");
			alert("상품을 수정했습니다.");
			location.href="/product/modifyForm";
		},
		
	});
   
});


function getDeleteProductList(){
    let obj = $("[name=checkProduct_num]");
    let deleteProductArray = new Array(); // 배열 선언

    $('input:checkbox[name=checkProduct_num]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
    	deleteProductArray.push(this.value);
    });
    
    return deleteProductArray;
}



//상품 삭제
$("#delete_Btn").on("click", function(e) {
	e.preventDefault();
	deleteProductList = $("#deleteProductList");
	
	let str = ""
	let deleteArray = new Array();
	deleteArray = getDeleteProductList();
	
	
	str += "<input type='text' name='checkProduct_num' value='" + deleteArray + "'>"; 
	
	deleteProductList.append(str);
	
	$.ajax({
		url : '/product/delete',
		type: 'post',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		data: deleteProductList.serialize(),
		//contentType: "application/json; charset=UTF-8;",
		success: function(){
			console.log("성공");
			//alert("상품을 삭제했습니다.");
			//location.href="modifyForm";
		},
		
	});
	
	
});
//let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
let regex = new RegExp("(.*?)\.(png|bmp|jpeg|jpg)$");
let maxSize = 1024 * 1024 * 5; //5MB


//파일 사이즈와 종류 확인
function checkExtension(fileName, fileSize) {
   if(fileSize >= maxSize){
      alert("파일 사이즈 초과");
      return false;
   }

   if (!regex.test(fileName)) {
      alert("해당 종류의 파일은 업로드 할 수 없습니다.");
      return false;
   }
   return true;
}

let cloneObj = $(".uploadDiv").clone();


//파일 업로드
$("input[type='file']").change(function(e){
   let formData = new FormData();
   let inputFile = $("input[name='uploadFile']");
   
   let files = inputFile[0].files;
   
   //add file to formdata
   for (let i = 0; i < files.length; i++) {
      if(!checkExtension(files[i].name, files[i].size)){
         return false;
      }
      
      formData.append("uploadFile", files[i]);
   }
   
   
   $.ajax({
      url: '/file/productfileUploadAjax',
      headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
      processData: false, // data 파라미터로 전달된 데이터를 Query String으로 변환하지 않음. 파일전송시에는 이렇게 해야함
      contentType: false, // //contentType의 default는 application/x-www-form-urlencoded; charset=UTF-8, 파일전송시에는 false로 해줘야 함
      data: formData,
      type: 'post',
      dataType: 'json',
      
      success: function(result) {
         showUploadedFile(result);   
         //$(".uploadDiv").html(cloneObj.html());
      },
   });
});


let uploadResult = $(".uploadResult ul");

function showUploadedFile(uploadResultArr){
   
   if(!uploadResultArr || uploadResultArr.length == 0) {return;}
   
   let str = "";
   
   $(uploadResultArr).each(function(i, obj){
      originPathRegex = obj.uploadPath;
      let fileCallPath = encodeURIComponent(obj.uploadPath + "/" +obj.uuid + "_" + obj.fileName);
      let originPath = obj.uploadPath + "\\" +obj.uuid + "_" + obj.fileName;
      originPath = originPath.replace(new RegExp(/\\/g), "/");
      originPathRegex = originPathRegex.replace(new RegExp(/\\/g), "/");
      
      //str +="<li data-path='" +  obj.uploadPath + "' data-uuid='" + obj.uuid + "'data-filename='" + obj.fileName + "'data-product_num='" + obj.uploadPath +"'>";
      str +="<li data-path='" +  originPathRegex + "' data-uuid='" + obj.uuid + "'data-filename='" + obj.fileName + "'data-product_num='" + $("#product_num").val() +"'>";
      str +="<div>"
         str +="<span>" + obj.fileName +"</span>"
         str +="<button type='button' data-file=\'" + fileCallPath + "\' data-type='image'> X </button><br>";
         str +="<a href=\"javascript:showImage(\'" + originPath + "\')\">"
            str +="<img src='/file/display?fileName=/" + fileCallPath + "'>";
         str +="</a>";
      str +="</div>"
   	  str +="</li>";
   });
   console.log(str);
   uploadResult.append(str);
}
   

//이미지 클릭시 확대
function showImage(fileCallPath){
   $(".bigPictureWrapper").css("display", "flex").show();
   $(".bigPicture").html("<img src='/file/display?fileName=/" + fileCallPath + "'>")
               .animate({width: '100%', height: '100%'}, 0);
}

//확대 이미지 가리기
$(".bigPictureWrapper").on("click", function(e){
   $(".bigPicture").animate({width: '0%', height: '0%'}, 0);
   $(".bigPictureWrapper").hide();
});


//삭제버튼 클릭 이벤트
$(".uploadResult").on("click", "button", function(e){

	let targetFile = $(this).data("file");
	console.log("targetFile : " + targetFile);

	if (confirm("파일을 제거하시겠습니까?")) {
		let targetLi = $(this).closest("li");
		targetLi.remove();
	}
});
</script>


</body>
</html>
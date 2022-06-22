<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<html>
<head>
	<title>Product Register</title>

<link rel="stylesheet" href="/resources/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="/resources/bootstrap/bootstrap-theme.min.css">
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
</style>


<style>
.inputArea { margin:10px 0; }
select { width:100px; }
label { display:inline-block; width:70px; padding:5px; }
label[for='product_descrip'] { display:block; }
input { width:150px; }
textarea#productDes { width:400px; height:180px; }

.select_img img { margin:20px 0; }

</style>

</head>
<body>
<div id="root">
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
			<h2>상품 등록</h2>
			
			
			<form id="productWriteForm" method="post" autocomplete="off" action="/product/register">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
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
				<input type="text" id="product_name" name="product_name" />
			</div>
			
			<div class="inputArea">
				<label for="gdsPrice">상품가격</label>
				<input type="text" id="product_price" name="product_price" />
			</div>
			
			
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
				<button type="submit" id="register_Btn" class="btn btn-primary">등록</button>			
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
		url: '/product/getProductCategoryList',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		dataType: 'json',
		success: function(result){
			ProductsCategoryList = result;
			createCate(ProductsCategoryList);
		},
	});

	$.ajax({
		type: 'post',
		url: '/product/getBrandsCategoryList',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		dataType: 'json',
		success: function(result){
			BrandsCategoryList = result;
			createBrandCategory(BrandsCategoryList);
		},
	});
	
}());



// 브랜드명 셀렉트 박스에 삽입할 데이터 준비
function createBrandCategory(jsonData){
	
	var brandCateArr = new Array();
	var brandCateObj = new Object();
	
	for(var i = 0; i < jsonData.length; i++) {
		
		if(jsonData[i].level == "2") {  // 레벨이 1인 데이터가 있다면 
			brandCateObj = new Object();  // 초기화
			
			// cate1Obj에 cateCode와 cateName를 저장
			brandCateObj.product_category_num = jsonData[i].product_category_num; 
			brandCateObj.product_category_name = jsonData[i].product_category_name;
			
			// cate1Obj에 저장된 값을 cate1Arr 배열에 저장
			brandCateArr.push(brandCateObj);
		}
	}
	//console.log(cateArr);

	// 브랜드명 셀렉트 박스에 데이터 삽입
	var cate4Select = $("select.category4")

	for(var i = 0; i < brandCateArr.length; i++) {

		// cate1Arr에 저장된 값을 cate1Select에 추가
		cate4Select.append("<option value='" + brandCateArr[i].product_category_num + "'>"
							+ brandCateArr[i].product_category_name + "</option>");	
	}
};


function createCate(ProductsCategoryList){
	//console.log(ProductsCategoryList);
	//console.log(ProductsCategoryList[3].level);
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
	//console.log(cate1Arr);

	// 1차 분류 셀렉트 박스에 데이터 삽입
	var cate1Select = $("select.category1")

	for(var i = 0; i < cate1Arr.length; i++) {

		// cate1Arr에 저장된 값을 cate1Select에 추가
		cate1Select.append("<option value='" + cate1Arr[i].product_category_num + "'>"
							+ cate1Arr[i].product_category_name + "</option>");	
	}
};


//1차 분류 카테고리
// 클래스가 category1인 select변수의 값이 바뀌었을 때 실행
$(document).on("change", "select.category1", function(){
	// 필요한 배열과 오브젝트 변수를 생성
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
	
	//console.log(cate2Arr);
	
	var cate2Select = $("select.category2");
	
	
	cate2Select.children().remove();
	
	
	// cate2Select의 값을 제거함(초기화)
 
	// cate1Select에서 선택한 값을 기준으로 cate2Select의 값을 조정
	$("option:selected", this).each(function(){
		var selectVal = $(this).val();  // 현재 선택한 cate1Select의 값을 저장
	
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
});


$(document).on("change", "select.category2", function(){
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
	
	//console.log(cate3Arr);
	
	var cate3Select = $("select.category3");
	
	
	cate3Select.children().remove();
	
	
	// cate2Select의 값을 제거함(초기화)
 
	// cate1Select에서 선택한 값을 기준으로 cate2Select의 값을 조정
	$("option:selected", this).each(function(){
		var selectVal = $(this).val();  // 현재 선택한 cate1Select의 값을 저장
	
		cate3Select.append("<option value='" + selectVal + "'>전체</option>");  // cate2Select의 '전체'에 현재 선택한 cate1Select와 같은 값 부여
		
		// cate2Arr의 데이터를 cate2Select에 추가
		for(var i = 0; i < cate3Arr.length; i++) {
			
			// 현재 선택한 cate1Select의 값과 일치하는 cate2Arr의 데이터를 가져옴
			if(selectVal == cate3Arr[i].product_category_num_ref) {
				cate3Select.append("<option value='" + cate3Arr[i].product_category_num + "'>"
									+ cate3Arr[i].product_category_name + "</option>");
			}
		}		
	});
});

</script>
<script>
var regExp = /[^0-9]/gi;

$("#product_price").keyup(function(){ numCheck($(this)); });
$("#product_price").keyup(function(){ numCheck($(this)); });

function numCheck(selector) {
	var tempVal = selector.val();
	selector.val(tempVal.replace(regExp, ""));
}
</script>




<script type="text/javascript">
//파일 업로드 관련
//글쓰기 버튼 클릭시 이벤트
$("button[type='submit']").on("click", function(e){
   e.preventDefault();
   console.log("product register......");
   let str = ""
   $(".uploadResult ul li").each(function(i, obj) {
      let jobj = $(obj);
      console.log(jobj);

      str += "<input type='hidden' name='fileList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
       str += "<input type='hidden' name='fileList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
       str += "<input type='hidden' name='fileList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
       console.log(str);
   });
   
   $("#productWriteForm").append(str);
   
   $.ajax({
		type:'post',
		url:'/product/register',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		data: $('#productWriteForm').serialize(),
		//success: function() {	
		success: function() {
			alert("상품 등록");
			location.href = "/product/register";
	    },
       error: function(err) {
           console.log(err);
       },
	}); //end ajax 
   
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
   
   console.log(formData);
   $.ajax({
      url: '/file/productfileUploadAjax',
      headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
      processData: false, // data 파라미터로 전달된 데이터를 Query String으로 변환하지 않음. 파일전송시에는 이렇게 해야함
      contentType: false, // //contentType의 default는 application/x-www-form-urlencoded; charset=UTF-8, 파일전송시에는 false로 해줘야 함
      data: formData,
      type: 'post',
      dataType: 'json',
      
      success: function(result) {
         console.log(result);
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
      console.log(obj.uploadPath);
      console.log(obj.uuid);
      console.log(obj.fileName);
      aaa = obj.uploadPath;
      let fileCallPath = encodeURIComponent(obj.uploadPath + "/" +obj.uuid + "_" + obj.fileName);
      let originPath = obj.uploadPath + "\\" +obj.uuid + "_" + obj.fileName;
      originPath = originPath.replace(new RegExp(/\\/g), "/");
      aaa = aaa.replace(new RegExp(/\\/g), "/");
      console.log("fileCallPath : " + fileCallPath);
      console.log("originPath : " + originPath);
      console.log("aaa : " + aaa);
      //str +="<li data-path='" +  obj.uploadPath + "' data-uuid='" + obj.uuid + "'data-filename='" + obj.fileName + "'data-linked_num='" + obj.uploadPath +"'>";
      str +="<li data-path='" +  aaa + "' data-uuid='" + obj.uuid + "'data-filename='" + obj.fileName + "'data-linked_num='" + obj.uploadPath +"'>";
      str +="<div>"
         str +="<span>" + obj.fileName +"</span>"
         str +="<button type='button' data-file=\'" + fileCallPath + "\' data-type='image'> X </button><br>";
         str +="<a href=\"javascript:showImage(\'" + originPath + "\')\">"
            str +="<img src='/file/display?fileName=/" + fileCallPath + "'>";
         str +="</a>";
      str +="</div>"
   str +="</li>";
      console.log(str);
   });
   uploadResult.append(str);
}
   

//이미지 클릭시 확대
function showImage(fileCallPath){
   console.log(fileCallPath)
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
   
   let targetLi = $(this).closest("li");
   
   
   $.ajax({
      url: '/file/deleteFile',
      headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
      data: {fileName: targetFile},
      dataType: 'text',
      type: 'POST',
      success: function(result){
         alert(result);
         targetLi.remove();
      },
   });
});

</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>Admin</title>
	

<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
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
	
	
</style>


<style>
.inputArea { margin:10px 0; }
select { width:100px; }
label { display:inline-block; width:70px; padding:5px; }
label[for='gdsDes'] { display:block; }
input { width:200px; }
textarea#gdsDes { width:400px; height:180px; }

.select_img img { margin:20px 0; }

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
		
		
			<h2>카테고리 검색</h2>
			<form id="searchForm" method="post" autocomplete="off">
				<div class="searchInputArea">	
					
				<label>브랜드명</label>
				<select class="searchBrandCategory" name="product_category_num">
					<option value="">전체</option>
				</select>
				
			</div>
			</form>
			
			<button type="button" id="select_Btn" class="btn btn-primary">선택</button>
			
			
			<h2>카테고리 관리</h2>
			
			<form id="brandCategoryForm" action="/product/createBrandCategory" method="post">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="hidden" id="product_category_num" name="product_category_num" value="0">
 				<div class="inputArea">
					<label for="brandName">브랜드명</label>
					<input type="text" id="product_category_name" name="product_category_name" cols="30"/>
				</div>			
				
				<div class="inputArea">
					<label for="brandName">설명</label>
					<textarea id="product_category_descrip" name="product_category_descrip" rows="4" cols="30"></textarea>
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
			
			</form>
			
			<div class="inputArea">
					<button type="button" id="register_Btn" class="btn btn-primary">등록</button>			
					<button type="button" id="modify_Btn" class="btn btn-info">수정</button>
					<button type="button" id="delete_Btn" class="btn btn-danger">삭제</button>
			</div>
		</div>
	</section>

	<footer id="footer">
		<div id="footer_box">
			<%@ include file="../admin/include/footer.jsp" %>
		</div>		
	</footer>

</div>


<script type="text/javascript">

let BrandsCategoryList;

$(document).ready(function(){

	$.ajax({
		type: 'post',
		url: '/product/getBrandsCategoryList',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		dataType: 'json',
		success: function(result){
			//console.log(result);
			BrandsCategoryList = result;
			createBrandCategory(BrandsCategoryList);
		},
	});
}());

//선택버튼 클릭시 동작
$("#select_Btn").on("click", function(){
	$.ajax({
		type: 'post',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		data: $("#searchForm").serialize(),
		url: '/product/getProductCategoryDTO',
		dataType: 'json',
		success: function(result){
			console.log(result);
			console.log(result.fileList);
			console.log(result.product_category_num);
			$("#product_category_num").val(result.product_category_num);
			$("#product_category_name").val(result.product_category_name);
			$("#product_category_descrip").val(result.product_category_descrip);
			showUploadedFile(result.fileList);
		},
		error: function(e) {
			console.log(e);
		}
	});
});

//파일 업로드 관련
//등록 버튼 클릭시 이벤트
$("#register_Btn").on("click", function(e){
   e.preventDefault();
   console.log("product_category register......");
   let str = ""
   $(".uploadResult ul li").each(function(i, obj) {
      let jobj = $(obj);
      console.log(jobj);

       str += "<input type='hidden' name='fileList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
       str += "<input type='hidden' name='fileList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
       str += "<input type='hidden' name='fileList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
       
       console.log(str);
   });
   
   //$("#brandCategoryForm").append(str);
   $("#brandCategoryForm").append(str).submit();
});

//수정 버튼 클릭시 이벤트
$("#modify_Btn").on("click", function(e){
   e.preventDefault();
   console.log("product_category modify......");
   let str = ""
   $(".uploadResult ul li").each(function(i, obj) {
      let jobj = $(obj);

       str += "<input type='hidden' name='fileList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
       str += "<input type='hidden' name='fileList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
       str += "<input type='hidden' name='fileList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
       
       console.log(str);
   });
   
   //$("#brandCategoryForm").attr("action", "/product/modifyBrandCategory").append(str).submit();
   $("#brandCategoryForm").attr("action", "/product/modifyBrandCategory").append(str).submit();
   //$("#brandCategoryForm");
});

//삭제 버튼 클릭시 이벤트
$("#delete_Btn").on("click", function(e){
   e.preventDefault();
   console.log("product_category delete......");
   let str = ""
   $(".uploadResult ul li").each(function(i, obj) {
      let jobj = $(obj);

       str += "<input type='hidden' name='fileList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
       str += "<input type='hidden' name='fileList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
       str += "<input type='hidden' name='fileList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
       
       console.log(str);
   });
   
   $("#brandCategoryForm").attr("action", "/product/deleteBrandCategory").append(str).submit();
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
	
	if ($("#product_category_name").val() == "") {
		alert("브랜드명을 입력해주세요");
		return;
	}
	
	let formData = new FormData();
	let inputFile = $("input[name='uploadFile']");

	let files = inputFile[0].files;

	//add file to formdata
	for (let i = 0; i < files.length; i++) {
		if (!checkExtension(files[i].name, files[i].size)) {
			return false;
		}

		formData.append("uploadFile", files[i]);
	}

	console.log(formData);
	$.ajax({
		url : '/file/brandfileUploadAjax',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		processData : false, // data 파라미터로 전달된 데이터를 Query String으로 변환하지 않음. 파일전송시에는 이렇게 해야함
		contentType : false, // //contentType의 default는 application/x-www-form-urlencoded; charset=UTF-8, 파일전송시에는 false로 해줘야 함
		data : formData,
		type : 'post',
		dataType : 'json',

		success : function(result) {
			console.log(result);
			showUploadedFile(result);
			//$(".uploadDiv").html(cloneObj.html());
		},
	});
});

let uploadResult = $(".uploadResult ul");


//업로드 할 파일 미리보기
function showUploadedFile(uploadResultArr) {

	if (!uploadResultArr || uploadResultArr.length == 0) {
		return;
	}

	let str = "";

	$(uploadResultArr).each(function(i, obj){
		console.log(obj.uploadPath);
		console.log(obj.uuid);
		console.log(obj.fileName);
		imagefileFolderPath = obj.uploadPath;
		let fileCallPath = encodeURIComponent(obj.uploadPath
				+ "/" + obj.uuid + "_" + obj.fileName);
		let originPath = obj.uploadPath + "\\" + obj.uuid
				+ "_" + obj.fileName;
		originPath = originPath.replace(new RegExp(/\\/g),
				"/");
		imagefileFolderPath = imagefileFolderPath.replace(new RegExp(/\\/g), "/");
		
		console.log("fileCallPath : " + fileCallPath);
		console.log("originPath : " + originPath);
		console.log("imagefileFolderPath : "
				+ imagefileFolderPath);
		//str +="<li data-path='" +  obj.uploadPath + "' data-uuid='" + obj.uuid + "'data-filename='" + obj.fileName + "'data-linked_num='" + obj.uploadPath +"'>";
		str += "<li data-path='" +  imagefileFolderPath +  "' data-uuid='" + obj.uuid + "'data-filename='" + obj.fileName + "'data-linked_num='" + obj.uploadPath +"'>";
		str += "<div>"
		str += "<span>" + obj.fileName + "</span>"
		str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image'> X </button><br>";
		str += "<a href=\"javascript:showImage(\'"
				+ originPath + "\')\">"
		str += "<img src='/file/display?fileName=/"
				+ fileCallPath + "'>";
		str += "</a>";
		str += "</div>"
		str += "</li>";
		console.log(str);
	
	});
	uploadResult.append(str);
}

//이미지 클릭시 확대
function showImage(fileCallPath) {
	console.log(fileCallPath)
	$(".bigPictureWrapper").css("display", "flex").show();
	$(".bigPicture").html(
		"<img src='/file/display?fileName=/" + fileCallPath + "'>")
		.animate({
			width : '100%',
			height : '100%'
		}, 0);
}

//확대 이미지 가리기
$(".bigPictureWrapper").on("click", function(e) {
	$(".bigPicture").animate({
		width : '0%',
		height : '0%'
	}, 0);
	$(".bigPictureWrapper").hide();
});

//삭제버튼 클릭 이벤트
$(".uploadResult").on("click", "button", function(e) {
	
	let targetFile = $(this).data("file");
	console.log("targetFile : " + targetFile);

	if (confirm("파일을 제거하시겠습니까?")) {
		let targetLi = $(this).closest("li");
		targetLi.remove();
	}
});

//브랜드명 셀렉트 박스에 삽입할 데이터 준비
function createBrandCategory(jsonData){
	
	let brandCateArr = new Array();
	let brandCateObj = new Object();
	
	for(let i = 0; i < jsonData.length; i++) {
		
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
	let brandSelect1 = $("select.searchBrandCategory")

	for(let i = 0; i < brandCateArr.length; i++) {

		// cate1Arr에 저장된 값을 cate1Select에 추가
		brandSelect1.append("<option value='" + brandCateArr[i].product_category_num + "'>"
							+ brandCateArr[i].product_category_name + "</option>");	
	}
	
	
	//수정 폼 내의 브랜드명 셀렉트 박스에 데이터 삽입
	let brandSelect2 = $("select.category4")

	for(let i = 0; i < brandCateArr.length; i++) {

		// cate1Arr에 저장된 값을 cate1Select에 추가
		brandSelect2.append("<option value='" + brandCateArr[i].product_category_num + "'>"
							+ brandCateArr[i].product_category_name + "</option>");	
	}
};

</script>




</body>
</html>
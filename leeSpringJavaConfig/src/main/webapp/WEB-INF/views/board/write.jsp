<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src="https://kit.fontawesome.com/cd631a71a1.js"
   crossorigin="anonymous"></script>
<title>theC</title>
</head>
<body>
<style>

#QNA{
   width:60%;
   margin:auto;
}
ul {
   margin: 0px;
   font-size: 0.8rem;
   font-weight: bold;
   list-style:none;
}


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

#subject{
   width:100%;
   height:30px;
}

.form-submit-board label{
   color:gray;
   margin-bottom:5px;
   }

.backBtn{

display: inline-block;
    border: 1px solid black;
    width: 117px;
    padding: 10px;
    color: black;

}

.backBtn:hover{
	color:gray;
	text-decoration: none;
}

.BoardWriteBtn{

	background-color: black;
	color: white;
	padding: 10px;
	width: 117px;

}

.buttonbox{
	display: flex;
	justify-content: space-between;
	margin-left: 36px;
	margin-top:30px

}

.uploadDiv{
	margin-left:38px;
}

</style>

 <div id="empty"></div>
   <div id="help_main">
      <div id="QNA">
         <c:if test="${map.board_category_num eq '1'}">
            <h3 class="QNA_board_title">공지</h3>
         </c:if>
         <c:if test="${map.board_category_num eq '2'}">
            <h3 class="QNA_board_title">2</h3>
         </c:if>
         <c:if test="${map.board_category_num eq '3'}">
            <h3 class="QNA_board_title">3</h3>
         </c:if>
         <c:if test="${map.board_category_num eq '4'}">
            <h3 class="REVIEW_board_title">리뷰</h3>
         </c:if>
         <c:if test="${map.board_category_num eq '5'}">
            <h3 class="QNA_board_title">상품 Q&A</h3>
         </c:if>
         <c:if test="${map.board_category_num eq '6'}">
            <h3 class="QNA_board_title">Q&A</h3>
         </c:if>
         <c:if test="${map.board_category_num eq '7'}">
            <h3 class="POST_board_title">POST</h3>
         </c:if>
         
         <%-- 포스트 작성시 --%>
         <c:choose>
            <c:when test="${map.board_category_num eq '7'}">
               <form id="boardWriteForm" action="/board/write" method="post">
                  <input type="hidden" name="member_id" value="<sec:authentication property="principal.memberDTO.member_id"/>">
	              <input type="hidden" name="member_name" value="<sec:authentication property="principal.memberDTO.member_name"/>">
                  <input type="hidden" name="board_category_num" value="${map.board_category_num}">
                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                  <input type="hidden" name="pwd" style="width: 15%; border: 0px; border-bottom: 1px solid gray" value="<sec:authentication property="principal.memberDTO.member_pwd"/>">
                  <div>
                     <ul class="form-submit-board">
                     	
                        <li>
                           <label>subject</label> 
                              <input type="text" id="subject" name="subject" value="">
                           <span class="label-box"></span>
                        </li>
                        
                        <li>
                           <label>Content</label>
                           <div id="content">
                              <textarea id="summernote" name="content" rows="40" cols="150"></textarea>
                              
                           </div>
                        </li>
                     </ul>
                     
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
                     
                     <div class="buttonbox">
                        <span class="">
                           <a class="backBtn" onClick="location.href='/board/list?board_category_num=${map.board_category_num}'">BACK TO LIST</a>
                        </span>    
                           
                        <span>
                           <button class="BoardWriteBtn" type="submit" formmethod="post">WRITE</button>
                        </span>
                     </div>
                     
                  </div>
               </form>
            </c:when>
			
			
			<c:when test="${map.board_category_num eq '4'}">
               
               <form id="boardWriteForm" action="/board/write" method="post">
		
                  <input type="hidden" name="board_category_num" value="${map.board_category_num}"> 
                  <input type="hidden" name="pageNum" value="${map.pageNum}"> 
                  <input type="hidden" name="amount" value="${map.amount}">
                  
                  <div>
                     <ul class="form-submit-board">
                        <li>
                           <label>subject</label> 
                              <input type="text" id="subject" name="subject" value="">
                           <span class="label-box"></span>
                        </li>
	                    <input type="hidden" name="member_id" value="<sec:authentication property="principal.memberDTO.member_id"/>">
	                    <input type="hidden" name="member_name" value="<sec:authentication property="principal.memberDTO.member_name"/>">
                        
                        <li>
                        	<label>Content</label>
                        	<div id="content">
                            	<textarea id="summernote"  style="width:100%; "name="content" rows="40" ></textarea>
                              
                            </div>
                            <div>
                           		<label>Password</label><br>
                           		<input type="password" name="pwd" style="width: 15%; border: 0px; border-bottom: 1px solid gray" value="<sec:authentication property="principal.memberDTO.member_pwd"/>">
                            </div>
                           
                            <div>
                            <label>Secret</label><br>
                            <input type="radio" name="secret"  onclick='return(false);'>공개글
                            <input type="radio" name="secret" checked onclick='return(false);'>비밀글
                            </div>
                        </li>
                     </ul>
                     <div id="botton box">
                        <span class="">
                           <a onClick="location.href='/board/list?board_category_num=map.board_category_num}&pageNum=1&amount=10'">이전화면으로</a>
                        </span>     
                           
                        <span>
                           <button type="submit" formmethod="post">글쓰기</button>
                        </span>
                     </div>
                  </div>
               </form>
            </c:when>



            <c:otherwise>
               <%-- QNA 작성 --%>
               <form id="boardWriteForm" action="/board/write" method="post">
					
                  <input type="hidden" name="board_category_num" value="${map.board_category_num}"> 
                  <input type="hidden" name="pageNum" value="${map.pageNum}"> 
                  <input type="hidden" name="amount" value="${map.amount}">
                  <input type="hidden" name="product_num" value="0">
                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                  
                  <div>
                     <ul class="form-submit-board">
                        <li>
                        	<label>subject</label> <br>
	                        <select id="subject" name="subject">
	                              <option value="사이즈문의입니다.">사이즈문의입니다.</option>
	                              <option value="재고문의입니다.">재고문의입니다.</option>
	                              <option value="배송문의입니다.">배송문의입니다.</option>
	                              <option value="재입고문의입니다.">재입고문의입니다.</option>
	                              <option value="기타문의입니다.">기타문의입니다.</option>
	                        </select> 
	                        <span class="label-box"></span>
	                    </li>
	                    <input type="hidden" name="member_id" value="<sec:authentication property="principal.memberDTO.member_id"/>">
	                    <input type="hidden" name="member_name" value="<sec:authentication property="principal.memberDTO.member_name"/>">
                        
                        
                        <li>
                        	<label>Content</label>
                        	<div id="content">
                            	<textarea id="summernote"  style="width:100%; "name="content" rows="40" ></textarea>
                              
                            </div>
                            <div>
                           		<label>Password</label><br>
                           		<input type="password" name="pwd" style="width: 15%; border: 0px; border-bottom: 1px solid gray" value="<sec:authentication property="principal.memberDTO.member_pwd"/>">
                            </div>
                           
                            <div>
                            <label>Secret</label><br>
                            <input type="radio" name="secret"  onclick='return(false);'>공개글
                            <input type="radio" name="secret" checked onclick='return(false);'>비밀글
                            </div>
                        </li>
                     </ul>
                     <div class="buttonbox">
                        <span class="">
                           <a class="backBtn" onClick="location.href='/board/list?board_category_num=${map.board_category_num}&pageNum=1&amount=10'">BACK TO LIST</a>
                        </span>    
                           
                        <span>
                           <button class="BoardWriteBtn" type="submit" formmethod="post">글쓰기</button>
                        </span>
                     </div>
                  </div>
               </form>
            </c:otherwise>
         </c:choose>


      </div>

   </div> <%-- end #help_main --%>


<script type="text/javascript">
$(function(){
   $('#summernote').summernote({
      placeholder: '내용을 입력해주세요.',
       tabsize: 1,
       height: 300,
       toolbar: [
           ['fontname', ['fontname']],
          ['fontsize', ['fontsize']],
          ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
          ['color', ['forecolor','color']],
          ['para', ['ul', 'ol', 'paragraph']],
          ['height', ['height']]
        ],
           fontNames: ['맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
            fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
   });   
})

</script>
<script type="text/javascript">

//글쓰기 버튼 클릭시 이벤트
$("button[type='submit']").on("click", function(e){
   e.preventDefault();
   console.log("submit cliecked");
   let str = ""
   $(".uploadResult ul li").each(function(i, obj) {
      let jobj = $(obj);
      console.log(jobj);

      str += "<input type='hidden' name='fileList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
       str += "<input type='hidden' name='fileList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
       str += "<input type='hidden' name='fileList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
       str += "<input type='hidden' name='fileList["+i+"].board_num' value='"+jobj.data("board_num")+"'>";
       console.log(str);
   });
   
   $("#boardWriteForm").append(str).submit();
   console.log($("#boardWriteForm"));
});


//let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
let regex = new RegExp("(.*?)\.(png|bmp|jpeg|jpg)$");
let maxSize = 1024 * 1024 * 5; //5MB

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
   formData.append("board_num", $("#board_num").val());

   $.ajax({
      url: '/file/boardfileUploadAjax',
      processData: false, // data 파라미터로 전달된 데이터를 Query String으로 변환하지 않음. 파일전송시에는 이렇게 해야함
      contentType: false, // //contentType의 default는 application/x-www-form-urlencoded; charset=UTF-8, 파일전송시에는 false로 해줘야 함
      data: formData,
      beforeSend : function(xhr){   
          xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
      },
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
      str +="<li data-path='" +  aaa + "' data-uuid='" + obj.uuid + "'data-filename='" + obj.fileName + "'data-board_num='" + $("#board_num").val() +"'>";
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
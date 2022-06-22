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

			<form id="boardReplyForm" action="/board/boardReplyWrite" method="post">
				<input type="hidden" name="board_num" value="${boardDTO.board_num}">
				<input type="hidden" name="group_num" value="${boardDTO.group_num}">
				<input type="hidden" name="layer" value="${boardDTO.layer}">
				<input type="hidden" name="orders" value="${boardDTO.orders}">
				<input type="hidden" name="board_category_num" value="${map.board_category_num}"> 
                <input type="hidden" name="pageNum" value="${map.pageNum}"> 
                <input type="hidden" name="amount" value="${map.amount}">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<div>
					<ul class="form-submit-board">
						<li>
							<label>subject</label><br>
							<input type="text" name="subject" value="답변입니다">
							<span class="label-box"></span>
						</li>
						
						<input type="hidden" name="member_id" value="<sec:authentication property="principal.memberDTO.member_id"/>">
	                    <input type="hidden" name="member_name" value="<sec:authentication property="principal.memberDTO.member_name"/>">
						
						<li>
							<label>Content</label>
							<div id="content">
								<textarea id="summernote"  style="width:100%; "name="content" rows="40" >[ Original Message ]
								${boardDTO.content}
								--------------------------------------------
								</textarea>
									
									
								<div>
	                           		<label>Password</label><br>
	                           		<input type="password" name="pwd" style="width: 15%; border: 0px; border-bottom: 1px solid gray" value="<sec:authentication property="principal.memberDTO.member_pwd"/>">
	                            </div>
								
								<div>
	                            <label>Secret</label><br>
	                            <input type="radio" name="secret"  onclick='return(false);'>공개글
	                            <input type="radio" name="secret" checked onclick='return(false);'>비밀글
	                            </div>
								
								<div class="toolbar">
									<%-- <span class="fr-counter">문자(조회수넣을까?) : </span> --%>
								</div>
							</div>
						</li>
					</ul>
					<div id="botton box">
						<span class="" >
							<a class="backBtn" onclick="onClick=location.href='/board/list?board_category_num=${map.board_category_num}&pageNum=1&amount=10'">BACK TO LIST</a>
						</span>
						<span>
							<button class="backBtn" type="submit">글쓰기</button>
						</span>
					</div>
				</div>
			</form>


		</div>

	</div> <%-- end #help_main --%>
	<%-- <jsp:include page="/component/footer.jsp" /> --%>
	<script src="/WEB-INF/component/nav/nav.js"></script>
</body>
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

</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html>
<head>

<script src="https://kit.fontawesome.com/cd631a71a1.js" crossorigin="anonymous"></script>
<title>Insert title here</title>
</head>


<body>

<style>

.post-thumbnail li:nth-child(2n) {
	clear: both;
}


.post-thumbnail li:first-child {
    width: 100%;
    border-bottom: 3px solid #000;
    display: flex;
}


.post-thumbnail li:first-child .thumbnail-image {
    width: 60%;
    float: left;
    padding:40px;
    height:100%;
}


.post-thumbnail li:first-child .thumbnail-info {
    float: right;
    width: 40%;
    position: relative;
    padding:50px;

    align-self: center;

}

.post-thumbnail li {
	width: 100%;
	border-bottom: 2px solid #000;
	border-right: 0 !important;
	
}


.post-thumbnail li:first-child .thumbnail-image img {
	width: 100%;
	height: auto !important;
	
}

.thumbnail-image img{
	border:none;
	padding:40px
}

.post-thumbnail li:nth-child(2n) {
    clear: both;
    border-right:3px solid #000 !important;
}
.post-thumbnail li {
    width: 50%;
    float: left;
    padding: 60px 0;
}
li {
    list-style: none;
    display: list-item;
    text-align: -webkit-match-parent;
}

.post-readmore .move{
	font-size:10pt;
}

.inner{
	padding:20px
}
.post-thumbnail{
	display:inline-block;
}


</style>

	
<div id="empty"></div>

<div id="contents" style="min-height: 705px;">
	<input type="hidden" value="${board_category_num}">
	<input type="hidden" value="${board_num}">
	<input type="hidden" value="${map}">
	
	<div class="post-wrap">
		<div class="xans-element- xans-product xans-product-listnormal">
			<ul class="post-thumbnail">
				
				<c:forEach items="${list}" var="board">
					<li class="xans-record-" >
						<div class="thumbnail-image">
							<a class="move" href='/board/get?board_category_num=7&board_num=<c:out value="${board.board_num}"/>'>
								<img src="/file/display?fileName=/${board.fileList[0].uploadPath}/${board.fileList[0].uuid}_${board.fileList[0].fileName}">
							</a>
						</div>
	
						<div class="thumbnail-info">
							<div class="inner">
								<h2>
									<a class="move" href='/board/get?board_category_num=7&board_num=<c:out value="${board.board_num}"/>'>
										<span style="color: #555555;">
											${board.subject}
										</span>
									</a>
								</h2>
								<p class="post-category">
									
								</p>
	
								<p class="post-desc">
									${board.content}
								</p>
	
								<p class="post-readmore">
									<a class="move" href='/board/get?board_category_num=7&board_num=<c:out value="${board.board_num}"/>'>
										Read more
									</a>
								</p>
							</div>
						</div>
					</li>

				</c:forEach>
			</ul>
		</div>
	</div> <%-- end .post-wrap --%>
</div> <%-- end content --%>






<sec:authorize access="isAuthenticated()">
	<form id='moveWriteForm' action="/board/write" method='get'>
		<input id="authAdmin" type="hidden" value="<sec:authentication property="principal.memberDTO.memberAuthList"/>">
		<input id="loginMember_id" type="hidden" name='member_id' value="<sec:authentication property="principal.memberDTO.member_id"/>">
		<input type='hidden' name='board_category_num' value='${board_category_num}'>
	</form>
</sec:authorize>

<sec:authorize access="hasRole('ROLE_ADMIN')">
	<button type="button" style="background-color: white; border:2px solid black; margin:30px; 20px;" id="moveWriteBtn" href="#">글 작성</a></button>
</sec:authorize>	



<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script type="text/javascript">

let moveWriteForm = $("#moveWriteForm");
let actionForm = $("#actionForm");



$("#moveWriteBtn").on("click", function(e){
	e.preventDefault();
	
	moveWriteForm.submit();
});


</script>

</body>
</html>
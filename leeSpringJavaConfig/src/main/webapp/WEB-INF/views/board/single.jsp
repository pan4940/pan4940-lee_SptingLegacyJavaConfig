<%@page import="member.bean.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
    
<!DOCTYPE html>
<html>
<head>

<script src="https://kit.fontawesome.com/cd631a71a1.js"
	crossorigin="anonymous"></script>
<title>Insert title here</title>
</head>


<style>
div {
    display: block;
}

.row{
	list-style: none;
    position: relative;
    margin: 15px 0 0 0;
    border-top: 1px solid #d7d5d5;
    box-sizing: border-box;
    color: #353535;
    line-height: 140%;
}

.floatleft {
    float: left;
}

.col50 {
    width: 50%;
}

.single-content{
	margin:auto;
}

.col{
	padding:0px;
}
   
</style>


<body>
	
	<sec:authorize access="isAuthenticated()">
		<input id="memberAuthList" type="hidden" name='memberAuthList' value="<sec:authentication property="principal.memberDTO.memberAuthList"/>">
		<input id="loginMember_id" type="hidden" name='member_id' value="<sec:authentication property="principal.memberDTO.member_id"/>">
	</sec:authorize>
	<div class="xans-element- xans-product xans-product-detail collection-single-wrap ">
		<div class="single-top">
			<input type="hidden" value="${map}">
			<p></p>
			<h1 style="margin:100px 20px">${boardDTO.subject}</h1>
		</div>
		<div class="single-content col-12 col-lg-9">
			<div data-empty="true" style="text-align: center;">${boardDTO.content}</div>
			<br>
			<div data-empty="true" style="text-align: center;">
				<br>
				<div class="row">
					<c:forEach items="${boardDTO.fileList}" var="fileDTO">
					
						<div class="col col-12 col-lg-6">
							<img alt="image" src="/file/display?fileName=/${fileDTO.uploadPath}/${fileDTO.uuid}_${fileDTO.fileName}">
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		
	</div>
	
	
	<sec:authorize access="isAuthenticated()">
		<form id="postForm" action="" >
			<input type="hidden" name="board_category_num" value="${boardDTO.board_category_num}">
			<input type="hidden" name="board_num" value="${boardDTO.board_num}">
			<input type="hidden" name="member_id" value="${boardDTO.member_id}">	
		</form>
	</sec:authorize>
	<button id="modifyBtn">수정</button>
	<button id="deleteBtn">삭제</button>
	
	
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script type="text/javascript">

$(document).ready(function(){
	let member_id = $("#loginMember_id").val();
	let rank = $("#memberAuthList").val();
	
	console.log(member_id);
	console.log(rank);	
	
	if(rank_num == 3){
		$("#modifyBtn").show();
		$("#deleteBtn").show();
	} else {
		$("#modifyBtn").hide();
		$("#deleteBtn").hide();
	}
	
});



$("#modifyBtn").on("click", function(e){
	e.preventDefault();
	postForm.attr("action", "/board/modifyForm");
	postForm.submit();
});

$("#deleteBtn").on("click", function(e){
	e.preventDefault();
	postForm.attr("action", "/board/delete");
	postForm.submit();
});

</script>
	

</body>
</html>
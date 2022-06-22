<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<head>

<script src="https://kit.fontawesome.com/cd631a71a1.js"
	crossorigin="anonymous"></script>
<title>환영합니다</title>
</head>
<body>
<style>
ul {
    display: block;
    list-style-type: disc;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    padding-inline-start: 40px;
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

.comment-list-button {
    float: right;
    position: relative;
    margin-top: -20px;
}

.comment-list-button a {
    margin-right: 10px;
    
}
.button-text-small {
    float: none !important;
    display: inline-block !important;
    font-size: 9px;
    text-transform: uppercase;
    cursor: pointer;
    border: 0;
}

#written{
	font-size:10pt;
	color:gray;
}

.board-contents{
	border-top:2px solid black;
	padding:20px 0px 50px

	
}


.button-box button{
	border:none;
	float:right;
	background-color:white;
}

#h4subject{
	margin:30px 0px
}

.reply fieldset{
	border:2px solid #c0bfbf;
	background-color:#f9fafb;
	width:100%;
	padding:20px 70px 20px 20px ;
	

	
}

fieldset #replyer{
	background-color:#f9fafb;
	border:0px;
	border-bottom:1px solid gray;
}
fieldset #replyer:focus{
	outline:none;
	
}


#QNA{
	width:70%;

	margin:auto;
	margin-top:30px;
	
}
	
#newContent{
	width:100%;
}

#newContent:focus{
	outline:none;
}
	
	


</style>
	


<div id="help_main">
	<div id="QNA">
		<c:if test="${map.board_category_num eq '1'}">
            <h3 class="board_title">공지</h3>
         </c:if>
         <c:if test="${map.board_category_num eq '2'}">
            <h3 class="board_title">2</h3>
         </c:if>
         <c:if test="${map.board_category_num eq '3'}">
            <h3 class="board_title">3</h3>
         </c:if>
         <c:if test="${map.board_category_num eq '4'}">
            <h3 class="REVIEW_board_title">리뷰</h3>
         </c:if>
         <c:if test="${map.board_category_num eq '5'}">
            <h3 class="ProductQNA_board_title">상품 Q&A</h3>
         </c:if>
         <c:if test="${map.board_category_num eq '6'}">
            <h3 class="QNA_board_title">Q&A</h3>
         </c:if>
         <c:if test="${map.board_category_num eq '7'}">
            <h3 class="POST_board_title">POST</h3>
         </c:if>
		<input type="hidden" id="member_id" name="member_id" value='${boardDTO.member_id}'> 
		<div class="clearfix"></div>
			<form id="boardForm" action="" method="get">
				<input type='hidden' name='board_category_num' value='${map.board_category_num}'>
				<input type='hidden' id="board_num" name='board_num' value='${map.board_num}'>
				<input type='hidden' name='pageNum' value='${map.pageNum}'>
				<input type='hidden' name='amount' value='${map.amount}'>
				<input type='hidden' id="reply" name='reply' value='${boardDTO.reply}'>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<div>
					<h4 id="h4subject">
						${boardDTO.subject}
						<span id="written" style="margin-left:20px">Written by ${boardDTO.member_name}</span>
					
					<span style="float:right; font-size:10pt"><fmt:formatDate pattern="yyyy-MM-dd"	value="${boardDTO.regDate}" /><span></h4>
					<div class="clearfix"></div>
					<div class="board-detail-contents">
						<div class="board-contents">
							<p>${boardDTO.content}</p>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
			</form>
		
		<input type="hidden" id="memberAuthList" value="<sec:authentication property="principal.memberDTO.memberAuthList"/>">	
		<div class="button-box ">
			
			<button id='boardReplyBtn'>REPLY</button>
			<button id='boardEditBtn'>EDIT</button>
			<button id='boardDeleteBtn'>DELETE</button>
			<button id='listBtn'>BACK TO LIST</button>
		</div>
		<div class="clearfix"></div>
		
		<%-- 리플부분 --%>
		<sec:authorize access="isAuthenticated()">
		<div class="reply">
			<form id="replyForm" action="" method="post">
				<input id="board_num" name="board_num" type="hidden" value="${map.board_num}">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<div>
					<div>
						<fieldset>
						
							<p>
								<strong style="margin:20px">Write a Comment</strong>
								<span style="display:block">
									이름 : 
									<input id="replyer" name="replyer" type="text" value="${boardDTO.member_name}" >
								</span>
								
								
							</p>
							<div class="view">
								<textarea id="newContent"name="content" rows="10" cols="80" style = "background-color:transparent"></textarea>
								<br>
								<a class="confirm" href="#">Confirm</a>
							</div>
						</fieldset>
					</div>
				</div>
			</form>
		</div>
		</sec:authorize>
		
		<div id="replyList">
			<ul class="boardComment">
				
				<div id="json"></div>
				
			</ul>
		</div>
		
		
		<form id="replyUpdateForm" action="#" method="post" style="display: none;">
			<input id="reply_num" name="reply_num" type="hidden" value="">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<div class="board-commentform">
				<fieldset>
					<legend>Edit A Comment</legend>
					<p>
						<span>
							이름 : 
							<input id="updateReplyer" name="replyer" type="text" value="${boardDTO.member_name}" readonly="readonly">
						</span>
					</p>
					<div class="view">
						<textarea id="updateContent" name="content" rows="10" cols="50"></textarea>
						<br>
						<span class="submit">
							<a id="replyUpdateBtn" href="">수정</a>
							<a id="cancelBtn" href="">취소</a>
						</span>
					</div>
				</fieldset>
			</div>
			
		</form>
		
		
		<sec:authorize access="isAuthenticated()">
			<input id="loginMember_id" type="hidden" name='member_id' value="<sec:authentication property="principal.memberDTO.member_id"/>">
			
		</sec:authorize>
	</div>
</div> <%-- end #help_main --%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script type="text/javascript">

$(document).ready(function(){
	let member_id = $("#member_id").val();
	let loginMember_id = $("#loginMember_id").val();
	let auth = $("#memberAuthList").val();	
	console.log(member_id);
	console.log(loginMember_id);	
	console.log(auth);
	console.log(auth.includes('ROLE_ADMIN'));
	
	showList();
	
	if(member_id === loginMember_id || auth.includes('ROLE_ADMIN')){
		$("#boardReplyBtn").show();
		$("#boardEditBtn").show();
		$("#boardDeleteBtn").show();
	} else {
		$("#boardReplyBtn").hide();
		$("#boardEditBtn").hide();
		$("#boardDeleteBtn").hide();
	}
	
	
	
});

let replyUpdateForm = $("#replyUpdateForm");

let viewReplyUpdateForm = function(board_num, reply_num){
	console.log("click");
	console.log($(".row" + reply_num));
	
	$(".row" + reply_num).append(replyUpdateForm);
	$("#reply_num").val(reply_num);
	$("#replyUpdateForm").toggle();
}	


//리플삭제
let deleteReply = function(reply_num){
	console.log("delete click");
	console.log("reply_num : " + reply_num);
	$.ajax({
		type: 'post',
		url: '/reply/delete',
		data: {"reply_num": reply_num},
		beforeSend : function(xhr){   
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		success: function(){
			alert(reply_num + "번 댓글이 삭제되었습니다.");
			showList();
		},
	}); 
}

function showList(){ 
	$.ajax({
		type: 'post',
		url: '/reply/list',
		data: {board_num: $("#board_num").val()},
		beforeSend : function(xhr){   
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        dataType: 'json',
		success: function(result){
			//console.log(result);
			let showListloginMember_id = $("#member_id").val();
			let showListRank_num = $("#rank_num").val()
			let showListMember_id = $("#loginMember_id").val();
			
			let str = "";
			$("#json").text(result.length);
			
			
			if(showListloginMember_id == undefined){

				$.each(result, function(index, items){
					str += "<li class='row"+items.reply_num+"'>";
						str += "<div class='commentTop'>"
							str += "<strong class='name'>" + items.replyer + "</strong>";
							str += "<span class='date'>" + items.replyDate + "</span>";
						str += "</div>"; 	
						str += "<span class='comment-list-button'>";
						str += "</span>";
						str += "<div class='comment'>";
							str += "<span class='comment_contents'>" + items.content + "</span>";
						str += "</div>"
					str += 	"</li>";
					
				});
			} else if (showListRank_num == 3 || showListloginMember_id === showListMember_id){
				
				$.each(result, function(index, items){
					str += "<li class='row"+items.reply_num+"'>";
						str += "<div class='commentTop'>"
							str += "<strong class='name'>" + items.replyer + "</strong>";
							str += "<span class='date'>" + items.replyDate + "</span>";
						str += "</div>"; 	
						str += "<span class='comment-list-button'>";
							str += "<a id='replyEditBtn' class='button-text-small' onclick='javascript:viewReplyUpdateForm(" + "\""+items.board_num + "\""+ ", " + "\""+ items.reply_num + "\""+ ")'>EDIT</a>";
							str += "<a id='replyDeleteBtn' class='button-text-small' onclick='javascript:deleteReply("+ "\"" +items.reply_num + "\""+")'>DELETE</a>";
						str += "</span>";
						str += "<div class='comment'>";
							str += "<span class='comment_contents'>" + items.content + "</span>";
						str += "</div>"
					str += 	"</li>";
				});
			}
			
			
			$(".boardComment").html(str);
			
		},
		
	});
}; // end showList()


$("#cancelBtn").on("click", function(e){
	e.preventDefault();
	$("#replyUpdateForm").hide();
});



let boardForm = $("#boardForm");
let replyForm = $("#replyForm");
//덧글 등록
$("#boardReplyBtn").on("click", function(e){
	e.preventDefault();
	boardForm.attr("action", "/board/replyWrite");
	boardForm.submit();
});


//글 수정
$("#boardEditBtn").on("click", function(e){
	e.preventDefault();
	boardForm.attr("action", "/board/modify");
	boardForm.submit();
});

//글 삭제
$("#boardDeleteBtn").on("click", function(e){
	e.preventDefault();
	
	if($("#reply").val() > 0) {
		alert("답글이 있는 글은 삭제할 수 없습니다.");
	} else {
		if(confirm("게시물을 삭제하시겠습니까?")){
			boardForm.attr("action", "/board/delete");
			boardForm.attr("method", "post");
			boardForm.submit();
			alert("게시물이 삭제되었습니다.");
		}
	}
	
	//boardForm.attr("action", "/board/delete");
	//boardForm.submit();
});

//목록으로
$("#listBtn").on("click", function(e){
	e.preventDefault();
	boardForm.attr("action", "/board/list");
	boardForm.submit();
});	



//리플작성
$(".confirm").on("click", function(e){
	e.preventDefault();
	
	$.ajax({
		type: 'post',
		url: '/reply/write',
		data: replyForm.serialize(),
		success: function(){
			alert("댓글이 등록되었습니다.");
			$("#replyer").val("");
			$("#newContent").val("");
			showList();
		},
	});
});

//리플 수정
$("#replyUpdateBtn").on("click", function(e){
	e.preventDefault();
	console.log("replyUpdateBtn_click");
	$.ajax({
		type: 'post',
		url: '/reply/update',
		data: replyUpdateForm.serialize(),
		success: function(){
			alert("댓글이 수정되었습니다.");
			$("#updateReplyer").val("");
			$("#updateContent").val("");
			showList();
		},
	});
	
});


	
</script>
</body>
</html>

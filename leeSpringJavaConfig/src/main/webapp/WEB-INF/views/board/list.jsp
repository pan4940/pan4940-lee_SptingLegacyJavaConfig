<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://kit.fontawesome.com/cd631a71a1.js" crossorigin="anonymous"></script>
<title>list</title>
</head>


<body>
<style>
ul {
	margin: 0px;
	/*  font-size: 0.8rem; */
	font-weight: bold;
}

#help_main li {
	margin-bottom:5px;
    display: list-item;
    text-align: -webkit-match-parent;
    list-style: none;
}
.alignright{
	text-align: right;
}
.floatleft{
	display:flex;
}

.col60 {
    width: 60%;
}

.col10 {
    width: 10%;
}
.col20 {
    width: 20%;
}

.col40 {
    width: 40%;
}

.col50 {
    width: 50%;
}
#moveWriteForm{
	margin-left:93.5%;
	border:1px solid black;
	background-color: black;
	color:white;
	padding:7px 15px;
}
</style>
	
	<div id="empty"></div>
	<div id="help_main" style="margin:100px auto">
		<input type="hidden" value="${pageDTO}">
		<input type="hidden" value="${board_category_num}">
		<input id="pageNum" type="hidden" value="${pageDTO.criteria.pageNum}">
		<sec:authorize access="isAuthenticated()">
			<input id="loginMember_id" type="hidden" name='member_id' value="<sec:authentication property="principal.memberDTO.member_id"/>">
		</sec:authorize>
 		<div id="QNA" class="col-12 col-lg-8" style="margin:auto;">
			<c:if test="${board_category_num eq '1'}">
				<h3 class="QNA_board_title">공지</h3>
			</c:if>
			<c:if test="${board_category_num eq '2'}">
				<h3 class="QNA_board_title">2</h3>
			</c:if>
			<c:if test="${board_category_num eq '3'}">
				<h3 class="QNA_board_title">3</h3>
			</c:if>
			<c:if test="${board_category_num eq '4'}">
				<h3 class="QNA_board_title">리뷰</h3>
			</c:if>
			<c:if test="${board_category_num eq '5'}">
				<h3 class="QNA_board_title">상품 Q&A</h3>
			</c:if>
			<c:if test="${board_category_num eq '6'}">
				<h3 class="QNA_board_title">Q&A</h3>
			</c:if>

				<div class="board">
				<div class="boardSort">
				</div>
				<div style="margin:15px auto">
					<ul class="notice">
						<li class="list-item list-board-notice">
							<div class=" floatleft">
								<div class="col col110 floatleft">
									<i class="fa fa-plus-square-o"></i>
								</div>
								
								<div class="col col40 floatleft">
									
								</div>
								
								<div class="col col50 floatleft">
									<a href="#"></a>
								</div>
							</div>
						</li>
					</ul>	
					
					<c:forEach items="${list}" var="board">
						<ul class="helpUL">
							<li class="list-item">
								<div class=" floatleft">
									<div class=" col10">
										${board.board_num}
									</div>
									
									<div class=" col60">
										<c:if test="${board.layer > 0 }">
											<c:forEach begin="1" end="${board.layer}">
												&nbsp;&nbsp;
											</c:forEach>
											[RE]:
										</c:if>
										
										<a class="move" 
											href='/board/secret?board_category_num=<c:out value="${board.board_category_num}" />&board_num=<c:out value="${board.board_num}"/>&pageNum=<c:out value="${pageDTO.criteria.pageNum}" />&amount=<c:out value="${pageDTO.criteria.amount}" />'
												>
											<c:out value="${board.subject}" />
										</a> 
									</div>
								
									<div class=" col10 alignright">
										${board.member_name}
									</div>	
									<div class=" col20 alignright">
										<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate}"/>
									</div>	
								</div>
							</li>
						</ul>
					</c:forEach>
				</div>
				
				<sec:authorize access="isAuthenticated()">
					<a id="moveWriteForm" href='/board/write?board_category_num=<c:out value="${board_category_num}"/>&pageNum=<c:out value="${pageDTO.criteria.pageNum}"/>&amount=<c:out value="${pageDTO.criteria.amount}"/>'>Write</a>
				</sec:authorize>	
					
				
				<div class='pull-right'>
					<ul class="pagination" style="padding:60px 0px 20px ;justify-content: center">
						<c:if test="${pageDTO.prev}">
							<li class="paginate_button previous"><a
								href="${pageDTO.startPage -1}">Previous</a></li>
						</c:if>

						<c:forEach var="num" begin="${pageDTO.startPage}" end="${pageDTO.endPage}">
							<li class="paginate_button"> 
								<a href="/board/list?board_category_num=${board_category_num}&pageNum=${num}&amount=24">${num}</a>
							</li>
						</c:forEach>

						<c:if test="${pageDTO.next}">
							<li class="paginate_button next"><a
								href="${pageDTO.endPage +1 }">Next</a></li>
						</c:if>

					</ul>
				</div>
				<%-- end Pagination --%>
				
				<form id='actionForm' action="/board/list" method='post'>
					<input type='hidden' name='board_category_num' value='${board_category_num}'>
					<input type='hidden' id="board_num" name='board_num' value="">
					<input type='hidden' name='pageNum' value='${pageDTO.criteria.pageNum}'>
					<input type='hidden' name='amount' value='${pageDTO.criteria.amount}'>
					
					<%-- <sec:authorize access="isAuthenticated()">
						<input id="memberAuthList" type="hidden" name='memberAuthList' value="<sec:authentication property="principal.memberDTO.memberAuthList"/>">
						<input id="loginMember_id" type="hidden" name='member_id' value="<sec:authentication property="principal.memberDTO.member_id"/>">
					</sec:authorize> --%>
				</form>
			</div>


		</div>
		
	</div> <%-- end #help_main --%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	let actionForm = $("#actionForm");
	let loginMember_id = $("#loginMember_id").val();
	console.log(loginMember_id);
	
	$(".paginate_button a").on("click", function(e){
		e.preventDefault();
		console.log('click');
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	$(".move").on("click", function(e){
		e.preventDefault();
		
		if (loginMember_id === undefined) {
			alert("로그인이 필요합니다. 로그인 해주세요.");
			location.href = '/member/login';
		} else {
			$(this).unbind('click').click()
		}
	});
	
});
</script>

</body>
</html>

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
			<h2>유저 검색</h2>
			<form id="searchForm" method="post" autocomplete="off">
				<div class="searchInputArea">	
					<div class="inputArea">
						<label for="member_id">회원ID</label>
						<input type="text" id="searchMember_id" name="member_id" style="width:300px"/>
					</div>
					<div class="inputArea">
						<label for="member_name">회원명</label>
						<input type="text" id="searchMember_name" name="member_name" style="width:300px"/>
					</div>		
				
					<button type="button" id="search_Btn" class="btn btn-primary">검색</button>
				</div>
			</form>
			
			<div class="searchResult">
				<input id="searchProduct" type="text" value="">
				<table id="tr" border="1">
					
				</table>
			</div>
			
			<form id="deleteMemberList" action="/product/delete" method="post">
			
			</form>
			
			
			<h2>회원 등급 수정</h2>
			
			<form id="memberAuthUpdate" method="post" action="/member/memberGradeUpdate">
				<div class="inputArea">
					<div class="inputArea">
						<label for="member_id">아이디</label>
						<input type="text" id="member_id" name="member_id" value="" style="width:300px" readonly="readonly"/>
					</div>
					
					<div class="inputArea">
						<label for="member_name">이름</label>
						<input type="text" id="member_name" name="member_name" value="" style="width:300px" readonly="readonly"/>
					</div>
					
					<div id="auth">	
						<label>회원등급</label>
						<select id="authority" name="authority">
							<option value="ROLE_MEMBER">일반 사용자</option>
							<option value="ROLE_ADMIN">운영자</option>
						</select>
					</div>
				</div>
							
				<div class="inputArea">
					<button type="button" id="update_Btn" class="btn btn-primary">수정</button>
					<button type="button" id="back_Btn" class="btn btn-warning">취소</button>			
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

$("#back_Btn").click(function(){
	//history.back();
	console.log("back_Btn");
	//location.href = "/admin/goods/view?n=" + ${goods.gdsNum};
});		


//검색버튼 클릭

let productList;

$("#search_Btn").on("click", function(){
	$.ajax({
		type: 'post',
		data: $("#searchForm").serialize(),
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		url: '/member/getMemberListByMemberIdAndMemberName',
		//url: '/member/test',
		dataType: 'json',
		success: function(MemberDTOList){
			console.log(MemberDTOList);
			
			$("#tr").children().remove();
			$("#tr").append("<tr>" +
					"<td>목록추가</td>" +
					"<td>ID</td>" +
					"<td>회원명</td>" +
					"<td>연락처</td>" +
					"</tr>");
			
			$.each(MemberDTOList, function(index, item){
				$("#tr").append(
								"<tr>" +
								"<td><input type='checkbox' id='checkMember_id' name='checkMember_id' value='" + item.member_id + "'></td>" +
								"<td><a class='move' href='" + item.member_id +"' value='" + item.member_name + "'>" + item.member_id + "</a></td>"+
								"<td>" + item.member_name + "</td>"+
								"<td>" + item.addressDTOList[0].tel1 + "-" + item.addressDTOList[0].tel2 + "-" + item.addressDTOList[0].tel3 + "</td></tr>"
				);
			});
		},
		error: function(e) {
			console.log(e);
			
		}
	});
});

//회원 등급 수정
$("#update_Btn").on("click", function(){
	$.ajax({
		type: 'post',
		data: $("#memberAuthUpdate").serialize(),
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		url: '/member/memberAuthUpdate',
		success: function(){
			alert("회원등급을 변경했습니다.");
			window.location.href = "/member/management";
		},
		error: function(e) {
			console.log(e);
		}
	});	
});

$(document).on("click", "a.move", function(e){
	e.preventDefault();
	console.log(e);
	
	$("#member_id").val('');
	$("#member_name").val('');
	$("#selectRank_num").val('');
	
	$.ajax({
		url: '/member/getMemberByMemberIdAndMemberName',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		type: 'post',
		data: {
			'member_id' : $(this).attr("href"),
			'member_name' : $(this).attr("value"),
		},
		dataType: 'json',
		success: function(memberDTO){
			console.log(memberDTO);
			
			$("#member_id").val(memberDTO.member_id);
			$("#member_name").val(memberDTO.member_name);
			$("#authority").val(memberDTO.memberAuthList[0].authority).prop("selected", true);
		},
		
		error: function(e) {
			console.log(e);
		}
	});
}); 


</script>

<script type="text/javascript">


//회원 휴면 처리

</script>


</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="/css/secret.css" />
    <title>secret</title>
  </head>
  <body>
    <div id="secretDiv">
    	<input type="hidden" id="map" value="${map }"> 
    	<input type="hidden" id="pwd" value="${map.pwd }"> 
      <h3>상품 Q&A</h3>
      <h3 style="font-size: 12pt">비밀글 보기</h3>
      <p style="font-size: 11pt">
        이글은 비밀글입니다.비밀번호를 입력해 주세요<br />
      </p>
      <label>Password</label><br />
      <input
      	id="inputPwd"
        type="text"
        style="width: 15%; border: 0px; border-bottom: 1px solid gray"
      />
      <br />

      <a id="backToList" href="#">BACK TO LIST</a>
      <a id="CONFIRM" href="#">CONFIRM</a>
    </div>
    
    <form id='actionForm' action="/board/get" method="get">
		<input type='hidden' name='board_category_num' value='${map.board_category_num}'>
		<input id="board_num" type='hidden' name='board_num' value="${map.board_num}">
		<input type='hidden' name='pageNum' value='${map.pageNum}'>
		<input type='hidden' name='amount' value='${map.amount}'>
		<input type="hidden" name='pwd' value=''>
	</form>
  </body>
  
  <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
  <script type="text/javascript">
  let actionForm = $("#actionForm");
  
  $("#CONFIRM").on("click", function(){
	  if($("#pwd").val() == $("#inputPwd").val()){
	  		console.log("비번일치");
	  		actionForm.submit();
	  } else {
	  		alert("비밀번호가 틀립니다.");
	  		$("#inputPwd").val("");
	  }
  });	
  
  $("#backToList").on("click", function(e){
	  e.preventDefault();
	  actionForm.attr("action", "/board/list");
	  actionForm.attr("pwd", $("#pwd").val());
	  actionForm.submit();
  });
  
 
  	
  </script>
</html>
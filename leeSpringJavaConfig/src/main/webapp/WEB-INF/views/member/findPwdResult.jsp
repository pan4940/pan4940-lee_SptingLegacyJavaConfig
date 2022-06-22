<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
#findPwdResultDiv {
	margin: 200px auto;
}
</style>


<div id="findPwdResultDiv" class="col-12 col-lg-6">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<h3>
		<center>FIND PassWord</center>
	</h3>

	<ul>
		<li>
			<label for="ID" style="color: gray">ID</label><br />
			<div id="findID">${memId}</div> 
			<label for="name" style="color: gray">Name</label><br />
			<div id="findname">${memName}</div> 
			<input type="hidden" value="${memId}" id="member_id">
		</li>

		<li id="radiofind">
			<label for="searchOption" style="color: gray">${memOption}</label><br />
			<input type="hidden" value="${memOption}" id="memOption"> 
			<input type="radio" style="color: gray" checked /> 
			<span id="searchkeyword">${memKeyword}</span>
			<input type="hidden" value="${memKeyword}" id="memKeyword">
		</li>

	</ul>
	<br>
	<input id="rePwdBtn" type="button" name="pwdbtn2"
		style="font-size: 9pt" value="임시비밀번호 전송"/> 
	<input id="cancel" type="button" name="cancelbtn" style="font-size: 9pt" value="로그인" onclick="location.href = 'loginForm' " />
</div>

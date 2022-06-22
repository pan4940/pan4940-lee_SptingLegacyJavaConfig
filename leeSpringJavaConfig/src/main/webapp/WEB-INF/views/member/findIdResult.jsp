<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
#findIdResultDiv {
	margin: 200px auto;
}
</style>

<div id="findIdResultDiv" class="col-12 col-lg-6">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<h3>
		<center>FIND ID</center>
	</h3>

	<ul>
		<li><label for="name" style="color: gray">Name</label><br />
			<div id="findname">${memName}</div></li>

		<li><label for="searchOption" style="color: gray">${memOption}</label><br />
			<div id="searchKeyword">${memKeyword}</div></li>
		<br>
		<li id="radiofind" style="display: flex">
			<ul id="findid">

			</ul>
			<ul id="idOption">

			</ul>
		</li>
	</ul>
	<br> 
		<input id="loginBtn" type="button" name="btn" style="font-size: 9pt" value="Login" onclick="location.href = 'loginForm'" /> 
		
		<input id="findPwdBtn" type="button" name="'btn" 
			style="font-size: 9pt" value="find Password" onclick="location.href = 'findPwdForm' " />
</div>







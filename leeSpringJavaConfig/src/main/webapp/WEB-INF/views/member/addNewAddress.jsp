<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<link rel="stylesheet" href="/resources/css/addNewAddress.css" />

<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<sec:authentication property="principal.memberDTO" var="memberDTO"/>
<form id="addressEditForm" name="addressEditForm">
	<div id="addressEditDiv">
		<h3>
			<center>NEW ADDRESS</center>
		</h3>
		<input type="hidden" name="member_id" value=${memberDTO.member_id}> 
		
		<p></p>
		<div id="postDiv">
			<div id="post1">
				<label for="post" style="color: gray">우편번호</label><br /> 
				<input type="text" id="zipcode" name="zipcode" readonly
					style="width: 100%; border: 0px; border-bottom: 1px solid gray" />
			</div>
			<div id="post2">
				<!-- <label for="postbtn" style="color: gray">우편번호/주소</label> -->
				<button id="postbtn"
					style="border: 0px; background-color: white; font-weight: bold; font-size: 9pt; color: black; padding: 0; cursor: pointer; margin-top: 10px;"
					onclick="checkPost(); return false;">우편번호 검색</button>
			</div>
		</div>
		<p></p>
		<p></p>

		<label for="address" style="color: gray">주소1(지번/도로명)</label><br /> <input
			type="text" id="addr1" name="addr1" readonly
			style="width: 100%; border: 0px; border-bottom: 1px solid gray" />
		<p></p>
		<label for="address2" style="color: gray">주소2(동/호수등)</label><br /> <input
			type="text" id="addr2" name="addr2"
			style="width: 100%; border: 0px; border-bottom: 1px solid gray" />
		<p></p>
		
		
		<input type="checkbox" name="defaultAddr"> 기본배송지로 저장

		<div id="btn">
			<input type="button" id="cancelBtn" value="CANCEL" onclick="location.href='addresses'"> 
			<input type="button" id="saveBtn" value="SAVE">
		</div>
	</div>
</form>

<script type="text/javascript" src="/resources/js/addNewAddress.js"></script>


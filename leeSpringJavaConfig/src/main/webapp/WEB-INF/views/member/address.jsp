<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    

<link rel="stylesheet" href="/resources/css/address.css" />
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<form id="addressForm" name="addressForm">
	<div id="addressDiv">
		<div id="addbook">
			<h3>
				<center>ADDRESS BOOK</center>
			</h3>
		</div>
		<div id="content">
			<c:forEach items="${memberDTO.addressDTOList}" var="memberAddressDTO">
				<div id="addcontent">
					<input type="checkbox" id="deleteAddress" name="deleteAddress" class="checkbox" value="${memberAddressDTO.address_id}">
					<div id="address1">
						<%-- <span>${memberAddressDTO.orders}</span> --%>
						<span>${memberAddressDTO.zipcode}</span>
						<span>${memberAddressDTO.addr1}</span>
						<span>${memberAddressDTO.addr2}</span>
						<span>${memberDTO.phone1} - ${memberDTO.phone2} - ${memberDTO.phone3}</span>
					</div>
					<a href="/member/addressEdit?address_id=${memberAddressDTO.address_id}">EDIT</a>
				</div>
			</c:forEach>
		</div>

		<div id="addBtn">
			<input type="button" id="DELETEbtn" value="DELETE" /> 
			<input type="button" id="ADDBtn" value="ADD NEW ADDRESS" onclick="location.href='/member/addNewAddress'" />
		</div>
	</div>
</form>

	<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	<script type="text/javascript" src="/resources/js/address.js"></script>



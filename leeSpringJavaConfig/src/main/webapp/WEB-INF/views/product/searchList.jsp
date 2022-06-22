<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<input type="hidden" id="product_name" value="${product_name}">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<div>
	<div id="searchResultDiv"></div>
	<div id="searchListsDiv" style="display:flex; flex-wrap:wrap"></div>
	<div id="searchPagingDiv"></div>
</div>
<script type="text/javascript" src="/resources/js/searchList.js"></script>
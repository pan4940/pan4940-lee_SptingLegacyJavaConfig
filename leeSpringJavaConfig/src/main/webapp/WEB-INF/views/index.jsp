<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>THE C SHOP 더 C 샵</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="referrer" content="strict-origin-when-cross-origin">


<%-- Latest compiled and minified CSS --%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

<%-- Latest compiled JavaScript --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<%-- jquery --%>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.min.js"></script>

<%-- 아이콘 --%>
<script src="https://kit.fontawesome.com/6004efe7d6.js" crossorigin="anonymous"></script>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>



<link rel="stylesheet" href="/resources/css/nav.css" />
<link rel="stylesheet" href="/resources/css/main.css" />
<link rel="stylesheet" href="/resources/css/footer.css" />
<link rel="stylesheet" href="/resources/css/login.css" />
<link rel="stylesheet" href="/resources/css/join.css" />
<link rel="stylesheet" href="/resources/css/account.css" />
<link rel="stylesheet" href="/resources/css/list.css" />
<link rel="stylesheet" href="/resources/css/modify.css" />
<link rel="stylesheet" href="/resources/css/findId.css" />
<link rel="stylesheet" href="/resources/css/findPwd.css" />
<link rel="stylesheet" href="/resources/css/store.css" />
<link rel="stylesheet" href="/resources/css/shipping.css" />
<link rel="stylesheet" href="/resources/css/privacy.css" />
<link rel="stylesheet" href="/resources/css/term.css" />
<link rel="stylesheet" href="/resources/css/about.css" />
<link rel="stylesheet" href="/resources/css/detail.css" />


</head>
	
<body>
	
	<%-- jsp주석 --%>
	<nav class="fixed-top">
		<jsp:include page="/WEB-INF/component/nav/nav.jsp"/>
	</nav>
	<div class='main col-12' style="margin-top:57px">
		<c:if test="${empty requestScope.display }">
			<jsp:include page="/WEB-INF/component/main/main.jsp"/>
		</c:if>
		<c:if test="${not empty requestScope.display }">
			<jsp:include page="${requestScope.display}"/>
		</c:if>
	</div>
	<div class='footer'>
		<jsp:include page="/WEB-INF/component/footer/footer.jsp"/>
	</div>

	<script type="text/javascript" src="/resources/js/nav.js"></script>
	<script type="text/javascript" src="/resources/js/footer.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    <script type="text/javascript" src="/resources/js/join.js"></script>
    <script type="text/javascript" src="/resources/js/modify.js"></script>
    <script type="text/javascript" src="/resources/js/kakao.js"></script>
    <script type="text/javascript" src="/resources/js/naver.js"></script>
    <script type="text/javascript" src="/resources/js/google.js"></script>
    <script type="text/javascript" src="/resources/js/findPwd.js"></script>
    <script type="text/javascript" src="/resources/js/findId.js"></script>
    <script type="text/javascript" src="/resources/js/findPwdResult.js"></script>
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<ul>

	<sec:authorize access="isAuthenticated()">
		<li>
			<a href="/">일반 화면</a>	
		</li>
		<li>
			<a class="logoutBtn">로그아웃</a>
			
			<form id="logoutForm" action="/member/logout" method="post">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
		</li>
	</sec:authorize>
</ul>

<script type="text/javascript">
$('.logoutBtn').click(function() {
	$("#logoutForm").submit();
});

</script>
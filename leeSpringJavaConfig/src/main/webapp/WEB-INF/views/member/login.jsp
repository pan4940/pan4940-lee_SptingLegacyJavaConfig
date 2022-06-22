<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<script src="https://accounts.google.com/gsi/client" async defer></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<%-- <script src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"></script> --%>
<script type="text/javascript" src="/resources/js/login.js"></script>
    
    <div id="loginDiv">
      <form id="loginForm" action="/member/loginOK" method="post">
      <div id="login">
        <input id="member_id" name="member_id" style="width: 100%; border: 0px; border-bottom: 2px solid black"
          type="text"placeholder="ID" />
        
        <br />
        <input
          id="member_pwd" type="password" name="member_pwd"
          style="width: 100%; border: 0px; border-bottom: 2px solid black"
          placeholder="Password"
        />
        
        <br />
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	    
	    <h2><c:out value="${error}"/></h2>
	    <h2><c:out value="${logout}"/></h2>
	    
	    <input id="loginBtn" type="button" value="Login" />
        <br />
      </div>
	  </form>
      <div id="login2">
        <span>
        	Forgotten 
        	<a onclick="location.href='findIdForm'">ID</a> 
        	or 
        	<a onclick="location.href='findPwdForm'">Password</a>
        </span>
        <span><a onclick="location.href='/member/joinForm'">New Customer</a></span>
      </div>

      <div id="login3">
        <span>Login with </span>&nbsp;&nbsp;
        <%-- 네이버 로그인 버튼 노출 영역 --%>
        <div id="message"></div>
        
        
        
  		<div id="button_area"> 
  			<div id="naverIdLogin"></div>
  			
  			<div id="googleBtn">
			</div>

			<span>
				<img id="kakaoLogin" alt="" src="/resources/image/kakao_login_medium_narrow.png">
	        </span>
  		</div>
        
        
      </div>
    </div>
  
     
<%-- 네이버 스크립트 --%>
<%-- <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script> --%>


	

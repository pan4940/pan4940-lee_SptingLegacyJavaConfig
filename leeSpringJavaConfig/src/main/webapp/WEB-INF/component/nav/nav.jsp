<%@page import="member.bean.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%-- 첫번째 div  --%>
<div id="first" class="nav_div">
	
		<span>SS 22 NEW ARRIVAL</span> 
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<a href="/admin/index">관리자페이지</a>
		</sec:authorize>
</div>

<div id="second_large" class="nav_div">
	<div>
		<a href="/">THE C SHOP</a>
	</div>

	<div id="secondmenu">

		<span><a href="/product/list?product_category_num=1100">MEN</a>
		</span> <span><a href="/product/list?product_category_num=2000">WOMEN</a>
		</span> <span><a href="/product/brands">BRANDS</a> </span> <span><a
			href="/board/list?board_category_num=7">POST</a>
	</div>

	<%-- <button type="button" id="autoLogin"></button> --%>
	<div>
		<a href="/board/list?board_category_num=5&pageNum=1&amount=10">HELP</a>
		<button class="search" style="border: 0; background-color: white;">
			<i class="fa-solid fa-magnifying-glass"></i>
		</button>
		<sec:authorize access="isAnonymous()">
			<a href="/member/login">LOGIN</a>
		</sec:authorize>
		<sec:authorize access="isAuthenticated()">
			<a class="account" id="account">ACCOUNT</a>
		</sec:authorize>
		<div id="account_drop">
			<ul>
				<li><a href="/member/account">ACCOUNT DETAIL</a></li>
				<li><a href="/order/orderHistory">ORDER HISTORY</a></li>
				<li><a href="/member/addresses">ADDRESSES</a></li>
				<li><a href="/board/list?board_category_num=5&pageNum=1&amount=10">HELP</a></li>
				<li><a class="logoutBtn">LOGOUT</a></li>
			</ul>
		</div>
		<button class="cart" style="border: 0; background-color: white;">
			<img
				src="https://img.icons8.com/material/24/000000/favorite-cart.png" />
		</button>
		<%-- <button id="cart"style="border: 0; background-color: white;"><img src="https://img.icons8.com/material/24/000000/clear-shopping-cart--v1.png"/></button>--%>
	</div>
</div>

<div id="third_large">
  
  </div>
  
  <div id="second_small" class="nav_div">

  <div>
  	<button id="menu"style="border: 0; background-color: white;"><i class="fa-solid fa-bars"></i></button>
 </div>
  
  <div>
    <a href="/" >THE C SHOP</a>
  </div>

  <div>
    <button class="search" style="border: 0; background-color: white;" ><i class="fa-solid fa-magnifying-glass"></i></button>
    <button class="cart"style="border: 0; background-color: white;"><img src="https://img.icons8.com/material/24/000000/favorite-cart.png"/></button>
  </div>
</div>

<div id="third_small">
	<div>
		<div><a href="/list?category=men">MEN</a>
		</div>
		<div><a href="/list?category=women">WOMEN</a>
		</div>    
		<div><a href="/list?category=lifeStyle">LIFE STYLE</a>
		</div>   
		<%-- <div><a href="/list?category=sale">SALE</a>
		</div> --%>
		<div><a href="/product/brands">BRANDS</a>
		</div>
		<div><a href="/board/list?board_category_num=7">POST</a>
		</div>
	</div>
	<hr>
	
	<div id="small_menu">
	<sec:authorize access="isAnonymous()">
		<div>
			<a href="/member/loginForm">LOGIN</a>
		</div>
		<div>
			<a href="/member/joinForm">CREATE ACCOUNT</a>
		</div>
		<%-- 
		<div><a href="#">ORDERS</a>
		</div> 
		--%>
	</sec:authorize>
	<sec:authorize access="isAuthenticated()">
		<div><a href="/member/account">ACCOUNT DETAIL</a>
		</div>
		<div><a href="/order/orderHistory">ORDER HISTORY</a>
		</div>
		<div><a href="/member/addresses">ADDRESSES</a>
		</div>	
		<div><a class="logoutBtn">LOGOUT</a>
			<form id="logoutForm" action="/member/logout" method="post">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
		
		</div>
	</sec:authorize>
	</div>
</div>
<div id="fourth" class="sticky" >
<form action="/product/searchList" method="post" style="width:90%">
	<input name="product_name" id="keyword" type="text" placeholder="SEARCH" list="options">
</form>
<a href="#" id="searchCloseBtn">close</a>
</div>

<script type="text/javascript">
$("#autoLogin").on("click", function() {
	$.ajax({
        type:'post',
        url:'/member/loginOK',
        data: {
           'member_id': 'dltjdgus',
           'member_pwd': '@a123456'
        },
        dataType:'text',
        success:function(data){
           data = data.trim();
           if(data =='ok'){
            
           }else if(data=='fail'){
              
           }
        },
        error:function(err){
           alert(err);
        }
     });
});
</script>
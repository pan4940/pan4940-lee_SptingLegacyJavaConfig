<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/css/cart.css" />
<div id="cartok">
	<div id="top" class="col-12">
		<h3>SHOPPING CART</h3>
	</div>
	<div id="mid" class="col-12 col-sm-6">
	
	</div>
	<div id="side" class="col-12 col-sm-6">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div id="total">
			<label id="totallabel" style="color: black">TOTAL AMOUNT</label> <br />
			<span id="totalvalue" style="color: black; font-size: 25pt">value</span>
			<br /> 
			<label class="gray">Subtotal</label> <span id="subtotalvalue">value원</span>
			<br /> 
			<label class="gray">Shpping</label> <span id="shippingvalue">value원</span>
			<br /> 
			<br /> 
			<a href="/order/checkout"
				style="font-size: 30px; font-weight: bold">CHECK OUT</a>
			<hr>
		</div>
		<div id="neverpay"></div>
	</div>
	<div id="noCart" style="display: none">
		<p>
			장바구니가 비어 있습니다.. <a href="/product/list?product_category_num=1100">Go Shopping</a>
		</p>
	</div>
</div>

<script type="text/javascript" src="/resources/js/cart.js"></script>
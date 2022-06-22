<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<%-- iamport.payment.js --%>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>  
<link rel="stylesheet" href="/resources/css/orderdetail.css" />
<div id="orderdetailDiv" class="col-12 col-lg-6">
	<h3>
		<center>YOUR CART</center>
	</h3>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" id="memberDTOtel1" value="${principal.memberDTO.tel1}">
	<input type="hidden" id="memberDTOphone1" value="${principal.memberDTO.phone1}">
	<div id="cartList">
	
	</div>
	
	<div id="carttotal">
		<label id="totalamount">TOTAL AMOUNT</label> <span id="total"
			style="font-size: 20pt">토탈금액</span>
		<div id="totallabel">
			<label>Subtotal</label> <span id="subtotal">value</span> <br /> <label>Shipping</label>
			<span id="shipping">value</span>
		</div>
	</div>

	<div id="orderinformation">
		<h3>
			<center>주문자 정보</center>
		</h3>
		<label style="color: gray">이름</label><br /> 
			<input type="text"
				id="member_name" name="member_name" value="${principal.memberDTO.member_name}" readonly="readonly"
				style="width: 25%; border: 0px; border-bottom: 1px solid gray" /> <br />
		<label style="color: gray">우편번호</label><br /> 
			<input type="text"
				id="zipcode" name="zipcode" readonly="readonly"
				value="${principal.memberDTO.addressDTOList[0].zipcode}"
				style="width: 10%; border: 0px; border-bottom: 1px solid gray" />
		
		<br /> <label style="color: gray">주소</label><br /> 
			<input
				type="text" id="addr1" name="addr1" readonly="readonly"
				value="${principal.memberDTO.addressDTOList[0].addr1}"
				style="width: 80%; border: 0px; border-bottom: 1px solid gray" /> 
			<input
				type="text" id="addr2" name="addr2" value="${principal.memberDTO.addressDTOList[0].addr2}"
				style="width: 80%; border: 0px; border-bottom: 1px solid gray" readonly="readonly"/> <br />
		<label for="phone" style="color: gray">전화</label>
		<p></p>
		<select id="memberTel1" name="tel1" style="height: 30px">
			<option value="02">02</option>
			<option value="031">031</option>
			<option value="032">032</option>
			<option value="033">033</option>
			<option value="041">041</option>
			<option value="042">042</option>
			<option value="043">043</option>
			<option value="044">044</option>
			<option value="051">051</option>
			<option value="052">052</option>
			<option value="053">053</option>
			<option value="054">054</option>
			<option value="055">055</option>
			<option value="061">061</option>
			<option value="062">062</option>
			<option value="063">063</option>
			<option value="064">064</option>
			<option value="0502">0502</option>
			<option value="0503">0503</option>
			<option value="0504">0504</option>
			<option value="0505">0505</option>
			<option value="0506">0506</option>
			<option value="0507">0507</option>
			<option value="0508">0508</option>
			<option value="0508">0508</option>
			<option value="070">070</option>
			<option value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="018">018</option>
			<option value="019">019</option>
		</select> - <input type="text" name="tel2" value="${principal.memberDTO..tel2}"
			style="width: 50px; border: 0px; border-bottom: 1px solid gray" readonly="readonly"/> -
		<input type="text" name="tel3" value="${memberDTO.tel3}"
			style="width: 50px; border: 0px; border-bottom: 1px solid gray" readonly="readonly"/>

		<p></p>
		<label for="phone2" style="color: gray">휴대전화</label>
		<p></p>
		<select id="memberPhone1" name="phone1" style="height: 30px; width: 55px">
			<option value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="018">018</option>
			<option value="019">019</option>
		</select> - 
		<input type="text" id="phone2" name="phone2" value="${principal.memberDTO.phone2}"
			style="width: 50px; border: 0px; border-bottom: 1px solid gray" readonly="readonly"/> -
		<input type="text" id="phone3" name="phone3" value="${principal.memberDTO.phone3}"
			style="width: 50px; border: 0px; border-bottom: 1px solid gray" readonly="readonly"/>
		<p></p>
		<label for="email" style="color: gray">이메일</label>
		<p></p>
		<input type="text" id="email" name="email"
			value="${memberDTO.email}"
			style="width: 50%; border: 0px; border-bottom: 1px solid gray" readonly="readonly"/>
		
	</div>
	<form id='shippinginformationForm' >
	<div id="shippinginformation" name="shippinginformation">
		<h3>
			<center>배송지 정보</center>
		</h3>
		<label style="color: gray">이름</label><br /> 
			<input type="text"
			id="member_name" name="member_name" value="${principal.memberDTO.member_name }"
			style="width: 25%; border: 0px; border-bottom: 1px solid gray" /> <br />
			<input type="hidden" value="${principal.memberDTO.member_id}">
		
		<label style="color: gray">우편번호</label><br /> 
		<input type="text"
			id="zipcode" name="zipcode" readonly="readonly"
			value="${memberDTO.zipcode }"
			style="width: 10%; border: 0px; border-bottom: 1px solid gray" />
		<button>SEARCH</button>
		<br /> <label style="color: gray">주소</label><br /> 
		<input
			type="text" id="addr1" name="addr1" readonly="readonly" value="${principal.memberDTO.addressDTOList[0].addr1 }"
			style="width: 80%; border: 0px; border-bottom: 1px solid gray" /> 
		<input
			type="text" id="addr2" name="addr2" value="${principal.memberDTO.addressDTOList[0].addr2}" readonly="readonly"
			style="width: 80%; border: 0px; border-bottom: 1px solid gray" /> <br />
		
		<label for="phone" style="color: gray">전화</label>
		<p></p>
		<select id="tel1" name="tel1" style="height: 30px">
			<option value="02" >02</option>
			<option value="031">031</option>
			<option value="032">032</option>
			<option value="033">033</option>
			<option value="041">041</option>
			<option value="042">042</option>
			<option value="043">043</option>
			<option value="044">044</option>
			<option value="051">051</option>
			<option value="052">052</option>
			<option value="053">053</option>
			<option value="054">054</option>
			<option value="055">055</option>
			<option value="061">061</option>
			<option value="062">062</option>
			<option value="063">063</option>
			<option value="064">064</option>
			<option value="0502">0502</option>
			<option value="0503">0503</option>
			<option value="0504">0504</option>
			<option value="0505">0505</option>
			<option value="0506">0506</option>
			<option value="0507">0507</option>
			<option value="0508">0508</option>
			<option value="0508">0508</option>
			<option value="070">070</option>
			<option value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="018">018</option>
			<option value="019">019</option>
		</select> - <input type="text" id="tel2" name="tel2" value="${principal.memberDTO.tel2 }"
			style="width: 50px; border: 0px; border-bottom: 1px solid gray" /> -
		<input type="text" id="tel3" name="tel3" value="${principal.memberDTO.tel3 }"
			style="width: 50px; border: 0px; border-bottom: 1px solid gray" />

		<p></p>
		<label for="phone2" style="color: gray">휴대전화</label>
		<p></p>
		<select id="phone1" name="phone1" style="height: 30px; width: 55px">
			<option value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="018">018</option>
			<option value="019">019</option>
		</select> - <input type="text" id="phone2" name="phone2" value="${principal.memberDTO.phone2 }"
			style="width: 50px; border: 0px; border-bottom: 1px solid gray" /> -
		<input type="text" id="phone3" name="phone3" value="${principal.memberDTO.phone3 }"
			style="width: 50px; border: 0px; border-bottom: 1px solid gray" />

		<p></p>
		<label style="color: gray">배송메세지</label> <br />
		<textarea name="message"> </textarea>
	</div>
	
	<div id="point">
		<h3 style="margin-bottom: 80px">
			<center>적립금 사용</center>
		</h3>

		<input id="mileageInput" name="mileageInput" type="number" value="0" min=0
			max=${principal.memberDTO.mileage }
			style="width: 12%; border: 0px; border-bottom: 1px solid gray" />
		<span style="margin-left: 10px">total:${memberDTO.mileage }</span>
	</div>
		<input id="totalPrice" name="totalPrice" type="hidden" value="">
		<input id="status" name="status" type="hidden" value="">
		<input id="deliveryCost" name="deliveryCost" type="hidden" value="">
		<input id="member_id" name="member_id" type="hidden" value="${principal.memberDTO.member_id}">
		<input id="order_name" name="order_name" type="hidden" value="">
		<input id="order_id" name="order_id" type="hidden"  value=""> 
	
	</form>

	
	<div id="payment">
		<h3>
			<center>결제 정보</center>
		</h3>
		<div id="leftright">
			<div id="leftDiv">
				<label>총 결제 금액</label> <span id="lastTotal">금액</span>
			</div>
			<div id="rightDiv">
				<label>결제 방법</label> 
				<input type="radio" checked /> 
				<span>이니시스 결제</span>
			</div>
		</div>
		<button id="checkoutBtn">Checkout Now</button>
	</div>
		
   
  
</div>

<script type="text/javascript" src="/resources/js/checkout.js"></script>

<script type="text/javascript">
//주문 요청
$(function(){
	
	console.log($("#memberDTOtel1").val());
	console.log($("#memberDTOphone1").val());
	
	$("#memberTel1").val($("#memberDTOtel1").val()).attr("selected", "selected");
	$("#memberPhone1").val($("#memberDTOphone1").val()).attr("selected", "selected");

	$("#memberTel1 option").not(":selected").remove();
	$("#memberPhone1 option").not(":selected").remove();
	
	
	$("#tel1").val($("#memberDTOtel1").val()).attr("selected", "selected");
	$("#phone1").val($("#memberDTOphone1").val()).attr("selected", "selected");

	
	$("#checkoutBtn").click(function (){
		console.log($('.youcartName')[0].innerText.split('\n')[0])
   		console.log($('.youcartName').length)
		let itemName=$('.youcartName')[0].innerText.split('\n')[0];
   		
   		if($('.youcartName').length > 1){
   			itemName=itemName+' 외 '+($('.youcartName').length-1)+' 건';
   		}
   		$('#order_name').val(itemName);
   		
   		let order_id = createOrderId();
   		console.log(order_id);
   		$('#order_id').val(order_id);
   		$("#shippinginformationForm").append($("#cartList"));
   		console.log(itemName)
   		console.log($('#shippinginformationForm').serialize());
   		
   		
  		//OrderDTO 와 DetailOrderDTO등록
   		let IMP = window.IMP; // 생략 가능
   	    IMP.init("imp68632155"); //
		console.log(order_id);
		IMP.request_pay({
			pg: 'html5_inicis',
			pay_method:'card',
			merchant_uid: order_id,
			name: itemName,
			//amount: $('#totalPrice').val(),
			amount: 100,
			buyer_email:'${memberDTO.email}',
			buyer_tel: $('#phone1').val()+'-'+$('#phone2').val()+'-'+$('#phone3').val(),
			buyer_addr: $('#addr1').val()+' '+$('#addr2').val(),
			buyer_postcode:$('#zipcode').val(),
			m_redirect_url: 'localhost:8090/'
		}, function (rsp){
			console.log(rsp);
			
			if (rsp.success){ 
         		var msg='결제 완료';
	         	$.ajax({
	        		type:'post',
	        		url:'/order/registerOrderDTO',
	        		data: $('#shippinginformationForm').serialize(),
	        		success: function() {
	        			
	        			Swal.fire({
	 					icon: 'success',
	 					title: ' 주문이 완료되었습니다!'
	 				}).then(function() {
	 					location.href = '/order/orderHistory';
	 				});
	        			
	        			console.log("성공");
	        	    },
	    	        error: function(err) {
	    	            console.log(err);
	    	        },
        		}); //end ajax 
			} else {
				var msg='결제 실패';
				msg += '\n애러내용: '+rsp.error_msg;
				Swal.fire({
					icon: 'warning',
					title: msg,
            	});
         	}
		}); //end pay
  		
	}); //end $("#checkoutBtn").click 
}); // $(function(){
	

function createOrderId() {
	date = new Date();
	let year = date.getFullYear().toString();
	let month = (date.getMonth() + 1).toString();
	
	if (month < 10) {
		month = '0' + month;
	}
	let today = date.getDate().toString();
	
	if (today < 10) {
		month = '0' + today;
	}
	
	let random = Math.floor((Math.random() * (100000))).toString().padStart(5, '0');
	
	let order_id = year + month + today + random;
	return order_id;
}	
	
</script>

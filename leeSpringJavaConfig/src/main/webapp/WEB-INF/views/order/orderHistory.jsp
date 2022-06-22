<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/css/orderHistory.css" />
<div id="orderHistoryDiv">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<h3>
		<center>ORDER HISTORY</center>
	</h3>
	<button id="totalOrderBtn">Total Order(0)</button>
	<!-- <button>Canceled & Returns (0)</button> -->
	<div id="orderlist">No order.</div>
	<div id="paging">
	
	</div>
</div>

<script type="text/javascript">
$(function(){
	$.ajax({
		url:'/order/getOrderHistory',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		type:'post',
		dataType: 'json',
		success:function(data){
			console.log(data)
			
			if(data.length>0){
				$('#totalOrderBtn').text("Total Order ("+data.length+")")
				$('#orderlist').empty();
				$('<table/>',{class:'col-12',id:'orderHistoryTable'}).append(
					$('<tr/>').append(
						$('<th/>',{class:'col-2',text:'Date'})	
					).append(
						$('<th/>',{class:'col-6',text:'Order Product'})	
					).append(
						$('<th/>',{class:'col-2',text:'Total Price'})
					).append(
						$('<th/>',{class:'col-2',text:'Status'})
					)		
				).appendTo($('#orderlist'));
				$.each(data,function(index,item){
					$('<tr/>').append(
						$('<td/>',{text:item.legDate})	
					).append(
						$('<td/>',{text:item.order_id})
						//itemName=itemName+' 외 '+($('.youcartName').length-1)+' 건';
					).append(
						$('<td/>',{text:item.totalPrice.toLocaleString()+' 원'})
					).append(
						$('<td/>',{text:item.status})
					).appendTo($('#orderHistoryTable'))		
				})
			}
		},
		error:function(err){
			console.log(err);
		}
	});
});
	

</script>
  
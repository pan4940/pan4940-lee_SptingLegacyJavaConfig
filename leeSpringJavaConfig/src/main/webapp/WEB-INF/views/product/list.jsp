<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/resources/css/list.css" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>    
<input id="product_category_num" type="hidden" value=${product_category_num}>
<input id="pageNum" type="hidden" value="${pageDTO.criteria.pageNum}">
<input id="amount" type="hidden" value="${pageDTO.criteria.amount}">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<style>

.categoryListDiv ul {
    margin: 0 0 20px;
    padding-left: 0px;
}

.show {
    display: none;
}


.show ul {
    margin: 0 0 0 10px;
    padding-left: 0px;
}



</style>

<div class="col-12" style="display: grid;
	grid-template-columns: 200px;
	padding: 20px;
	grid-template-rows: 50px auto 50px;"
>
    <div class="categoryNameDiv">
	    <h2>
	    	<span></span>
	    </h2>
    </div>
    <div class="categoryListDiv">
    	<ul>
    	</ul>
    	
    	
    </div>
    
    <div class="productListDiv"></div>
    <div class="pagingDiv">
    	<ul class="pagination" style="justify-content: center">
			<c:if test="${pageDTO.prev}">
				<li class="paginate_button previous"><a
					href="${pageDTO.startPage -1}">Previous</a></li>
			</c:if>

			<c:forEach var="num" begin="${pageDTO.startPage}" end="${pageDTO.endPage}">
				<li class="paginate_button">
					<a href="/product/list?product_category_num=${product_category_num}&pageNum=${num}&amount=24">${num}</a>							
					<%-- <a href="${num}">${num}</a>		 --%>					
				</li>
			</c:forEach>

			<c:if test="${pageDTO.next}">
				<li class="paginate_button next"><a
					href="${pageDTO.endPage +1 }">Next</a></li>
			</c:if>
		</ul>
    </div>
</div>


<script type="text/javascript">

$(function() {
	
	//list 좌측 카테고리 리스트 가져오기
	$.ajax({
	type:'post',
		url:'/product/getProductCategoryByProductCategoryREF',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		data: 'product_category_num=' + $("#product_category_num").val(),
		dataType:'json',
		success:function(data){
			let str = "";
			
			$.each(data.productCategoryList, function(index,item){
				str += "<li><a href='/product/list?product_category_num=" + item.product_category_num + "'>" + item.product_category_name +"</a>";
				str += "<div class='show' id='product_category_num" + item.product_category_num + "'>";
				str += "<ul>";
				
				$.each(item.productCategoryList, function(index2,item2){
					str += "<li><a href='/product/list?product_category_num=" + item2.product_category_num + "'>" + item2.product_category_name +"</a>";
				});	
					
				str += "</ul>";
				str += "</div>";
				str += "</li>";
			});
			
			str += "</ul>";
			$(".categoryListDiv ul").append(str);
			let product_category_num = $("#product_category_num").val();
			console.log(product_category_num)
			$("#product_category_num" + product_category_num).css("display","block");
			
			
			//categoryNameDiv에 항목 이름 삽입
			$(".categoryNameDiv h2").text(data.product_category_name);
			
			
			
		},
		error:function(err){
			alert(err);
		}
	}); //end ajax
	
	
	$.ajax({
		type:'post',
			url:'/product/getProductListByProductCategory',
			headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
			data: 'product_category_num=' + $("#product_category_num").val(),
			dataType:'json',
			success:function(result){
				console.log(result);
				let str = "";
	        	$.each(result, function(index, items) {
	        		console.log(items);
	        		let fileCallPath = encodeURIComponent(items.fileList[0].uploadPath + "/" +items.fileList[0].uuid + "_" + items.fileList[0].fileName);
	                //str += "<div class='thumbnail-image image-is-load'>";
	                str += "<div class='col-12 col-md-6 col-lg-3', style: 'border:none;padding:10px' >";
	                    //str += "<a href='/product/detail?product_num=" + items.product_num + "&brandCategory=" + items.brandCategory + "' class='noborder'>";    
	                    str += "<a href='/product/detail?product_num=" + items.product_num + "&brandCategory=" + items.brandCategory + "&pageNum=" + $("#pageNum").val() + "&amount=" + $("#amount").val() + "' class='noborder'>";
	                        str += "<img src='/file/display?fileName=/" +  fileCallPath  +  "' class='thumb-img'>";
	                        str += "&nbsp";
	                        str += "<div class='thumbnail-soldout'><span class='displaynone'></span></div>";

	                    str += "</a>";
	                

	                str += "<div class='thumbnail-info'>";
	                    str += "<p class='brand'>" + items.brand_name + "</p>";
	                    str += "<p class='name'>";
	                    str += "<a href='/product/detail?product_num=" + items.product_num + "&brandCategory=" + items.brandCategory + "' class='noborder'>"
	                        str += "<span style='font-size:12px;color:#555555;'>" + items.product_name + "</span>";
	                    str += "</a>";
	                    str += "</p>";
	                    str += "<div class='price'>"
	                        str += "<div>" + items.product_price + "원"; 
	                            str += "<span class='product-custom displaynone'></span>";
	                        str += "</div>";
	                            str += "<div></div>";
	                    str += "</div>";    
	                    str += "<p class='desc'></p>"
	                str += "</div>";
	                
	                str += "</div>";
				});
	        	
	        	$(".productListDiv").append(str);
			},
			error:function(err){
				alert(err);
			}
	}); //end ajax
});


</script>



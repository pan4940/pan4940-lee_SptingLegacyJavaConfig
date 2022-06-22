<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="/resources/css/brands.css" />
<script type="text/javascript" src="/resources/js/brands.js"></script>
<div id="breadDiv">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<div class="bread_container">
		
		<div id="breadImg">
			<img id="img1" src='' style="height: 100%; border: none;"></img>
		</div>

		<h4>OUR BRANDS</h4>
		
		<h3>A</h3>
		<ul id="A">
		
		</ul>

		<h3>B</h3>
		<ul id="B">
			
		</ul>

		<h3>C</h3>
		<ul id="C">
			
		</ul>

		<h3>D</h3>
		<ul id="D">
			
		</ul>

		<h3>E</h3>
		<ul id="E">
			
		</ul>

		<h3>G</h3>
		<ul id="G">
			
		</ul>

		<h3>H</h3>
		<ul id="H">
			
		</ul>

		<h3>I</h3>
		<ul id="I">
			
		</ul>

		<h3>K</h3>
		<ul id="K">
			
		</ul>

		<h3>L</h3>
		<ul id="L">
			
		</ul>

		<h3>M</h3>
		<ul id="M">
			
		</ul>

		<h3>N</h3>
		<ul id="N">
			
		</ul>

		<h3>O</h3>
		<ul id="O">
			
		</ul>

		<h3>P</h3>
		<ul id="P">
			
		</ul>

		<h3>R</h3>
		<ul id="R">
			
		</ul>

		<h3>S</h3>
		<ul id="S">
			
		</ul>

		<h3>T</h3>
		<ul id="T">
			
		</ul>

		<h3>U</h3>
		<ul id="U">
			
		</ul>

		<h3>V</h3>
		<ul id="V">
			
		</ul>

		<h3>W</h3>
		<ul id="W">
			
		</ul>


		<h3>X</h3>
		<ul id="X">
		
		</ul>


		<h3>Y</h3>
		<ul id="Y">
			
		</ul>

		<h3>Z</h3>
		<ul id="Z">
			
		</ul>

		<h3>ETC</h3>
		<ul id="ETC">
			
		</ul>
	</div>
</div>


<script>
$(document).ready(function(){
	$.ajax({
		type: 'post',
		headers: {"X-CSRF-TOKEN": $("input[name='_csrf']").val()},
		url: '/product/getBrandsCategoryList',
		dataType: 'json',
		success: function(result){
			console.log(result);
			listPart(result);
		},
	});
});

let regex = new RegExp("^[A-Z]");


function listPart(result) {
	$.each(result, function(index, item){
		console.log(item);
		let first = item.product_category_name.charAt(0);

		let str = "";
		if (!regex.test(first)) {
			str += "<li class='comma'>";
			str += "<a href='/product/list-brand?product_category_num=" + item.product_category_num + "' data-value='" + item.fileList[0].uploadPath + "/" + item.fileList[0].uuid + "_" + item.fileList[0].fileName + "'>" + item.product_category_name + "</a></li>";
			$("#ETC").append(str);
			
		} else {
			str += "<li class='comma'>";
			str += "<a href='/product/list-brand?product_category_num=" + item.product_category_num + "' data-value='" + item.fileList[0].uploadPath + "/" + item.fileList[0].uuid + "_" + item.fileList[0].fileName + "'>" + item.product_category_name + "</a></li>";
			$("#" + first).append(str);	
			str = "";	
		}
		
	});
};





</script>
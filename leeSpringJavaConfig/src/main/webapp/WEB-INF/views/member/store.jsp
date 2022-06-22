<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="storediv">
	<div id="title">
		<h4>STORES</h4>
	</div>
	<br>
	<div id="myImg2">
		<img alt="이미지" src="/resources/image/theC1.jpeg" id="imgs">
	</div>
	<div id="button">
		<a id="prv">&#10094;</a> || <a id="next">&#10095;</a>
	</div>
	<br> <br>
	<div id="ac">
		<div>
			<p>
				<b>THECSHOP ○○점</b> <br> ○○○○ ○○시 ○○구 ○○○○길 53 <br>
				000-0000-0000 <br> 11:30 ~ 21:30
			</p>
		</div>
		<div id="abc">
			<p>
				<b>THECSHOP ○○점</b> <br> ○○○○ ○○시 ○○구 ○○○○길 53 <br>
				000-0000-0000 <br> 11:30 ~ 21:30
			</p>
			<p>
				<b>THECSHOP ○○점</b> <br> ○○○○ ○○시 ○○구 ○○○○길 53 <br>
				000-0000-0000 <br> 11:30 ~ 21:30
			</p>
		</div>
	</div>
	<br> <br>
</div>



<script type="text/javascript">
	window.onload = function() {
		let myphotos = [ "/resources/image/theC1.jpeg",
				"/resources/image/theC2.jpeg", "/resources/image/theC3.jpeg",
				"/resources/image/theC4.jpeg", "/resources/image/theC5.jpeg" ]
		let index = 0;
		console.log("index : " + index);
		document.getElementById("prv").onclick = function() {
			if (index == 0) {
				index = myphotos.length;
			}
			document.getElementById("imgs").src = myphotos[--index];
		}

		document.getElementById("next").onclick = function() {
			if (++index == myphotos.length) {

				index = 0;
			}
			document.getElementById("imgs").src = myphotos[index];
		}
	}
</script>






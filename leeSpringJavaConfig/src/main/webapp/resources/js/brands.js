/*$(".bread_container ul li a").mouseover(function (event) {
	console.log(event);
	$('#img1').attr('src','');
	$('#img1').attr('src','/storage/'+event.target.innerText+'.jpg');
	$('#breadImg').css('display','block');
});
$(".bread_container ul li a").mouseleave(function () {
	$('#breadImg').css('display','none');
});*/


$(document).on("mouseover",".bread_container ul li a",function(event){
	console.log(event.target.getAttribute('data-value'));
	$('#img1').attr('src','');
	$('#img1').attr('src', '/file/display?fileName=' + event.target.getAttribute('data-value'));
	$('#breadImg').css('display','block');
});

/*<img src="/file/display?
fileName=/C%3A%2Fthec%2Fbrands%2F2022%2F05%2F07%2F03525319-8eb5-483e-874e-81cda6b46975_1.jpg">*/
$(document).on("mouseleave",".bread_container ul li a",function(){
	$('#breadImg').css('display','none');
});





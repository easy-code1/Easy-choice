<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#slide{
  width:1895px;
  height:370px;
  margin:auto;
  overflow:hidden;
}
#slide #imgAll {
  width:10000px;
  height:370px;
}
section{
  width:1100px;
  margin:auto;
  background:white;
}
section > div{
  width:1000px;
  height:400px;
  margin:auto;
  border:2px solid black;
}
</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(function(){
	setInterval(function(){
		$("#imgAll").animate({
			marginLeft:"-1895px"
		},2000,function(){
			$(".img").eq(0).insertAfter($(".img").eq(3));
			$("#imgAll").css("marginLeft","0px");
		});
	},4000);
});
</script>
</head>
<body>
<div id="slide">
  <div id="imgAll">
    <img src="../static/s1.png" class="img" width="1895" height="370"><img src="../static/s2.jpg" class="img" width="1895" height="370"><img src="../static/s3.jpg" class="img" width="1895" height="370"><img src="../static/s4.jpg" class="img" width="1895" height="370">
  </div>
</div>
<section>
  <div class="sang"></div>
  <div class="sang"></div>
  <div class="sang"></div>
</section>

</body>
</html>
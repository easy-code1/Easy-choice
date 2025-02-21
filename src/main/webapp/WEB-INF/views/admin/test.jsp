<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#viewform{
  position:absolute;
  left:0px;
  top:30px;
  width:100px;
  visibility:hidden;
  padding-left:0px;
}
</style>
<script>
function view(){
	document.getElementById("viewform").style.visibility="visible";
}
function hide(){
	document.getElementById("viewform").style.visibility="hidden";
}
</script>
</head>
<body>
<ul style="margin:auto;width:200px;padding-left:0px;">
  <li style="position:relative;" onmouseover="view()" onmouseout="hide()">가전제품
  <ul id="viewform">
    <li>TV</li>
    <li>냉장고</li>
    <li>세탁기</li>
    <li>컴퓨터</li>
    <li>청소기</li>
  </ul>
  </li>
</ul>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
      margin:0px;
    }
    #aa {
      width:100%;
      height:40px;
      background:red;
    }
</style>
<script>
h=40;
function hide(){
	ss=setInterval(function(){
		h--;
		document.getElementById("aa").style.height=h+"px";
		if(h==0){
			clearInterval(ss);
		}
	},10);
}
</script>
</head>
<body>
<div id="aa">안녕하세요<span onclick="hide()">X</span></div>
</body>
</html>
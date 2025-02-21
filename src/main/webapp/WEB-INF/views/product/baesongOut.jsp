<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
document.write("<p align='center'><b>로그아웃 된거 같습니다<br><a href='javascript:login()'>로그인</a></b></p>");
setTimeout(function(){
	opener.location="../main/main";
	close();
},3000);
function login(){
	opener.location="../login/login";
	close();
}
</script>
</head>
<body>

</body>
</html>
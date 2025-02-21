<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.baesong {
 width:480px;
 height:165px;
 margin:auto;
 border:1px solid green;
 margin-top:4px;
}
.baesong > div {
 margin-top:4px;
 margin-left:4px;
}
.baesong > div:last-child {
 text-align:center
}
.baesong #selBtn{
 width:80px;
 height:27px;
 background:white;
 border:1px solid green;
 color:green;
}
.baesong #selBtn2{
 width:80px;
 height:27px;
 background:green;
 border:1px solid green;
 color:white;
}
.baesong #gibon {
 border:1px solid green;
 padding:3px;
 border-radius:8px;
}
#last {
 width:482px;
 height:40px;
 margin:auto;
 margin-top:6px;
}
#last #btn {
 width:482px;
 height:40px;
 background:white;
 border:1px solid green;
 color:green;
 font-size:17px;
}
</style>
<script>
function jusoJundal(n){
	opener.document.getElementById("name").innerText=document.getElementsByClassName("name")[n].innerText;
	opener.document.getElementById("juso").innerText=document.getElementsByClassName("juso")[n].innerText;
	opener.document.getElementById("phone").innerText=document.getElementsByClassName("phone")[n].innerText;
	opener.document.getElementById("reqStr").innerText=document.getElementsByClassName("reqStr")[n].innerText;
	opener.document.getElementById("baeId").value=document.getElementsByClassName("id")[n].value;
	close();
}

</script>
</head>
<body>
  <c:forEach items="${blist}" var="bdto" varStatus="sts">
    <div class="baesong">
      <input type="hidden" class="id" value="${bdto.id}">
      <div class="name">${bdto.name}</div>
      <div class="juso">${bdto.juso} ${bdto.jusoEtc}</div>
      <div class="phone">${bdto.phone}</div>
      <div class="reqStr">${bdto.reqStr}</div>
      <c:if test="${bdto.gibon==1}">
        <div><span id="gibon">기본배송지</span></div>
      </c:if>
      <div>
        <input type="button" id="selBtn" value="수정" onclick="location='baesongUpdate?id=${bdto.id}'">
        <input type="button" id="selBtn2" value="삭제" onclick="location='baesongDelete?id=${bdto.id}'">
        <input type="button" id="selBtn" value="선택" onclick="jusoJundal(${sts.index})">
      </div>
    </div>
  </c:forEach>
  <div id="last"><input type="button" id="btn" value="배송지추가" onclick="location='baesongWrite'"></div>
</body>
</html>
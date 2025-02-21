<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
section{
  width:1100px;
  height:600px;
  margin:auto;
}
section form > div {
  text-align:center;
  margin-top:30px;
}
section #title{
  width:600px;
  height:30px;
}
section #content{
  width:600px;
  height:250px;
}
section #submit{
  width:606px;
  height:34px;
}
</style>
<script>
function chgStar(n){
	var star=document.getElementsByClassName("star");
	for(i=0;i<n;i++){
		star[i].src="../static/star1.png";
	}
	for(i=n;i<star.length;i++){
		star[i].src="../static/star2.png";
	}
	document.rform.star.value=n;
}
window.onpageshow=function(){
	var len=${rdto.star};
	var star=document.getElementsByClassName("star");
	   
	for(i=0;i<len;i++){
		star[i].src="../static/star1.png";
	}	   
}
</script>
</head>
<body>
<section>
  <form name="rform" method="post" action="reviewUpdateOk">
    <input type="hidden" name="id" value="${rdto.id}">
    <input type="hidden" name="pcode" value="${rdto.pcode}">
    <input type="hidden" name="star">
    <h3 align="center">상품평 쓰기</h3>
    <div>
      <%-- <c:forEach begin="1" end="${rdto.star}" varStatus="sts">
        <img src="../static/star1.png" onclick="chgStar(${sts.index})" class="star">
      </c:forEach>
      <c:forEach begin="${rdto.star+1}" end="5" varStatus="sts">
        <img src="../static/star2.png" onclick="chgStar(${sts.index})" class="star">
      </c:forEach> --%>
      
      <c:forEach begin="1" end="5" varStatus="sts">
        <img src="../static/star2.png" onclick="chgStar(${sts.index})" class="star">
      </c:forEach>
      
    </div>
    <div>
      <input type="text" name="title" id="title" value="${rdto.title}" placeholder="한줄 제목 입력">
    </div>
    <div>
      <textarea name="content" id="content" placeholder="상품평 내용">${rdto.content}</textarea>
    </div>
    <div>
      <input type="submit" id="submit" value="상품평 쓰기">
    </div>
  </form>
</section>
</body>
</html>
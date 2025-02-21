<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
section{
  width:1100px;
  margin:auto;
}
section #outline{
  border:1px solid #444444;
  border-radius:10px;
  padding:3px;
  font-size:12px;
}
section #halinDiv{
  font-size:12px;
}
section #halinDiv s{
  color:#cccccc;
}
section #halinPriceDiv{
  font-size:17px;
  color:red;
}
section > table{
  border-spacing:10px;
}
section > table tr td{
  border:2px solid white;
  vertical-align:top;
}
section > table tr td:hover{
  border:2px solid #cccccc;
}
section > table tr td div:first-child{
  text-align:center;
}
section > table tr td div{
  margin-top:5px;
} 
@keyframes pkc{
  0%{transform:scale(1,1);}
  100%{transform:scale(1.2,1.2);}
}
@keyframes pkc2{
  0%{transform:scale(1.2,1.2);}
  100%{transform:scale(1,1);}
}
section table tr:last-child td {
  border:none;
}
section table tr:last-child td a{
  text-decoration:none;
  color:black;
  width:30px;
  height:25px;
  display:inline-block;
  padding-top:5px;
}
section table tr:last-child td a:hover{
   background:#005ae0;
   color:white;
}
section #orderList {
  text-align:right;
  margin-top:20px;
  margin-bottom:20px;
}
section #orderList a {
  text-decoration:none;
  color:black;
  font-size:12px;
}
section #orderList a:hover {
  background:#005ae0;
  color:white;
}
section #menuList{
  margin-top:40px;
}
</style>
<script>
function exOut(my){
	my.style.animationName="pkc2";
    my.style.animationDuration="0.5s";
    my.style.animationFillMode="forwards";
}
function exOver(my){
	my.style.animationName="pkc";
    my.style.animationDuration="0.5s";
    my.style.animationFillMode="forwards";
}
window.onpageshow=function(){
	document.getElementsByClassName("order")[${order-1}].style.color="red";
}
</script>
</head>
<body>
<section>
<div id="menuList">
${menuList}
</div>
<div id="orderList">
  <a href="productList?pcode=${pcode}&order=1" class="order">판매량순 | </a>
  <a href="productList?pcode=${pcode}&order=2" class="order">가격높은순 | </a>
  <a href="productList?pcode=${pcode}&order=3" class="order">가격낮은순 | </a>
  <a href="productList?pcode=${pcode}&order=4" class="order">최신상품순 | </a>
  <a href="productList?pcode=${pcode}&order=5" class="order">별점높은순 </a>
</div>
<table align="center" width="1100">
  <tr>
  <c:forEach items="${plist}" var="pdto" varStatus="sts">
    <td onclick="location='productContent?pcode=${pdto.pcode}'">
      <div><img src="../static/product/${pdto.pimg}" width="250" height="250" onmouseover="exOver(this)" onmouseout="exOut(this)"></div>
      <c:if test="${pdto.baeprice==0}">
        <div>무료배송</div>
      </c:if>
      <div>${pdto.title}</div>
      <c:if test="${pdto.halin!=0}">
        <div id="halinDiv">${pdto.halin}% <s>${pdto.priceStr}원</s></div>
      </c:if>
      <div id="halinPriceDiv">${pdto.halinPriceStr}원</div>
      <div>${pdto.baedayStr}</div>
      <div style="letter-spacing:-5px;"> 
        <c:forEach begin="1" end="${pdto.ystar}">
          <img src="../static/star1.png" width="10">
        </c:forEach>
        <c:forEach begin="1" end="${pdto.hstar}">
          <img src="../static/star3.png" width="10">
        </c:forEach>
        <c:forEach begin="1" end="${pdto.gstar}">
          <img src="../static/star2.png" width="10">
        </c:forEach>
      </div>
      <div>
      <c:if test="${pdto.juk!=0}">
        <span id="outline">
          <img src="../static/juk.png" width="17" valign="middle">
          최대 ${pdto.jukPriceStr}원 적립
        </span>
      </c:if>
      </div>
    </td>
    <td>
    <!-- jstl format 이용 -->
      <c:if test="false">
        <fmt:formatNumber value="${pdto.price}" type="number" pattern="#,###"/>
        <fmt:formatNumber value="${pdto.price-(pdto.price*pdto.halin/100)}" type="number" pattern="#,###"/>
        <fmt:formatNumber value="${pdto.price*pdto.juk/100}" type="number" pattern="#,###"/>
      </c:if>
    </td>
  <c:if test="${sts.count%4==0}">
    </tr>
    <tr>
  </c:if>
  </c:forEach>
  <tr>
    <td colspan="8" align="center">
      <c:if test="${pstart==1}">
        ◁◁
      </c:if>    
      <c:if test="${pstart!=1}">
        <a href="productList?pcode=${pcode}&page=${pstart-1}">◁◁</a>
      </c:if>
      <c:if test="${page==1}">
        ◁
      </c:if>    
      <c:if test="${page!=1}">
        <a href="productList?pcode=${pcode}&page=${page-1}">◁</a>
      </c:if>
      <c:forEach var="i" begin="${pstart}" end="${pend}">
        <c:if test="${page!=i}">
          <a href="productList?pcode=${pcode}&page=${i}">${i}</a>
        </c:if>
        <c:if test="${page==i}">
          <a href="productList?pcode=${pcode}&page=${i}" style="color:red;">${i}</a>
        </c:if>
      </c:forEach>
      <c:if test="${page!=chong}">
        <a href="productList?pcode=${pcode}&page=${page+1}">▷</a>
      </c:if>
      <c:if test="${page==chong}">
        ▷
      </c:if>
      <c:if test="${pend!=chong}">
        <a href="productList?pcode=${pcode}&page=${pend+1}">▷▷</a>
      </c:if>
      <c:if test="${pend==chong}">
        ▷▷
      </c:if>
    </td>
  </tr>
</table>
</section>
</body>
</html>
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

}
section .pform{
  display:none;
}
section .tdPay{
  width:1100px;
  height:150px;
  border:1px solid #005ae0;
}
section .pay{
  display:none;
}
</style>
<script>
function addBaesong(){
	open("baesongWrite","","width=400,height=500");
}
function chgBaesong(){
	open("baesongList","","width=400,height=500");
}
window.onpageshow=function(){
	document.getElementsByClassName("pform")[0].style.display="block";
	document.getElementsByClassName("pay")[0].style.display="block";
	document.getElementsByClassName("pay")[1].style.display="block";
	document.getElementsByClassName("tdPay")[1].style.height="35px";	
}
function chgPay(n){
	var pform=document.getElementsByClassName("pform");
	for(i=0;i<pform.length;i++){
		pform[i].style.display="none";
	}
	pform[n].style.display="block";
}
var payChk=0;
function viewHide(){
	var pay=document.getElementsByClassName("pay");
	if(payChk%2==0){
		for(i=2;i<pay.length;i++){
			pay[i].style.display="block";
		}
		document.getElementById("arrow").innerText="▲";
	}
	else{
		for(i=2;i<pay.length;i++){
			pay[i].style.display="none";
		}
		document.getElementById("arrow").innerText="▼";
	}
	payChk++;
	
}
var myJuk=${mdto.juk};
function calJuk(my){
	if(isNaN(my.value) || my.value.length==0){
		alert("숫자를 입력하세요");
		my.value="0";
		document.getElementById("dtoJuk").innerText=comma(myJuk);
	}
	else{
		if(my.value>myJuk){
			my.value="0";
		}
		else{
			var result=myJuk-parseInt(my.value);
			document.getElementById("dtoJuk").innerText=comma(result);
			var oriChongPrice=document.getElementById("oriChongPrice").value;
			document.getElementById("chongPrice").innerText=comma(oriChongPrice-my.value);
		}
		
	}
	
}
function comma(price) // 숫자나 문자를 둘다 처리할 수 있다..
{
	return new Intl.NumberFormat().format(price); 
}
function check(){
	var id=document.getElementById("baeId").value;
	if(id.length==0){
		alert("배송지를 선택하세요");
		return false;
	}
	else{
		return true;
	}
}
</script> 
</head>
<body>
<section>
<form method="post" action="gumaeOk" onsubmit="return check()">
<input type="hidden" name="baeId" id="baeId" value="${bdto.id}">
<table width="1100" align="center">
  <caption><h3 align="left">구매자 정보</h3></caption>
  <tr>
    <td width="140">이 름</td>
    <td>${mdto.name}</td>
  </tr>
  <tr>
    <td>이메일</td>
    <td>${mdto.email}</td>
  </tr>
  <tr>
    <td>전화번호</td>
    <td>${mdto.phone}</td>
  </tr>
</table>
<table width="1100" align="center">
  <caption>
    <h3 align="left">
      배송지 정보
      <c:if test="${bdto!=null}">
        <input type="button" value="배송지변경" onclick="chgBaesong()">
      </c:if>
      <c:if test="${bdto==null}">
        <input type="button" value="배송지등록" onclick="addBaesong()">
      </c:if>
    </h3>
  </caption>
  <tr>
    <td width="140">이 름</td>
    <td id="name">${bdto.name}</td>
  </tr>
  <tr>
    <td>배송주소</td>
    <td id="juso">${bdto.juso} ${bdto.jusoEtc}</td>
  </tr>
  <tr>
    <td>연락처</td>
    <td id="phone">${bdto.phone}</td>
  </tr>
  <tr>
    <td>배송요청사항</td>
    <td id="reqStr">${bdto.reqStr}</td>
  </tr>
</table>
<table width="1100" align="center">
  <caption><h3 align="left">배송상품</h3></caption>
  <c:set var="price" value="0"/>
  <c:set var="baeprice" value="0"/>
  <c:set var="imsiPcode" value=""/>
  <c:set var="imsiSu" value=""/>
  <c:forEach items="${plist}" var="pdto">
  <c:set var="price" value="${price+pdto.price*pdto.su}"/>
  <c:set var="baeprice" value="${baeprice+pdto.baeprice}"/>
  <c:set var="imsiPcode" value="${imsiPcode}${pdto.pcode}/"/>
  <c:set var="imsiSu" value="${imsiSu}${pdto.su}/"/>
  <tr>
    <td colspan="2">${pdto.baedayStr}</td>
  </tr>
  <tr>
    <td width="500">${pdto.title}</td>
    <td>
      ${pdto.su}개 / 
      <c:if test="${pdto.baeprice==0}">
        무료배송
      </c:if>
      <c:if test="${pdto.baeprice!=0}">
        <fmt:formatNumber value="${pdto.baeprice}" type="number" pattern="#,###"/>원
      </c:if>
    </td>
  </tr>
  </c:forEach>
  <input type="hidden" name="pcode" value="${imsiPcode}">
  <input type="hidden" name="sus" value="${imsiSu}">
  <input type="hidden" id="oriChongPrice" value="${price+baeprice}">
</table>
<table width="1100" align="center">
  <caption><h3 align="left">결제 정보</h3></caption>
  <tr>
    <td width="140">총상품가격</td>
    <td><fmt:formatNumber value="${price}" type="number" pattern="#,###"/>원</td>
  </tr>
  <tr>
    <td>할인쿠폰</td>
    <td>0원</td>
  </tr>
  <tr>
    <td>배송비</td>
    <td><fmt:formatNumber value="${baeprice}" type="number" pattern="#,###"/>원</td>
  </tr>
  <tr>
    <td>적립금 사용</td>
    <td><input type="text" name="useJuk" value="0" size="4" style="text-align:right" onblur="calJuk(this)">원 사용 ||
      보유: <span id="dtoJuk"><fmt:formatNumber value="${mdto.juk}" type="number" pattern="#,###"/></span>원
    </td>
  </tr>
  <tr>
    <td>총결제금액</td>
    <td><span id="chongPrice"><fmt:formatNumber value="${baeprice+price}" type="number" pattern="#,###"/></span>원</td>
  </tr>
</table>
<table width="1100" align="center">
  <caption><h3 align="left">결제수단</h3></caption>
  <tr>
    <td class="tdPay">
      <div class="pay">
        <input type="radio" name="pay" value="0" onclick="chgPay(this.value)" checked>신용/체크카드
        <div class="pform">
          <select name="card1">
            <option value="0">신한카드</option>
            <option value="1">우리카드</option>
            <option value="2">농협카드</option>
            <option value="3">KB카드</option>
          </select>
          <select name="halbu1">
            <option value="0">일시불</option>
            <option value="1">2개월</option>
            <option value="2">3개월</option>
            <option value="3">6개월</option>
            <option value="4">12개월</option>            
          </select>
        </div>
      </div>
      <div class="pay">
        <input type="radio" name="pay" value="1" onclick="chgPay(this.value)">컬리페이
        <div class="pform">
          0원
        </div>
      </div>
    </td>
  </tr>
  <tr>
    <td class="tdPay">    
      <div onclick="viewHide()">다른 결제 수단<span id="arrow">▼</span></div>
      <div class="pay">  
        <input type="radio" name="pay" value="2" onclick="chgPay(this.value)">계좌이체
        <div class="pform">
          <select name="bank1">
            <option value="0">신한은행</option>
            <option value="1">우리은행</option>
            <option value="2">농협은행</option>
            <option value="3">KB은행</option>
          </select>
        </div>
      </div>
      <div class="pay">
        <input type="radio" name="pay" value="3" onclick="chgPay(this.value)">법인카드
        <div class="pform">
          <select name="card2">
            <option value="0">신한카드</option>
            <option value="1">우리카드</option>
            <option value="2">농협카드</option>
            <option value="3">KB카드</option>
          </select>
        </div>
      </div>
      <div class="pay">
        <input type="radio" name="pay" value="4" onclick="chgPay(this.value)">휴대폰
        <div class="pform">
          <select name="tel">
            <option value="0">SKT</option>
            <option value="1">KT</option>
            <option value="2">LG</option>
            <option value="3">알뜰통신</option>
          </select>
        </div>
      </div>
      <div class="pay">
        <input type="radio" name="pay" value="5" onclick="chgPay(this.value)">무통장입금
        <div class="pform">
          <select name="bank2">
            <option value="0">신한은행</option>
            <option value="1">우리은행</option>
            <option value="2">농협은행</option>
            <option value="3">KB은행</option>
          </select>
        </div>
      </div>
    </td>
  </tr>
</table>
<div align="center"><input type="submit" value="구매하기"></div>
</form>
</section>
</body>
</html>
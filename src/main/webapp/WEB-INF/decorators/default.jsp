<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body{
  margin:0px;
}
#fouter{
  width:100%;
  height:40px;
  background:#005ae0;
}
#fouter #xx{
  cursor:pointer;
}
#fouter #first{
  width:1100px;
  height:40px;
  margin:auto;
  background:#005ae0;
}
#fouter #first #left{
  display:inline-block;
  width:1000px;
  height:40px;
  line-height:40px;
  text-align:center;
  color:white;
}
#fouter #first #right{
  display:inline-block;
  width:80px;
  height:40px;
  line-height:40px;
  text-align:right;
  color:white;
}
header{
  width:1100px;
  height:70px;
  margin:auto;
}
header #myMain{
  position:relative;
}
header #mySub{
  position:absolute;
  left:-18px;
  top:0px;
  padding-left:0px;
  background:white;
  visibility:hidden;
}
header #mySub > li{
  list-style-type:none;
  width:100px;
  height:30px;
  line-height:30px;
  text-align:center;
  border:1px solid #005ae0;
  border-bottom:none;
}
header #mySub > li:last-child{
  border-bottom:1px solid #005ae0;
}
header a{
  text-decoration:none;
  color:black;
}
header #logo{
  width:300px;
  height:80px;
  display:inline-block;
  line-height:70px;
}
header #search{
  width:440px;
  height:80px;
  display:inline-block;
  line-height:70px;
}
header #search #searchForm{
  width:350px;
  height:44px;
  border:1px solid black;
  line-height:44px;
  border-radius:10px;
}
header #search #searchForm input[type=text]{
  border:none;
  outline:none;
  width:270px;
  margin-left:10px;

}
header #memMenu{
  width:330px;
  height:90px;
  display:inline-block;
  line-height:80px;
}
header #xpng{
  visibility:hidden;
}
header #cartNum{
  color:white;
  background:#005ae0;
  padding:0px 4px 0px 3px;
  border-radius:10px;
}
nav{
  width:1100px;
  height:60px;
  margin:auto;
}
nav > ul{
  padding-left:0px;
}
nav > ul > li{
  display:inline-block;
  width:150px;
  height:50px;
  line-height:50px;
}
nav > ul > li:first-child{
  width:250px;
}
nav > ul > li:last-child{
  width:220px;
  text-align:right;
}
nav #category{
  position:relative;
  width:100px;
  height:26px;
  line-height:26px;
  text-align:center;
  display:inline-block;
  z-index:100;
}
nav #category #daeMenu{
  position:absolute;
  left:0px;
  top:26px;
  padding-left:0px;
  border:1px solid #005ae0;
  background:white;
  visibility:hidden;
}
nav #category #daeMenu > li{
  list-style-type:none;
  width:100px;
  height:26px;
  line-height:26px;
  text-align:center;
  position:relative;
}
nav #category #daeMenu > li .jungMenu{
  position:absolute;
  left:100px;
  top:0px;
  padding-left:0px;
  border:1px solid #005ae0;
  background:white;
  visibility:hidden;
}
nav #category #daeMenu > li .jungMenu > li{
  list-style-type:none;
  width:100px;
  height:26px;
  line-height:26px;
  text-align:center;
  position:relative;
}
nav #category #daeMenu > li .jungMenu > li > .soMenu{
  position:absolute;
  left:100px;
  top:0px;
  padding-left:0px;
  border:1px solid #005ae0;
  background:white;
  visibility:hidden;
}
nav #category #daeMenu > li .jungMenu > li > .soMenu > li{
  list-style-type:none;
  width:100px;
  height:26px;
  line-height:26px;
  text-align:center;
}
nav a{
  text-decoration:none;
  color:black;
}
footer{
  width:1100px;
  height:150px;
  margin:auto;
  background:#005ae0;
}
</style>
<script>
var h=40;
function fclose(){
	ss=setInterval(function(){
		h--;
		document.getElementById("fouter").style.height=h+"px";
		document.getElementById("first").style.height=h+"px";
		
		if(h==0){
			clearInterval(ss);
			document.getElementById("fouter").style.display="none";
		}
	},10);
	
	var chk=new XMLHttpRequest();
	chk.onload=function(){
		if(chk.responseText=="0"){
			alert("오류");
		}
	}
	chk.open("get","../firstCookie");
	chk.send();
}
window.onload=function(){
	var chk=new XMLHttpRequest();
	chk.onload=function(){
		if(chk.responseText=="1"){
			document.getElementById("fouter").style.display="none";
		}
	}
	chk.open("get","../fcookOk");
	chk.send();
	getNum();
}
function chgX(val){
	if(val.length==0){
		document.getElementById("xpng").style.visibility="hidden";
	}
	else{
		document.getElementById("xpng").style.visibility="visible";
	}
}
function hideTxt(){
	document.getElementById("sword").value="";
}
var daeChk=0;
function viewDae(){
	document.getElementById("daeMenu").style.visibility="visible";
	if(daeChk==0){
		var chk=new XMLHttpRequest();
		chk.onload=function(){
			var daes=JSON.parse(chk.responseText);
			var str="";
			for(dae of daes){
				str+="<li onmouseover='viewJung("+dae.code+")' onmouseout='hideJung("+dae.code+")'><a href='../product/productList?pcode=p"+dae.code+"'>"+dae.name+"</a><ul class='jungMenu'></ul></li>";
			}
			document.getElementById("daeMenu").innerHTML=str;
			daeChk=1;
		}
		chk.open("get","../getDae");
		chk.send();
	}
}
function hideDae(){
	document.getElementById("daeMenu").style.visibility="hidden";
}
var jungChk=[0,0,0,0,0,0,0];
function viewJung(daecode){
	document.getElementsByClassName("jungMenu")[daecode-1].style.visibility="visible";
	if(jungChk[daecode-1]==0){
		var chk=new XMLHttpRequest();
		chk.onload=function(){
			var jungs=JSON.parse(chk.responseText);
			var str="";
			for(jung of jungs){
				str+="<li onmouseover='viewSo("+daecode+jung.code+",this)' onmouseout='hideSo(this)'><a href='../product/productList?pcode=p"+jung.daecode+jung.code+"'>"+jung.name+"</a><ul class='soMenu'></ul></li>";
			}
			document.getElementsByClassName("jungMenu")[daecode-1].innerHTML=str;
			jungChk[daecode-1]=1;
		}
		chk.open("get","../getJung?daecode="+daecode);
		chk.send();
	}
}
function hideJung(daecode){
	document.getElementsByClassName("jungMenu")[daecode-1].style.visibility="hidden";
}
function viewSo(daejung,my){
	my.childNodes[1].style.visibility="visible";
	if(my.childNodes[1].innerHTML==""){
		var chk=new XMLHttpRequest();
		chk.onload=function(){
			var sos=JSON.parse(chk.responseText);
			var str="";
			for(so of sos){
				str+="<li><a href='../product/productList?pcode=p"+so.daejung+so.code+"'>"+so.name+"</a></li>";
			}
			my.childNodes[1].innerHTML=str;
		}
		chk.open("get","../getSo?daejung="+daejung);
		chk.send();
	}
	
}
function hideSo(my){
	my.childNodes[1].style.visibility="hidden";
}
function getNum(){
	var chk=new XMLHttpRequest();
	chk.onload=function(){
		document.getElementById("cartNum").innerText=chk.responseText;
	}
	chk.open("get","../getCartNum");
	chk.send();
}
function viewMy(){
	document.getElementById("mySub").style.visibility="visible";
}
function hideMy(){
	document.getElementById("mySub").style.visibility="hidden";
}
</script>
<sitemesh:write property="head" />
</head>
<body>
<div id="fouter">
  <div id="first">
    <div id="left">회원가입하고 50%할인 쿠폰 드립니다</div>
    <div id="right"><span id="xx" onclick="fclose()">X</span></div>
  </div>
</div>
<header>
  <div id="logo"><img src="../static/logo2.png" width="120" valign="middle" onclick="location='../main/main'"></div>
  <div id="search">
    <div id="searchForm">
      <input type="text" name="sword" id="sword" placeholder="검색어를 입력하세요" onkeyup="chgX(this.value)">
      <img src="../static/x.png" valign="middle" id="xpng" onclick="hideTxt()">
      <img src="../static/search2.png" valign="middle" width="25">
    </div>
  </div>
  <div id="memMenu">
    <a href="../member/cartView">장바구니(<span id="cartNum"></span>)</a> |
   <c:if test="${userid==null}">
    <a href="../login/login">로그인</a> |
    <a href="../member/member">회원가입</a> |
   </c:if>
   <c:if test="${userid!=null}">
    <span id="myMain" onmouseover="viewMy()" onmouseout="hideMy()">${name}님
      <ul id="mySub">
        <li><a href="../member/jjimList">찜리스트</a></li>
        <li><a href="../member/memberInfo">회원정보</a></li>
        <li><a href="../member/jumunList">주문내역</a></li>
        <li><a href="../member/baesongList">배송지정보</a></li>
      </ul>
    </span> |
    <a href="../login/logout">로그아웃</a> |
   </c:if>
    고객센터
  </div>
</header>
<nav>
  <ul id="mainMenu">
    <li> 
      <span id="category" onmouseover="viewDae()" onmouseout="hideDae()">카테고리
        <ul id="daeMenu">
        
        </ul>
      </span>
    </li>
    <li> 신상품 </li>
    <li> 베스트 </li>
    <li> 알뜰쇼핑 </li>
    <li> 특가/혜택 </li>
    <li> 샛별하루배송 </li>
  </ul>
</nav>
<sitemesh:write property="body" />
<footer></footer>
</body>
</html>
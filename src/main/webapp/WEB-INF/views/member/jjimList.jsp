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
section table {
 margin-top:40px;
 margin-bottom:40px;
 border-spacing:0px;
}
section table tr td {
 height:110px;
 border-bottom:1px solid #005ae0;
}
section table tr:first-child td {
 height:60px;
}
section table tr:nth-child(2) td {
 border-top:2px solid #005ae0;
}
section table tr:last-child td {
 border-bottom:2px solid #005ae0;
}
</style>
<script>
function jjimDel(){
	var subChk=document.getElementsByClassName("subChk");
	var ids="";
	for(i=0;i<subChk.length;i++){
		if(subChk[i].checked){
			ids+=subChk[i].value+",";
		}
	}
	location="jjimDel?ids="+ids;
}
function mainCheck(my){
	var subChk=document.getElementsByClassName("subChk");
	if(my.checked){
		for(i=0;i<subChk.length;i++){
			subChk[i].checked=true;
		}
	}
	else{
		for(i=0;i<subChk.length;i++){
			subChk[i].checked=false;
		}
	}
}
function subCheck(){
	var subChk=document.getElementsByClassName("subChk");
	var chk=0;
	for(i=0;i<subChk.length;i++){
		if(subChk[i].checked){
			chk++;
		}
	}
	if(chk==subChk.length){
		document.getElementById("mainChk").checked=true;
	}
	else{
		document.getElementById("mainChk").checked=false;
	}
}
function addCart(pcode){
	var chk=new XMLHttpRequest();
	chk.onload=function(){
		if(chk.responseText=="0"){
			location="../login/login";
		}
		else{
			document.getElementById("cartNum").innerText=chk.responseText;
		}
	}
	chk.open("get","addCart?pcode="+pcode);
	chk.send();
}
</script>
</head>
<body>
<section>
  <table width="1100" align="center">
    <caption><h3>찜 리스트</h3></caption>
    <tr>
      <td colspan="4">
        <input type="checkbox" id="mainChk" onclick="mainCheck(this)">전체선택 <input type="button" value="선택삭제" onclick="jjimDel()">
      </td>
    </tr>
    <c:forEach items="${plist}" var="pdto">
      <tr>
        <td width="40"> <input type="checkbox" class="subChk" value="${pdto.id}" onclick="subCheck()"> </td>
        <td width="150"><img src="../static/product/${pdto.pimg}" width="100" height="100"></td>
        <td>
          <c:if test="${baeprice==0}">
            무료배송
          </c:if>
          <c:if test="${baeprice!=0}">
            <fmt:formatNumber value="${pdto.baeprice}" type="number" pattern="#,###"/>원
          </c:if>
          <br>${pdto.title}<br>
          <fmt:formatNumber value="${pdto.price}" type="number" pattern="#,###"/>원
        </td>
        <td width="150">
          <input type="button" value="장바구니 담기" onclick="addCart('${pdto.pcode}')">
          <input type="button" value="삭제" onclick="location='jjimDel?ids=${pdto.id}'">
        </td>
      </tr>
    </c:forEach>
  </table>
</section>
</body>
</html>
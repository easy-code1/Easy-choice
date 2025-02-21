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
       position:relative;
    }
    section table {
       border-spacing:0px;
    }
    section  table tr td {
       height:60px;
       border-bottom:1px solid black;
       padding-top:6px;
       padding-bottom:6px;
    }
    section table tr:first-child td {
       border-top:2px solid black;
       height:40px;
    }
    section table tr:last-child td {
       border-bottom:2px solid black;
    }
    section #calendar{
       position:absolute;
       left:400px;
       top:100px;
    }
    section #calendar #mainTable {
       background:white;
       border-spacing:0px;
    }
    section #calendar #mainTable caption {
       background:white;
       border:1px solid black;
       height:28px;
       padding-top:3px;
    }
    section #calendar #mainTable tr td {
       width:24px;
       height:24px;
       border:1px solid black;
       background:white;
       padding:2px;
       text-align:center;
    }
    section #calendar  #mainTable  tr td:hover {
       background:#005ae0;
       color:white;
    }
    section input[type=button] {
       border:1px solid black;
       background:white;
       vertical-align:middle;
       border-radius:3px;
    }
    section input[type=button]:hover {
       background:#005ae0;
       color:white;
    }
    section input[type=text] {
       border:1px solid black;
       width:90px;
       height:18px;
       text-align:center;
       padding-bottom:1px;
       border-radius:3px;
    }
    
</style>
<script>
function makeCal(y,m,n){
	if(y==-1){
		var today=new Date();
		y=today.getFullYear();
		m=today.getMonth(); //0~11
	}
	if(m==-1){
		y--;
		m=11;
	}
	if(m==12){
		y++;
		m=0;
	}
	var xday=new Date(y,m,1);
	var yoil=xday.getDay(); // 0~6(일~토)
	var nums=[31,28,31,30,31,30,31,31,30,31,30,31];
	var chong=nums[m];
	if(m==1){ // 윤년인 경우 2월 총 일수
		if( (y%4==0 && y%100!=0) || y%400==0 ){
			chong++;
		}
	}
	var ju=Math.ceil((chong+yoil)/7);
	var calData="<table align='center' border='0' id='mainTable'>";
	calData+="<caption>";
	calData+="<a href='javascript:makeCal("+y+","+(m-1)+","+n+")'>이전 </a>";
	calData+=y+"년 "+(m+1)+"월 ";
	calData+="<a href='javascript:makeCal("+y+","+(m+1)+","+n+")'>다음</a>";
	calData+="</caption>";
	calData+"<tr>";
	calData+="<td>일</td>";
	calData+="<td>월</td>";
	calData+="<td>화</td>";
	calData+="<td>수</td>";
	calData+="<td>목</td>";
	calData+="<td>금</td>";
	calData+="<td>토</td>";
	calData+="</tr>";
	
	var day=1;
	for(i=0;i<ju;i++){
		calData+="<tr>";
		for(j=0;j<7;j++){
			if((i==0 && j<yoil) || day>chong){
				calData+="<td>&nbsp;</td>";
			}
			else{
				calData+="<td onclick='nalJaSend("+n+","+y+","+m+","+day+")'>"+day+"</td>";
				day++;
			}
		}
		calData+="</tr>";
	}
	calData+="</table>";
	document.getElementById("calendar").innerHTML=calData;
	if(n==1){
		document.getElementById("calendar").style.left="600px";
	}
	else{
		document.getElementById("calendar").style.left="400px";
	}
	event.stopPropagation();
}
function nalJaSend(n,y,m,d){
	m++;
	m=m+"";
	m=m.padStart(2,"0");
	d=d+"";
	d=d.padStart(2,"0");
	var nalJa=y+"-"+m+"-"+d;
	var nal=document.getElementsByClassName("nalJa");
	if(n==0){
		if(nal[1].value!="" && nalJa>nal[1].value){
			alert("최종일이 더 빠릅니다");
		}
		else{
			nal[n].value=nalJa;
		}
	}
	else if(n==1){
		if(nal[0].value!="" && nalJa<nal[0].value){
			alert("최종일이 더 빠릅니다");
		}
		else{
			nal[n].value=nalJa;
		}
	}
	document.getElementById("calendar").innerHTML="";
}
function gigan(){
	var start=document.getElementsByClassName("nalJa")[0].value;
	var end=document.getElementsByClassName("nalJa")[1].value;
	location="jumunList?start="+start+"&end="+end;
}
window.onclick=function(){
	document.getElementById("calendar").innerHTML="";
}
</script>
</head>
<body>
<section>
<div id="calendar"></div>
<table width="1100" align="center">
  <caption>
    <h3 align="left">주문 목록</h3>
    <div id="search" align="center" style="height:40px;line-height:40px;">
      <input type="button" value="3개월" onclick="location='jumunList?month=3'">
      <input type="button" value="6개월" onclick="location='jumunList?month=6'">
      <input type="button" value="12개월" onclick="location='jumunList?month=12'">
      <input type="text" name="start" placeholder="시작일" value="${start}" onclick="makeCal(-1,-1,0)" class="nalJa">
      <input type="text" name="end" placeholder="최종일" value="${end}" onclick="makeCal(-1,-1,1)" class="nalJa">  
      <input type="button" value="기간검색" onclick="gigan()">    
    </div>
  </caption>
  <c:forEach items="${mapAll}" var="map">
    <c:set var="dis" value=""/>
    <tr>
      <td><img src="../static/product/${map.pimg}" width="40" height="40"></td>
      <td>${map.title}</td>
      <td>${map.name}</td>
      <td>${map.writeday}</td>
      <td>${map.stateStr}</td>
      <td>
        <c:if test="${map.state==0 || map.state==1}">
          <input type="button" value="취소신청" onclick="location='chgState?state=2&id=${map.id}'">
        </c:if>        
        <c:if test="${map.state==5}">
          <input type="button" value="반품신청" onclick="location='chgState?state=6&id=${map.id}'">
          <input type="button" value="교환신청" onclick="location='chgState?state=8&id=${map.id}'">
          <c:if test="${map.review==1}">
            <c:set var="dis" value="disabled"/>
          </c:if>
          <input type="button" value="상품평쓰기" ${dis} onclick="location='review?id=${map.id}&pcode=${map.pcode}'">
        </c:if>
        <c:if test="${map.state==2}">
          <input type="button" value="신청취소" onclick="location='chgState?state=0&id=${map.id}'">
        </c:if>
        <c:if test="${map.state==6 || map.state==8}">
          <input type="button" value="신청취소" onclick="location='chgState?state=5&id=${map.id}'">
        </c:if>
      </td>
    </tr>
  </c:forEach>
</table>
</section>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
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
    section #chuga {
       font-size:15px;
       font-weight:500;
       color:red;
    }
 </style>
 <script>
 function baesongUpdate(id){
	 window.open("../product/baesongUpdate?ck=1&id="+id,"","width=520,height=600");
 }
 function baeChuga()
 {
	 open("baesongWrite","","width=520,height=600");
 }
 </script>
</head>
<body>
<section>
  <table width="1100" align="center">
    <caption><h3>배송지 정보 <span id="chuga" onclick="baeChuga()">배송지 추가</span></h3></caption>
    <tr align="center">
      <td>받는사람</td>
      <td>받는주소</td>
      <td>전화번호</td>
      <td>요청사항</td>
      <td>기본배송지</td>
      <td>수정/삭제</td>
    </tr>
    <c:forEach items="${blist}" var="bdto">
      <tr align="center">
        <td>${bdto.name}</td>
        <td align="left">${bdto.juso} ${bdto.jusoEtc}</td>
        <td>${bdto.phone}</td>
        <td>${bdto.reqStr}</td>
        <td>
          <c:if test="${bdto.gibon==1}">
            O
          </c:if>
          <c:if test="${bdto.gibon==0}">
            X
          </c:if>
        </td>
        <td>
          <input type="button" value="수정" onclick="baesongUpdate(${bdto.id})">
          <input type="button" value="삭제" onclick="location='../product/baesongDelete?ck=1&id=${bdto.id}'">
        </td>
      </tr>
    </c:forEach>
  </table>
</section>
</body>
</html>
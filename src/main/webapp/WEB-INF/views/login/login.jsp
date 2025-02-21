<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
    section {
       width:1100px;
       height:700px;
       margin:auto;
       text-align:center;
    }
    section div {
       margin-top:10px;
    }
    section #txt {
       width:420px;
       height:42px;
    }
    section #submit {
       width:427px;
       height:46px;
       background:#005ae0;
       color:white;
    }
    section #txt2 {
       width:200px;
       height:30px;
    }
    section #submit2 {
       width:208px;
       height:33px;
       background:#005ae0;
       color:white;
    }
    section #uform{
      display:none;
    }
    section #pform{
      display:none;
    }
    section .sear{
      cursor:pointer;
    }
 </style>
<script>
function viewUform(){
	document.getElementById("uform").style.display="block";
	document.getElementById("pform").style.display="none";
	document.getElementById("pform").userid.value="";
	document.getElementById("pform").name.value="";
	document.getElementById("pform").email.value="";
}
function viewPform(){
	document.getElementById("pform").style.display="block";
	document.getElementById("uform").style.display="none";
	document.getElementById("uform").name.value="";
	document.getElementById("uform").email.value="";
	
}
function getUserid(my){
	var chk=new XMLHttpRequest();
	chk.onload=function(){
		my.style.display="none";
		my.name.value="";
		my.email.value="";
		document.getElementById("view").innerText="아이디: "+chk.responseText;
	}
	chk.open("get","getUserid?name="+my.name.value+"&email="+my.email.value);
	chk.send();
}
function getPwd(my){
	var chk=new XMLHttpRequest();
	chk.onload=function(){
		my.style.display="none";
		my.name.value="";
		my.userid.value="";
		my.email.value="";
		document.getElementById("view").innerText="비밀번호: "+chk.responseText;
	}
	chk.open("get","getPwd?userid="+my.userid.value+"&name="+my.name.value+"&email="+my.email.value);
	chk.send();
}
</script>
</head>
<body> <!-- login.jsp -->
  <section> 
    <h3 align="center"> 로그인 </h3>
    <form method="post" action="loginOk">
    <input type="hidden" name="pcode" value="${pcode}">
    <c:if test="${su!=null}">
      <input type="hidden" name="su" value="${su}">
    </c:if>
    <c:if test="${cart!=null}">
      <input type="hidden" name="cart" value="${cart}">
    </c:if>
      <div> <input type="text" name="userid" id="txt" placeholder="아이디"> </div>
      <div> 
        <input type="password" name="pwd" id="txt" placeholder="비밀번호"> 
        <c:if test="${err==1}"><br><span style="color:red;font-size:12px;">아이디 또는 비밀번호가 틀렸습니다</span></c:if>
      </div>
      <div> <input type="submit" value="로그인" id="submit"> </div>
      <div>
        <span class="sear" onclick="viewUform()">아이디 찾기</span> &nbsp;&nbsp;&nbsp;
        <span class="sear" onclick="viewPform()">비밀번호 찾기</span>
      </div>
    </form>
    <div id="view"></div>
    <form id="uform">
      <h4>아이디 찾기</h4>
      <div><input type="text" name="name" id="txt2" placeholder="이 름"></div>
      <div><input type="text" name="email" id="txt2" placeholder="이 메 일"></div>
      <div><input type="button" value="아이디 찾기" id="submit2" onclick="getUserid(this.form)"></div>
    </form>  
    
    <form id="pform">
      <h4>비밀번호 찾기</h4>
      <div><input type="text" name="userid" id="txt2" placeholder="아이디"></div>
      <div><input type="text" name="name" id="txt2" placeholder="이 름"></div>
      <div><input type="text" name="email" id="txt2" placeholder="이 메 일"></div>
      <div><input type="button" value="비밀번호 찾기" id="submit2" onclick="getPwd(this.form)"></div>
    </form>  
  </section>
</body>
</html>
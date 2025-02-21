<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
section{
  width:1100px;
  height:500px;
  margin:auto;
  text-align:center;
}
section div{
  margin-top:10px;
}
section #txt{
  width:420px;
  height:42px;
}
section .email{
  width:130px;
  height:42px;
}
section #select{
  width:132px;
  height:47px;
}
section #submit{
  width:427px;
  height:46px;
  background:#005ae0;
  color:white;
}
section #umsg {
  font-size:12px;   
}
section #pmsg {
  font-size:12px;   
}
</style>
<script>
var uchk=0;
var pchk=0;
function useridCheck(userid){
	if(userid.length >= 6){
		var chk=new XMLHttpRequest();
		chk.onload=function(){
			if(chk.responseText==0){
				document.getElementById("umsg").innerText="사용가능한 아이디입니다";
				document.getElementById("umsg").style.color="green";
				uchk=1;
			}
			else{
				document.getElementById("umsg").innerText="사용불가능한 아이디입니다";
				document.getElementById("umsg").style.color="red";
				uchk=0;
				
			}
		}
		chk.open("get","useridCheck?userid="+userid);
		chk.send();
	}
	else{
		document.getElementById("umsg").innerText="아이디의 길이는 6자 이상입니다";
		document.getElementById("umsg").style.color="red";
		uchk=0;
	}
}
function check(){
	document.mform.email.value=document.mform.uid.value+"@"+document.mform.server.value;
	var name=document.mform.name.value.length;
	var phone=document.mform.phone.value.length;
	if(uchk==1 && pchk==1 && name!=0 && phone!=0){
		return true;
	}
	else{
		return false;
	}
}
function pwdCheck(pwd2){
	var pwd=document.mform.pwd.value;
	var pwd2=document.mform.pwd2.value;
	if(pwd2.length!=0){
		if(pwd==pwd2){
			document.getElementById("pmsg").innerText="비밀번호가 일치합니다";
			document.getElementById("pmsg").style.color="green";
			pchk=1;
		}
		else{
			document.getElementById("pmsg").innerText="비밀번호가 일치하지 않습니다";
			document.getElementById("pmsg").style.color="red";
			pchk=0;
		}
	}
	
}
function getServer(dserver){
	document.mform.server.value=dserver.value;
}
</script>
</head>
<body>
<section>
  <div>
    <form name="mform" method="post" action="memberOk" onsubmit="return check()">
      <input type="hidden" name="email">
      <h3>회원 등록</h3>
      <div><input type="text" name="userid" id="txt" placeholder="아이디(6자 이상)" onblur="useridCheck(this.value)">
           <br><span id="umsg"></span>
      </div>
      <div><input type="text" name="name" id="txt" placeholder="이 름"></div>
      <div><input type="password" name="pwd" id="txt" placeholder="비밀번호" onkeyup="pwdCheck()"></div>
      <div><input type="password" name="pwd2" id="txt" placeholder="비밀번호 확인" onkeyup="pwdCheck()">
           <br><span id="pmsg"></span>
      </div>
      <div>
        <input type="text" name="uid" class="email">@<input type="text" name="server" class="email">
        <select name="dserver" id="select" onchange="getServer(this)">
        <option value="">직접입력</option>
        <option value="naver.com">naver.com</option>
        <option value="daum.net">daum.net</option>
        <option value="hotmail.com">hotmail.com</option>
        </select>
      </div>
      <div><input type="text" name="phone" id="txt" placeholder="전화번호"></div>
      <div><input type="submit" value="회원 가입" id="submit"></div>
    </form>
  </div>
</section>
</body>
</html>
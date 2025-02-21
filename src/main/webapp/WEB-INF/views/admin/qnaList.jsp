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
       height:80px;
       border-bottom:1px solid black;
       padding-top:6px;
       padding-bottom:6px;
    }
    section table tr:first-child td {
       border-top:2px solid black;
    }
    section table tr:last-child td {
       border-bottom:2px solid black;
    }
    section #modal {
       display: none;   
       position:fixed;
       left:0px;
       top:0px;
       width:100%;
       height:100%;
       background-color:rgba(0,0,0,0.6);
    }
    section #qnaForm {
       width:300px;
       height:300px;
       border:1px solid black;
       background:white;
       position:fixed;
       left:300px;
       top:200px;
       visibility:hidden;
    }
    section #qnaForm form > div {
       text-align:center;
       margin-top:8px;
    }
    section #qnaForm form > div input[type=submit] {
       width:286px;
       height:30px;
    }
    section #qnaForm form > div textarea {
       width:280px;
       height:220px;
    }
    section #qnaForm #ptitle {
       border:none;
       outline:none;
       width:96%;
       text-align:center;
       overflow:hidden;
       height:40px;
       font-weight:900;
       resize:none;
    }
</style>
<script>
   function answer(id,pcode)
   {
	   var w=window.innerWidth;
	   var h=window.innerHeight;
	   
	   w=w/2;
	   h=h/2;
	   
	   w=w-150;
	   h=h-200;
	   
	   document.getElementById("qnaForm").style.left=w+"px";
	   document.getElementById("qnaForm").style.top=h+"px";
	   
	   document.getElementById("qnaForm").style.visibility="visible";
	   
	   document.getElementById("modal").style.display="block";
	   document.getElementById("ref").value=id;
	   document.getElementById("pcode").value=pcode;
   }
</script>
</head>
<body>
<section>
  <h3 align="center">상품 문의 리스트</h3>
  <table width="1100" align="center">
    <c:forEach items="${qlist}" var="qdto">
      <c:if test="${qdto.qna==1}">
      <tr>
        <td>
          <c:if test="${qdto.ref!=0}">
            답변완료
          </c:if>
          <c:if test="${qdto.ref==0}">
            <a href="javascript:answer(${qdto.id},'${qdto.pcode}')">답변 전</a>
          </c:if>
        </td>
        <td>${qdto.userid}</td>
        <td>${qdto.content}</td>
        <td>${qdto.writeday}</td>
      </tr>
      </c:if>
    </c:forEach>
  </table>
  <div id="modal"> 
  <div id="qnaForm">
    <form method="post" action="qnaAnswer">
      <input type="hidden" name="pcode" id="pcode">
      <input type="hidden" name="ref" id="ref">
      <div> <textarea name="content" id="qnaContent" maxlength="200"></textarea> </div>
      <div> <input type="submit" value="답변저장"> </div>
    </form>
  </div>
</div>
</section>
</body>
</html>
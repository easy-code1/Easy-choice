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
	#slide{
  		width:1895px;
  		height:370px;
  		margin:auto;
  		overflow:hidden;
	}
	#slide #imgAll {
  		width:10000px;
  		height:370px;
	}
 	section{
  		width:1100px;
  		margin:auto;
  		background:white;
	}
	section .sang {
       	width:1100px;
       	border-bottom:2px solid #005ae0;
       	margin:auto;
       	margin-top:80px;
    }
    section  table {
    	border-spacing:20px;
    }
    section .sang table tr td {
      	border:2px solid white;
      	vertical-align:top;
      	width:250px;
    }
    section .sang table tr td:hover {
      	border:2px solid #005ae0;
    }
    section .sang  table tr td div:first-child {
      	text-align:center;
      	overflow:hidden;
      	width:250px;
      	height:250px;
    }
    section .sang  table tr td div {
      	margin-top:4px;
    }
   	@keyframes pkc {
      	0% { transform:scale(1,1); }
	  	100% { transform:scale(1.2,1.2); }
   	}
   	@keyframes pkc2 {
      	0% { transform:scale(1.2,1.2); }
	  	100% { transform:scale(1,1); }
   	}
</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(function(){
	setInterval(function(){
		$("#imgAll").animate({
			marginLeft:"-1895px"
		},2000,function(){
			$(".img").eq(0).insertAfter($(".img").eq(3));
			$("#imgAll").css("marginLeft","0px");
		});
	},4000);
});
function exOut(my)
{
	   my.style.animationName="pkc2";
	   my.style.animationDuration="0.5s";
	   my.style.animationFillMode="forwards";
}
function exOver(my)
{
	   my.style.animationName="pkc";
	   my.style.animationDuration="0.5s";
	   my.style.animationFillMode="forwards";
}
</script>
</head>
<body>
<div id="slide">
  <div id="imgAll">
    <img src="../static/s1.png" class="img" width="1895" height="370"><img src="../static/s2.jpg" class="img" width="1895" height="370"><img src="../static/s3.jpg" class="img" width="1895" height="370"><img src="../static/s4.jpg" class="img" width="1895" height="370">
  </div>
</div>
<section>
  <div class="sang"><table align="center" width="1100">
          <caption> <h2> 최신 상품 </h2> </caption>
          <tr>
		   	 <c:forEach items="${plist1}" var="pdto" varStatus="sts">
		     <td onclick="location='../product/productContent?pcode=${pdto.pcode}'"> 
		          
		       <div> <img src="../static/product/${pdto.pimg}" onmouseover="exOver(this)" onmouseout="exOut(this)" width="200" height="200"> </div>
		      <c:if test="${pdto.baeprice==0}"> 
		       <div> 무료 배송 </div>
		      </c:if>
		       <div> ${pdto.title} </div>
		      <c:if test="${pdto.halin != 0}"> <!-- 할인율, 원래상품금액 -->
		       <div id="halinDiv"> ${pdto.halin}% <s>${pdto.priceStr}</s> </div>
		      </c:if>
		       <div id="halinPriceDiv"> ${pdto.halinPriceStr}원 </div>
		       <div> ${pdto.baedayStr} </div>
		       <div style="letter-spacing:-3px;"> 
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
		        <c:if test="${pdto.juk != 0}">
		         <span id="outline" style="border:1px solid #444444;padding:3px;border-radius:10px;font-size:12px;">
		          <img src="../static/juk.png" width="17" valign="middle">
		          최대 ${pdto.jukPriceStr}원 적립
		         </span>
		        </c:if> 
		       </div>
		     </td>
		   <c:if test="${sts.count%4==0}">
		     </tr>
		   </c:if> 
 
		   
		  </c:forEach>
		</table>
	  </div> <!-- 최신상품 -->
	  
	  
      <div class="sang">
        <table align="center" width="1100">
          <caption> <h2> 인기 상품 </h2> </caption>
          <tr>
		   	 <c:forEach items="${plist2}" var="pdto" varStatus="sts">
		     <td onclick="location='../product/productContent?pcode=${pdto.pcode}'"> 
		          
		       <div> <img src="../static/product/${pdto.pimg}" onmouseover="exOver(this)" onmouseout="exOut(this)" width="200" height="200"> </div>
		      <c:if test="${pdto.baeprice==0}"> 
		       <div> 무료 배송 </div>
		      </c:if>
		       <div> ${pdto.title} </div>
		      <c:if test="${pdto.halin != 0}"> <!-- 할인율, 원래상품금액 -->
		       <div id="halinDiv"> ${pdto.halin}% <s>${pdto.priceStr}</s> </div>
		      </c:if>
		       <div id="halinPriceDiv"> ${pdto.halinPriceStr}원 </div>
		       <div> ${pdto.baedayStr} </div>
		       <div style="letter-spacing:-3px;"> 
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
		        <c:if test="${pdto.juk != 0}">
		         <span id="outline" style="border:1px solid #444444;padding:3px;border-radius:10px;font-size:12px;">
		          <img src="../static/juk.png" width="17" valign="middle">
		          최대 ${pdto.jukPriceStr}원 적립
		         </span>
		        </c:if> 
		       </div>
		     </td>
		   <c:if test="${sts.count%4==0}">
		     </tr>
		   </c:if> 
 
		   
		  </c:forEach>
        </table>
      </div>
      
      
      <div class="sang">
         <table align="center" width="1100">
           <caption> <h2> 리뷰 높은 순</h2> </caption>
          <tr>
		   	 <c:forEach items="${plist3}" var="pdto" varStatus="sts">
		     <td onclick="location='../product/productContent?pcode=${pdto.pcode}'"> 
		          
		       <div> <img src="../static/product/${pdto.pimg}" onmouseover="exOver(this)" onmouseout="exOut(this)" width="200" height="200"> </div>
		      <c:if test="${pdto.baeprice==0}"> 
		       <div> 무료 배송 </div>
		      </c:if>
		       <div> ${pdto.title} </div>
		      <c:if test="${pdto.halin != 0}"> <!-- 할인율, 원래상품금액 -->
		       <div id="halinDiv"> ${pdto.halin}% <s>${pdto.priceStr}</s> </div>
		      </c:if>
		       <div id="halinPriceDiv"> ${pdto.halinPriceStr}원 </div>
		       <div> ${pdto.baedayStr} </div>
		       <div style="letter-spacing:-3px;"> 
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
		        <c:if test="${pdto.juk != 0}">
		         <span id="outline" style="border:1px solid #444444;padding:3px;border-radius:10px;font-size:12px;">
		          <img src="../static/juk.png" width="17" valign="middle">
		          최대 ${pdto.jukPriceStr}원 적립
		         </span>
		        </c:if> 
		       </div>
		     </td>
		   <c:if test="${sts.count%4==0}">
		     </tr>
		   </c:if> 
  
		  </c:forEach>
		</table>
	</div>
</section>

</body>
</html>
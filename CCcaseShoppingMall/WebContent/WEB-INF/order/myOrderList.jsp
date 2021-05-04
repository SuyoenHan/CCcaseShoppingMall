<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
    
<%
	String ctxPath = request.getContextPath();
%>


<jsp:include page="../header.jsp" />
<jsp:include page="../mypageleftSide.jsp" />    


<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="<%=ctxPath%>/css/style.css" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
  
<style>

	div#dateGroup{
		background-color: #a6a6a6;
		color:
	}
	
	 div#myOrderList{
		background-color: #ccffee;
	}

</style>

<script type="text/javascript">



	$(document).ready(function(){
		
		//배송조회 버튼 클릭
		$("button.shipstatusBtn").click(function(){
			
			//alert("배송조회");
			//배송조회 페이지로 이동 시켜준다.
			location.href="<%=ctxPath%>/order/shipStatus.cc";
			
		});
		
		
		//상품평관리 클릭
		$("button.productReviewBtn").click(function(){
			
			//하나의 상품(내가 클릭한 곳)리뷰 다는 곳으로 이동 시켜준다.
			location.href="<%=ctxPath%>/board/reviewList.cc";
			
		});
		
		
		
	});

</script>
  
  
  
</head>
<body>

<div id="contents">
<form name ="orderListFrm" action="<%=ctxPath %>/order/myOrderList.cc" >
	<div class="container">
	  <h2><span name="userid" id= "userid">${sessionScope.loginuser.userid}</span><span>님 주문내역 조회</span></h2>
	  <p>-- 배송상태 (0 입금대기 / 1 입금완료 / 2 배송중 / 3 배송완료 / 4 구매확정 / 5 교환  6 환불)</p>            
	  <table class="table table-hover">
	    
	    <thead>
	      <div id="dateGroup" name="dateGroup"> -----구매날짜 ${ovo.orderdate}-----</div>
	      <tr>
	        <th>상품정보</th>
	        <th>주문일자</th>
	        <th>주문번호</th>
	        <th>주문금액</th>
	        <th>주문수량</th>
	        <th>주문상태</th>
	      </tr>
	    </thead>
	    <tbody>
	    <c:forEach var="ovo" items="${requestScope.orderList}">
		      <tr>
		        <td>
		        	<span><img src="/CCcaseShoppingMall/images/product/${ovo.pvo.pimage1}" name="pimage1"id="pimage1"style="width:55px; height:55px; float:left"/></span>
		        	<span id="productname" name="productname">${ovo.pvo.productname}-${ovo.pdvo.pcolor}</span><br>
		        	<span id="modelname" name="modelname">옵션:${ovo.pvo.modelname}</span>
		        </td>	
		        <td id="orderdate" name="orderdate">주문일자 ${ovo.orderdate}</td>
		        <td id="orderno" name="orderno">주문번호:${ovo.orderno}</td>
		        <td id="totalPrice" name="totalPrice">주문금액${ovo.totalPrice}원</td>
		        <td id="odqty" name="odqty">주문수량 ${ovo.odvo.odqty} 개</td>
		        <td>
		       
		        	 <c:if test="${ovo.shipstatus==0}">   
			        	<span>입금대기</span><br>
		        	 </c:if> 
		        	 <c:if test="${ovo.shipstatus==1}"> 
			        	<span>입금완료</span><br>
		        	 </c:if>
		        
		        	 <c:if test="${ovo.shipstatus==2}"> 
			        	<span id="shipstatus" name="shipstatus">주문상태:배송중</span><br>
			        	<button type="button" class="shipstatusBtn" name="shipstatusBtn" >배송조회</button>
		        	 </c:if> 
		        	 <c:if test="${ovo.shipstatus==3}"> 
			        	<span>배송완료</span><br>
		        	 </c:if> 
		        	 <c:if test="${ovo.shipstatus==4}"> 
			        	<span id="shipstatus" name="shipstatus">주문상태:구매확정 </span><br>
			        	<button type="button" class="productReviewBtn" name="productReviewBtn">상품평관리</button>
		        	 </c:if> 
		        	 <c:if test="${ovo.shipstatus==5}"> 
			        	<span>교환</span><br>
		        	 </c:if> 
		        	 <c:if test="${ovo.shipstatus==6}"> 
			        	<span>환불</span><br>
		        	 </c:if> 
		        	 
		        </td>
		      </tr>
	      </c:forEach>
	    </tbody>
	  </table>
	</div>
</form>	
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath= request.getContextPath();
%>

<jsp:include page="../header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문/결제</title>

<style type="text/css">

.order-content {
	width: 100%;
	height: auto;
	background-color: #f9f9f9;
	padding-bottom: 200px;
   	margin-bottom: -200px;
}

.order-header {
    align-items: center;
    padding: 100px 0 50px;
}

.orderInfo {
	position: relative;
	width: 100%;
	height: auto;
	margin: 0 auto;
}

.orderSec-left {
	padding-right: 45%;
	padding-left: 2%;
}

.orderSec-right {
	position: fixed;
	top: 40%;
	left: 55%;
    width: 50%;
}

.left-section-delivery-info {
	width: auto;
}

.left-section {
	margin: 0px 0px 10px;
	padding: 80px;
	background-color: white;
}

.delivery-condition {
	position: relative;
	padding-bottom: 40px;
}

.delivery-condition-name {
	display: flex;
	justify-content: space-between;
}

.delivery-condition-info {
	margin: 0;
	padding: 0;
	list-style: none;
	display: block;
}

.delivery-request {
	margin: 25px 0 20px;
}

.btn-request {
	display: flex;
	align-items: center;
	justify-content: space-between;
	flex-direction: row;
	width: 100%;
	padding: 13px 12px 11px;
	text-align: left;
	background-color: #f9f9f9;
}

.btn-change-addr {
	position: absolute;
	top: 0;
	right: 0;
}

.left-section-btn {
    padding: 8px 9px 6px 8px;
    border: 1px solid rgb(221, 221, 221);
    background: rgb(255, 255, 255);
    cursor: pointer;
}

.delivery-user {
	position: relative;
    padding: 0 0 30px;
    border-bottom: 1px solid #ececec;
}

.delivery-user-info {
	margin: 0;
	padding: 0;
	list-style: none;
}

.info-type {
	display: inline-block;
	width: 50px;
	margin-right: 10px;
    font-size: 13px;
    font-weight: normal;
    color: #999;
}

.info-value {
    font-weight: normal;
    color: #555;
}

.btn-change-order {
	position: absolute;
    top: 40px;
    right: 0;
    padding: 8px 9px 6px 8px;
    border: 1px solid #ddd;
}

.section-order-info {
	width: auto;
}

.order-prod-list {
    margin: 0;
    padding: 0;
    border-bottom: 1px solid #111;
    list-style: none;
}

.order-prod-info {
	display: flex;
    justify-content: flex-start;
    align-items: center;
    flex-direction: row;
    padding: 40px 0 40px 20px;
    border-top: 1px solid #ececec;
}

.order-prod-img-a {
	width: 80px;
    display: block;
    position: relative;
    overflow: hidden;
    padding-top: 106px;
}

.order-prod-img-span {
    display: block;
    position: absolute;
    inset: 0px;
    transform: translate(50%, 50%);
}

.order-prod-img-span > img {
    max-width: 100%;
    max-height: 100%;
    width: 100%;
    height: auto;
    object-fit: contain;
    position: absolute;
    top: 0px;
    left: 0px;
    transform: translate(-50%, -50%);
}

.order-prod-text {
	display: flex;
	width: 100%;
    justify-content: flex-start;
    align-items: flex-start;
    flex-direction: column;
    margin-left: 25px;
}

.prod-name {
	margin: 0 0 10px;
    width: 100%;
    overflow: hidden;
    text-overflow: ellipsis;
    line-height: 1.6;
    text-decoration: none;
}

.order-price-text {
    margin: 0;
    padding-top: 25px;
    display: flex;
    justify-content: flex-start;
    align-items: flex-end;
    flex-direction: column;
}

.price-unit {
	margin-left: 3px;
}

.section-payment-info {
	width: auto;
}

.section-payment-info-title {
	border-bottom: 1px solid #ececec;
	padding-bottom: 20px;
}

.payment-type-list {
	padding: 20px 0;
	margin: 0;
	list-style: none;
}

.right-section-info {
	max-width: 634px;
	width: auto;
	margin: 0;
	margin-right: 70px;
}

.right-section-price-info {
	background-color: white;
	position: relative;
	margin-right: 70px;
	padding: 80px;
}

.expected-price-list {
	padding: 20px 0;
	margin: 0;
	list-style: none;
}

.expected-price-item {
	margin: 0;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.total-expected-price {
    margin-top: 20px;
    margin-bottom: 100px;
    padding-top: 20px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-top: 1px solid #ececec;
}

.btn-order {
	width: 100%;
	position: absolute;
	bottom: 0;
	left: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 80px;
	background: rgb(17, 17, 17);
	border: none;
}


</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

	$(document).ready(function(){

		$("span.error").hide();  
		
	    
	    $("input#hp2").blur(function(){
	       
	          var regExp = /^[1-9][0-9]{3}$/i; 
	          // 첫번째 숫자는 0을 제외하고 나머지 3개는 0을 포함한 숫자만 오도록 검사해주는 정규표현식 객체 생성  
	       
	          var bool = regExp.test($(this).val());
	          
	          if(!bool) {
	             // 국번이 정규표현식에 위배된 경우
	             $("table#tblMemberRegister :input").prop("disabled",true);
	             $(this).prop("disabled",false);
	          
	             $(this).parent().find(".error").show();
	             $(this).focus();
	          }
	          else {
	             // 국번이 정규표현식에 맞는 경우
	             $("table#tblMemberRegister :input").prop("disabled",false);
	             $(this).parent().find(".error").hide();
	          }
	          
	       }); // 아이디가 hp2 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.   
	       
	       
	       $("input#hp3").blur(function(){
	          
	          var regExp = /^\d{4}$/i; 
	          // 숫자 4개만 오도록 검사해주는 정규표현식 객체 생성  
	       
	          var bool = regExp.test($(this).val());
	          
	          if(!bool) {
	             // 마지막 전화번호 4자리가 정규표현식에 위배된 경우
	             $("table#tblMemberRegister :input").prop("disabled",true);
	             $(this).prop("disabled",false);
	          
	             $(this).parent().find(".error").show();
	             $(this).focus();
	          }
	          else {
	             // 마지막 전화번호 4자리가 정규표현식에 맞는 경우
	             $("table#tblMemberRegister :input").prop("disabled",false);
	             $(this).parent().find(".error").hide();
	          }
	          
	       }); // 아이디가 hp3 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.      
	    
	       
	    $("img#zipcodeSearch").click(function(){
	       new daum.Postcode({
	             oncomplete: function(data) {
	                 // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                 var addr = ''; // 주소 변수
	                 var extraAddr = ''; // 참고항목 변수

	                 //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                 if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                     addr = data.roadAddress;
	                 } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                     addr = data.jibunAddress;
	                 }

	                 // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                 if(data.userSelectedType === 'R'){
	                     // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                     // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                     if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                         extraAddr += data.bname;
	                     }
	                     // 건물명이 있고, 공동주택일 경우 추가한다.
	                     if(data.buildingName !== '' && data.apartment === 'Y'){
	                         extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                     }
	                     // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                     if(extraAddr !== ''){
	                         extraAddr = ' (' + extraAddr + ')';
	                     }
	                     // 조합된 참고항목을 해당 필드에 넣는다.
	                     document.getElementById("extraAddress").value = extraAddr;
	                 
	                 } else {
	                     document.getElementById("extraAddress").value = '';
	                 }

	                 // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                 document.getElementById('postcode').value = data.zonecode;
	                 document.getElementById("address").value = addr;
	                 // 커서를 상세주소 필드로 이동한다.
	                 document.getElementById("detailAddress").focus();
	             }
	         }).open();
	    });   
	});
	
	
	$(window).on("scroll", function() {
		var scrollNow = window.scrollY;
	
	    if(scrollNow > 900) {
	        $(".orderSec-right").css('position', 'absolute');
	        $(".orderSec-right").css('top', '30%');
	    } else {
	       $(".orderSec-right").css('position', 'fixed');
	       $(".orderSec-right").css('top', '30%');
	    }
	});
	
	var prodIdList = new Array();
	
	$(function(){
		IMP.init('imp59232554');
		
		var productIdList = document.getElementsByClassName("productId");
		for (var i = 0; i < productIdList.length; i++) {
			prodIdList.push(productIdList.item(i).value*1);
		}
	});
	
	 // 새로운 주소 선택시에만 새로운 주소 입력칸 보여주기
	 function setDisplay(){
		 
		$(".newDelAddr").hide();
		
	    if($("input:radio[id=delAddr]").is(":checked")){
	        $(".newDelAddr").hide();
	        $(".origin-delAddr").show();
	    }	
	    
	    if($("input:radio[id=newDelAddr]").is(":checked")){
	    	$(".origin-delAddr").hide();
	        $(".newDelAddr").show();
	    }
		
	}// end of function setDisplay()--------------------------------------


</script>
</head>
<body>

<div class="order-content">

<c:set var="prodPriceAll" value="0" />

	<div class="order-header">
		<h3>주문/결제</h3>
	</div>

	<!-- 하단박스 시작 -->
	<div class="orderInfo">
		<!-- 하단좌측박스 시작 -->
		<div class="orderSec-left">
			<!-- 상품 정보 시작 -->
			<div class="section-order-info left-section">
				<h3>배송 상품</h3>
				<table class="table table-hover">
					<thead>
					      <tr>
					        <th>상품정보</th>
					        <th>주문금액</th>
					        <th>주문수량</th>
					      </tr>
					</thead>
					<tbody>
					    <c:forEach var="ovo" items="${requestScope.orderList}">
							<tr>
						        <td>
						        	<span><img src="/CCcaseShoppingMall/images/product/${ovo.pvo.pimage1}" name="pimage1"id="pimage1"style="width:55px; height:55px; float:left"/></span>
						        	<span id="productname" name="productname">${ovo.pvo.productname}</span>&nbsp;&nbsp;<span id="pcolor" name="pcolor">${ovo.pdvo.pcolor}</span><br>
						        	<span id="modelname" name="modelname">옵션:${ovo.pvo.modelname}</span>
						        </td>	
						        <td id="totalPrice" name="totalPrice">주문금액${ovo.totalPrice}원</td>
						        <td id="odqty" name="odqty">${ovo.odvo.odqty}</td>
						    </tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="order-price-text">
					<p>
						상품
						<span class="price-unit"><fmt:formatNumber value="${prodPriceAll}" type="number" />원</span>
						+ 배송비
						<span class="price-unit">0원</span>
					</p>
					<strong>
						합계
						<span><fmt:formatNumber value="${prodPriceAll}" type="number" />원</span>
					</strong>
				</div>
			</div>
			<!-- 상품 정보 끝 -->
			<!-- 배송/주문자 정보 시작 -->
			<div class="delivery-info left-section">
				<div class="delivery-user">
					<h3>주문자 정보</h3>
					<ul class="delivery-user-info">
						<li>
							<span class="info-type">이름</span>
							<strong class="info-value">${sessionScope.loginuser.name}</strong>
						</li>
						<li>
							<span class="info-type">연락처</span>
							<strong class="info-value">${sessionScope.loginuser.mobile}</strong>
						</li>
						<li>
							<span class="info-type">이메일</span>
							<strong class="info-value">${sessionScope.loginuser.email}</strong>
						</li>
					</ul>
				</div>
				<h3>배송 정보</h3>
				<div class="delivery-condition">
				<!-- 등록된 배송지/새로운 배송지 중에 선택 
					   등록된 배송지:회원정보 배송지, 새로운 배송지:새로 입력한 주소-->
					 <div>
		        		<input type="radio" id="delAddr" name="delAddr" checked="checked" onclick="setDisplay()">
		 				<label for="delAddr">등록된 배송지</label>&nbsp;&nbsp;
		 				<input type="radio" id="newDelAddr" name="delAddr" onclick="setDisplay()">
		 				<label for="newDelAddr">새로운 배송지</label>
		        	</div>
		        	<!-- 기존배송지 -->
		        	<div class="origin-delAddr">
					<div class="delivery-condition-name">
						<h3 id="name">${sessionScope.loginuser.name}</h3>
					</div>
					<ul class="delivery-condition-info">
						<li>${sessionScope.loginuser.address}</li>
						<li>${sessionScope.loginuser.mobile}</li>
					</ul>
					</div>
					<!-- 새로운 배송지 -->
					<div class="newDelAddr" style="display: none;">
						<div class="delivery-condition-info">
						<table>
							  <tr>
							  	<td style="width: 20%; font-weight: bold;">수령인 이름</td>
							  	<td style="width: 80%; text-align: left;"><input type="text" name="name" id="name" /></td>
							  </tr>
						      <tr>
						         <td style="width: 20%; font-weight: bold;">우편번호</td>
						         <td style="width: 80%; text-align: left;">
						            <input type="text" id="postcode" name="postcode" size="6" maxlength="5" />&nbsp;&nbsp;
						            <%-- 우편번호 찾기 --%>
						            <img id="zipcodeSearch" src="<%= ctxPath %>/images/member/b_zipcode.gif" style="vertical-align: middle;" />
						            <span class="error">우편번호 형식이 아닙니다.</span>
						         </td>
						      </tr>
						      <tr>
						         <td style="width: 20%; font-weight: bold;">주소</td>
						         <td style="width: 80%; text-align: left;">
						            <input type="text" id="address" name="address" size="40" placeholder="주소" /><br><br>
						            <input type="text" id="detailAddress" name="detailAddress" size="40" placeholder="상세주소" />&nbsp;<input type="text" id="extraAddress" name="extraAddress" size="40" placeholder="참고항목" /> 
						            <span class="error">주소를 입력하세요</span>
						         </td>
						      </tr>
						      <tr>
						         <td style="width: 20%; font-weight: bold;">연락처</td>
						         <td style="width: 80%; text-align: left;">
						             <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
						             <input type="text" id="hp2" name="hp2" size="6" maxlength="4" />&nbsp;-&nbsp;
						             <input type="text" id="hp3" name="hp3" size="6" maxlength="4" />
						             <span class="error">휴대폰 형식이 아닙니다.</span>
						         </td>
						      </tr>
						</table>
					</div>		
					</div>
					
					<h4 class="delivery-request">배송 요청사항</h4>
					<input type="text" class="btn-request" placeholder="입력해 주세요."/>
				</div>

			</div>
			<!-- 배송/주문자 정보 끝 -->

			<!-- 결제 수단 시작 -->
			<div class="section-payment-info left-section">
				<h3 class="section-payment-info-title">결제수단</h3>
				<ul class="payment-type-list">
					<li class="payment-type-item">
						<input type="radio" name="pay-type-item" value="mutong" />
						<span>무통장 입금</span>
					</li>
					<li class="payment-type-item mgb10">
						<input type="radio" name="pay-type-item" value="card" />
						<span>카드결제</span>
					</li>
				</ul>
			</div>
			<!-- 결제 수단 끝 -->
		</div>
		<!-- 하단좌측박스 끝 -->
		
		<!-- 우측 결제정보 시작 -->
		<div class="orderSec-right">
			<div class="right-section-info">
				<div class="right-section-price-info">
					<h3>결제 금액</h3>
					<ul class="expected-price-list">
						<li>
							<span>총 상품 금액</span>
							<strong><fmt:formatNumber value="${prodPriceAll}" type="number" />원</strong>
						</li>
						<li class="expected-price-item">
							<span class="expected-price-title">배송비</span>
							<strong>0원</strong>
						</li>
					</ul>
					<p class="total-expected-price">
						<span class="total-expected-price-title">총 결제 예상 금액</span>
						<strong class="total-expected-price-value"><fmt:formatNumber value="${prodPriceAll}" type="number" />원</strong>
					</p>
					<button class="btn-order" type="button">주문 완료하기</button>
				</div>
			</div>
		</div>
		<!-- 우측 결제정보 끝 -->
	</div>
</div>
<!-- 전체 박스 끝 -->

</body>
</html>

<jsp:include page="../footer.jsp" />
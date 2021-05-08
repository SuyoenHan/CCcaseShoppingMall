<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
   String ctxPath= request.getContextPath();
%>

<jsp:include page="../header.jsp" />

<link rel="stylesheet" href="<%=ctxPath%>/css/style.css" />

<style type="text/css">
	
	.contents {
	   width: 100%;
	   height: auto;
	   background-color: #f9f9f9;
	   padding-bottom: 100px;
	   margin-bottom: 100px;
	}
	
	.allProductInfo {
	   width: 100%;
	   height: auto;
	   margin: 0 auto;
	}
	
	.orderSec-left {
	   margin-right: 50%;
	   margin-left: 7%;
	}
	
	.left-section-delivery-info {
	   width: auto;
	}
	
	.left-section {
	   margin: 0px 0px 10px;
	   padding: 30px 80px 80px 80px;

	}
	
	.delivery-condition {
	   position: relative;
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
	   background-color: #F9F9F9;
	   border-top: 15px dashed #D8E4E4;
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
	   font-weight: 600;
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
	   background-color: #D5E2E2;
	   position: relative;
	   margin-right: 70px;
	   padding: 50px;
	   opacity: 0.9;
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
	    margin-bottom: 50px;
	    padding-top: 20px;
	    display: flex;
	    align-items: center;
	    justify-content: space-between;
	}
	
	button#totalpoint{
		margin-left: 5px; 
		background: #6D919C; 
		border: none; 
		color:white; 
		border-radius: 2px; 
		width: 80px; 
		height: 25px;
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
	   color: white;
	   background: #6D919C;
	   border: none;
	}
	
	.orderSec-right{
		position: absolute;
		top: 81%;
		left: 50%;
		width: 50%;
	}
	
	.salestatus{
		margin-top: 5%;
		padding: 10px 10px 10px 10px;
		background-color: rgba(255, 255, 255, 0.6);
		width: 100%;
	}
	

</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

   $(document).ready(function(){
      
      $("span.error").hide();
            
      //판매가 계산하기
      var price = Number(${requestScope.paraMap.price});      
      var salepercent = Number(${requestScope.paraMap.salepercent});
      var saleprice = Number(price*(1-salepercent));
      var finalamount =  ${requestScope.totalProPrice} + ${requestScope.shipfee};
     
          
      // 예상 총계산액
      $("span#finalamount").text(finalamount.toLocaleString('en')+"원");
      
      if(salepercent==0){
      
         $("td#saleprice").text(price);
      }
      else{
         $("td#saleprice").text(price);
      }
       
      // 전화번호 유효성검사
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
       
          
          // 우편번호 유효성 검사 
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
          
       // 포인트 버튼 처리
       $("button#totalpoint").click(function(){
          
          if("${requestScope.totalpoint}"==0){
             alert("보유중인 포인트가 없습니다.");
             return;
          }
          else{
             $("input#totalpoint").val("${requestScope.totalpoint}");
          }
          
          finalamount = ${requestScope.totalProPrice} + ${requestScope.shipfee} - ${requestScope.totalpoint};
             $("span#finalamount").text(finalamount.toLocaleString('en')+"원");
            
      }); // end of $("button#totalpoint").click(function(){})---------------------------
       
       // ?? 위치 헷갈림 일단 여기 두기로 ??   
       // 결제 버튼 처리 
          $("button.btn-order").click(function(){
              sessionStorage.setItem('finalamount', $("span#finalamount").val());
                
                // 아임포트 결제 팝업창 띄우기
                var url = "<%=request.getContextPath() %>/order/orderSuccess.cc?userid=${sessionScope.loginuser.userid}&finalamount="+finalamount+"";

                window.open(url, "orderSuccess",
                                	 "left=350px, top=100px, width=800px, height=570px");      
      }); // end of  $("button.btn-order").click(function(){})---------------------------
       
    });     
   // end of $(document).ready(function(){})----------------------------------------------
   
  
   $(window).on("scroll", function() {
      var scrollNow = window.scrollY;
     
     console.log(scrollNow);

          if(scrollNow < 900) {
              $(".orderSec-right").css('position', 'fixed');
              $(".orderSec-right").css('top', '30%');
          } 
          if (scrollNow <300){
              $(".orderSec-right").css('position', 'sticky');
              $(".orderSec-right").css('top', '30%');
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


   function goOrder(userid, finalamount) {

		
	   // 0. 주문테이블에 입력되어야 할 주문전표를 채번(select)
       // 1. 주문테이블에 insert(채번번호,fk_userid,totalPrice,shipstartdate,depositdate,finalamount)
       // 2. 주문상세테이블에  insert(odetailno,채번번호,fk_pnum,odqty,shipstatus,pdetailprice)
       // 3. 제품상세테이블에서 제품상세번호에 해당하는 제품 재고량 감소update(pnum,pqty )
       // 4. 이용자가 포인트를 사용한 경우.. => 포인트 차감시키기, + 또는 적립금 넣어주기
       //  update이며 , tbl_member에서(where userid,totalpoint) 
       // 5. 장바구니에서 해당 제품 삭제 tbl_cart delete(cartno필요,fk_userid)
       // 모든처리가 성공되었을 시 commit하기 (수동커밋)
       // 6. SQL오류 발생 시 rollback하기
       
       var totalPrice="${requestScope.totalProPrice}"; // 총 상품가격
       var shipfee="${requestScope.shipfee}";          // 배송비
       var expectPoint="${requestScope.expectPoint}";  // 예상적립금
       var qUsepoint = Number($("input#totalpoint").val()); // 사용예정포인트
		
		if(qUsepoint==""){
			qUsepoint = 0;
		}
		var finalamount=Number(totalPrice)+Number(shipfee)-Number(qUsepoint); //총결제금액
        var pnum = "${requestScope.para2Map.pnum}";       // 제품번호
		var odqty = "${requestScope.cnt}"; // 주문량
		var pdetailprice = parseInt("${requestScope.saleprice}");
		var cartno = "${requestScope.cartno}"; // 장바구니 번호
		// cartno가 없으면 null로 나올것임
		
		$.ajax({
        	url:"<%= ctxPath%>/order/oneOrderUpdate.cc",
        	type:"post",
        	data:{"totalPrice":totalPrice,
        		  "shipfee":shipfee,
        		  "expectPoint":expectPoint,
        		  "qUsepoint":qUsepoint,
        		  "finalamount":finalamount,
        		  "pnum":pnum,
        		  "odqty":odqty,
        		  "cartno":cartno,
        		  "pdetailprice":pdetailprice},
        	dataType:"json",
        	success:function(json){
     		   
     		   if(json.success == 1){
     			   
     			   location.href="<%= ctxPath%>/order/myOrderList.cc";
     		   }
     		   
     	   },
     	   error: function(request, status, error){
             		 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
          		} 

        }); // end of $.ajax
	   
   }

</script>

<div class="contents">
   
   <div style="margin: 120px 0 0 50px;">
      <h3 style="padding: 40px 0 40px 0; font-size: 30px; font-weight: bolder; color: #6D919C;">주문/결제</h3>
   </div>

   <!-- 하단박스 시작 -->
   <div class="allProductInfo">
      <!-- 상품 정보 시작 -->
         <div class="section-order-info left-section">
            <table class="table table-hover" style="margin-top:30px; border: 1px solid #B6B6B6; ">
               <thead>
                    <tr>
                       <th colspan="2">상품정보</th>
                       <th>판매가</th>
                       <th>수량</th>
                       <th>적립금</th>
                       <th>배송구분</th>
                       <th>배송비</th>
                   </tr>
               </thead>
                  
               <tbody>
               <tr style="background-color: white; border-top: 0px;">
                  <td rowspan="2"> <a href="<%= ctxPath%>/product/productDetail.cc?productid="${requestScope.para2Map.fk_productid} ><img src="<%= ctxPath%>/images/${requestScope.para2Map.pimage1}" width="80px" height="80px" style="border-radius: 20%; padding:5%;" /></a></td>
                        <td>${requestScope.para2Map.productname}</td>
                        <td><fmt:formatNumber value="${requestScope.para2Map.price}" pattern="#,###,###" />원</td>
                        <td rowspan="2" style="vertical-align: middle;">${cnt}개</td>
                        <td rowspan="2" style="vertical-align: middle;">${requestScope.expectPoint}원</td>
                        <td rowspan="2" style="vertical-align: middle;">
                           <c:choose>
                              <c:when test="${requestScope.para2Map.doption eq 0}">무료배송</c:when>
                              <c:when test="${requestScope.para2Map.doption eq 1}">기본배송</c:when>
                           </c:choose>
                        </td>
                        <td rowspan="2" id="doption" style="vertical-align: middle;">
                           <c:choose>
                              <c:when test="${requestScope.para2Map.doption eq 0}">무료</c:when>
                              <c:when test="${requestScope.para2Map.doption eq 1}">3,000원</c:when>
                           </c:choose>
                        </td>
                  </tr>
                  
                  <tr style="background-color: white;"> 
                     <td>옵션:&nbsp;${requestScope.para2Map.modelname}(${requestScope.para2Map.pcolor})</td>
                     <td id="salePrice"><fmt:formatNumber value="${requestScope.saleprice}" pattern="#,###,###" />원</td>                     
                  </tr>

               </tbody>
            </table>
         </div>
         <!-- 상품 정보 끝 -->
         
      <!-- 하단 박스 시작 -->
      <div class="orderSec-left">
         <!-- 배송/주문자 정보 시작 -->
         <div class="delivery-info left-section">
            <div class="delivery-user">
               <h3 style="font-weight: 600; padding-bottom: 20px;">주문자 정보</h3>
               <ul class="delivery-user-info" >
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
            <h4 style="font-weight: 600; padding-top: 20px;">배송 정보</h4>
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
                  <li>
                     <c:choose>
                        <c:when test="${empty sessionScope.loginuser.address}"><span style="color:red; font-weight:bolder;">등록된 주소지가 없습니다.</span></c:when>
                        <c:when test="${not empty sessionScope.loginuser.address}">${sessionScope.loginuser.address}</c:when>
                     </c:choose> 
                  </li>
                  <li>
                     <c:choose>
                        <c:when test="${empty sessionScope.loginuser.mobile}"><span style="color:red; font-weight:bolder;">등록된 휴대폰 번호가 없습니다.</span></c:when>
                        <c:when test="${not empty sessionScope.loginuser.mobile}">${sessionScope.loginuser.mobile}</c:when>
                     </c:choose> 
                  </li>
               </ul>
               </div>
               <!-- 새로운 배송지 -->
               <div class="newDelAddr" style="display: none;">
                  <div>
                  <table class="delivery-input">
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
               <input type="text" class="btn-request" placeholder="입력해 주세요." />
            </div>

         </div>
         <!-- 배송/주문자 정보 끝 -->

         <!-- 결제 수단 시작 -->
         <div class="section-payment-info left-section">
            <h3 class="section-payment-info-title">결제수단</h3>
            <ul class="payment-type-list">
               <li class="payment-type-item mgb10">
                  <input type="radio" name="pay-type-item" value="card" checked="checked"/>
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
               <h3 style="font-weight: 600;">결제 금액</h3>
               <ul class="expected-price-list">
                  <li class="expected-price-item">
                     <span class="expected-price-title">총 상품 금액</span>
                     <span style="font-weight: 600;"><fmt:formatNumber value="${requestScope.totalProPrice}" type="number" pattern="#,###,###"/>원</span>
                  </li>
                  <li class="expected-price-item">
                     <span class="expected-price-title">배송비</span>
                     <span style="font-weight: 600;"><fmt:formatNumber value="${requestScope.shipfee}" type="number" pattern="#,###,###"/>원</span>
                  </li>
                  <li class="salestatus">
	                  	 <h4> 할인 및 포인트</h4>	
	                     <span><input id="totalpoint" type="text" readonly="readonly" style="width: 150px;"/></span>
	                  	 <button id="totalpoint" type="button" >전액 사용</button>
						 <span>(보유중 포인트: ${requestScope.totalpoint}원) </span>
                  </li>
               </ul>
               <p class="total-expected-price">
                  <span class="total-expected-price-title">총 결제 예상 금액</span>
                  <span id="finalamount" style="font-weight:bolder; font-size:20pt" ></span>
               </p>
               <button class="btn-order" type="button">주문 완료하기</button>
            </div>
         </div>
      </div>
      <!-- 우측 결제정보 끝 -->
   </div>
</div>
<!-- 전체 박스 끝 -->

<%-- PG(Payment Gateway 결제)에 코인금액을 카드(카카오페이등)로 결제후 DB상에 사용자의 코인액을 update 를 해주는 폼이다. --%>
<form name="orderUpdateFrm">
   <input type="hidden" name="userid" />
   <input type="hidden" name="finalamount" />
</form>

<jsp:include page="../footer.jsp" />
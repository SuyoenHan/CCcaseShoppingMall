<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../header.jsp" />
<%
   String ctxPath= request.getContextPath();
%>

<style>


th {
   border:solid 1px black;
   width:200px;
}

td {
   border:solid 1px black;
}

</style>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
   
   $(document).ready(function(){
      
      var totalPrice="${requestScope.totalProPrice}"; // 총 상품가격
      var allShipfee="${requestScope.allShipfee}";    // 배송료
      var totalpoint ="${requestScope.allExpectPoint}" // 총예상적립금
      var qUsepoint = Number($("input#totalpoint").val());
      
      // 흠..............
      if(qUsepoint==""){
         qUsepoint = 0;
      }
      
      var finalamount=Number(totalPrice)+Number(allShipfee)-Number(qUsepoint);  // 총 결제금액
      // if()해줘서 point사용했냐 안했냐에 따라 point차감도 넣어주자
      
      var pnumArr = new Array();
      var odqtyArr = new Array();
      var pdetailpriceArr = new Array();
      var cartnoArr = new Array();
      
      // 넘어온 배열의 크기
      var listSize = Number("${requestScope.listSize}");
      // console.log(listSize);
      
      for(var i=0; i<listSize; i++){
         
         pnumArr.push($("input.fk_pnum").eq(i).val());
      //   console.log("pnum : "+$("input.fk_pnum").eq(i).val());
         odqtyArr.push($("input.odqty").eq(i).text());
      //   console.log($("input.odqty").eq(i).val());
         pdetailpriceArr.push($("input.pdetailprice").eq(i).val());
      //   console.log($("input.odqty").eq(i).val());
         cartnoArr.push($("input.cartno").eq(i).val())

      }// end of for ----
      
      $.ajax({
           url:"<%= ctxPath%>/order/manyOrderUpdate.cc",
           type:"post",
           data:{"totalPrice":totalPrice,
	                "allShipfee":allShipfee,
	                "totalpoint":totalpoint,
	                "qUsepoint":qUsepoint,
	                "finalamount":finalamount,
	                "pnum_es":pnumArr,
	                "odqty_es":odqtyArr,
	                "pdetailprice_es":pdetailpriceArr,
	                "cartno_es":cartnoArr},
	       dataType:"json",
           success:function(json){
              
              if(json.isSuccess == 1){
                
                 location.href="<%= ctxPath%>/order/myOrderList.cc";
              }
              
           },
           error: function(request, status, error){
                    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                } 

        }); // end of $.ajax
      
        // 결제 버튼 처리 
        $("button.btn-order").click(function(){
            sessionStorage.setItem('finalamount', $("span#finalamount").val());
              
              // 아임포트 결제 팝업창 띄우기
              var url = "<%=request.getContextPath() %>/order/orderSuccess.cc?userid=${sessionScope.loginuser.userid}&finalamount="+finalamount+"";

              window.open(url, "orderSuccess",
                               "left=350px, top=100px, width=800px, height=600px");     
              
    }); // end of  $("button.btn-order").click(function(){})---------------------------
      
   });// end of $(document).ready(function(){


   //새로운 주소 선택시에만 새로운 주소 입력칸 보여주기
   function setDisplay(){
      
     $(".newDelAddr").hide();
     
      if($("input:radio[id=delAddr]").is(":checked")){
          $(".newDelAddr").hide();
          $(".originAddr").show();
      }   
      
      if($("input:radio[id=newDelAddr]").is(":checked")){
         $(".origin-delAddr").hide();
          $(".newAddr").show();
      }
  
	}// end of function setDisplay()--------------------------------------

	function goOrder(userid, finalamount) {
	    var frm = document.orderUpdateFrm;
	    frm.userid.value = userid;
	    frm.finalamount.value = finalamount;
	    
	    frm.action = "<%=request.getContextPath()%>/order/manyOrderUpdate.cc";
	    frm.method="POST";
	    frm.submit();
	 }

</script>
    

<div id="contents">
   
   <div>
      <h3>주문/결제창</h3>
    </div>

   <div id="allProductInfo">   
      <!-- 상품 정보 시작 -->
       <table style="margin-top:30px;">
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
               <c:forEach var="productMap" items="${requestScope.orderPageList}">
                  <input type="hidden" class="fk_pnum" value="${productMap.pnum}"/>
                  <input type="hidden" class="cartno" value="${productMap.cartnoArr}"/>
                  <tr>   
                       <td rowspan="2"> <a href="<%= ctxPath%>/product/productDetail.cc?productid="${productMap.fk_productid} ><img src="<%= ctxPath%>/images/${productMap.pimage1}" width="80px" height="80px" /></a></td>
                       <td style="width:130px;">${productMap.productname}</td>
                       <td><fmt:formatNumber value="${productMap.price}" pattern="#,###,###" />원<input type="hidden" class="pdetailprice" value="${productMap.price}"/></td>
                       <td rowspan="2">${productMap.cntArr}개<input type="hidden" class="odqty" value="${productMap.cntArr}"/></td>
                       <td rowspan="2">${productMap.oneExpectpoint}원</td>
                       <td rowspan="2">
                           <c:choose>
                              <c:when test="${productMap.doption eq 0}">무료배송</c:when>
                              <c:when test="${productMap.doption eq 1}">기본배송</c:when>
                           </c:choose>
                       </td>
                        <td rowspan="2" id="doption">
                           <c:choose>
                              <c:when test="${productMap.doption eq 0}">무료</c:when>
                              <c:when test="${productMap.doption eq 1}">3,000원</c:when>
                           </c:choose>
                        </td>
                    </tr>
                    
                   <tr> 
                      <td>옵션:&nbsp;${productMap.modelname}</td>
                      <td id="salePrice"><fmt:formatNumber value="${productMap.saleprice}" pattern="#,###,###" />원</td>
                   </tr>
            </c:forEach>
            </tbody>

        </table>

     </div>
     
      <!-- 하단 박스 시작 -->
      <div class="orderSec-left">
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
                     <span style="margin-right:265px">총 상품 금액</span>
                     <span id="totalProPrice"><fmt:formatNumber value="${requestScope.totalProPrice}" type="number" pattern="#,###,###"/>원</span>
                  </li>
                  <li class="expected-price-item">
                     <span class="expected-price-title">배송비</span>
                     <span>
                        <fmt:formatNumber value="${requestScope.shipfee}" type="number" pattern="#,###,###"/>원
                     </span>
                  </li>
                  <li class="expected-price-item">
                     <input id="totalpoint" type="text" readonly="readonly" /><span>보유중 포인트: ${requestScope.totalpoint}원 </span> 
                     <button id="totalpoint" type="button">포인트사용</button>
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


<%-- PG(Payment Gateway 결제)에 코인금액을 카드(카카오페이등)로 결제후 DB상에 사용자의 코인액을 update 를 해주는 폼이다. --%>
<form name="orderUpdateFrm">
   <input type="hidden" name="userid" />
   <input type="hidden" name="finalamount" />
</form>

<jsp:include page="../footer.jsp" />
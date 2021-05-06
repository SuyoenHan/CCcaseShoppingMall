<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>    

<style>

	span.colName {
		margin-left: 30px;
		display : inline-block;
		width: 100px;
		background-color: #f2f2f2;
		line-height: 30px;
		margin-bottom:30px;
	}
	
	h2{
		margin-left: 25px;
	}

</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script> 
	
	$(document).ready(function(){
		
		
		// 접수완료 버튼을 클릭했을때
		// ==> 교환환불테이블에 insert를 해주고, 주문테이블의 배송상태(shipstatus)를 update해준다 
		
		$(document).ready(function(){
			
			var frm = document.proRefundFrm;
			
			$("button#goRefund").click(function(){
				
				var flag =false;
				var whycontent = $("textarea#whycontent").val().trim();
				
				if(whycontent==""){
					alert("사유는 반드시 입력해주세요");
					flag= true;
					return;
				}
				
				if(!flag){
					frm.action="<%= ctxPath%>/board/productRefund.cc";
					frm.method="POST";
					frm.submit();
				}
				
				
			}); // end of $("button#goChange").click(function(){
				
			$("button#cancel").click(function(){
				
				self.close();
			
			}); // end of $("button#goRefund").click(function(){
			
			
		});
		
		
		
	});

</script>




<div id="container"> 

	<h2>환불접수</h2>
	<form name="proRefundFrm">
		<div id="col1">
			<span class="colName">주문번호</span>
			<input type="text" name="orderno" readonly="readonly" value="${requestScope.orderno}" /> 
		</div>
		
		<div id="col2">
			<span class="colName">주문번호</span>
			<input type="text" name="odetailno" readonly="readonly" value="${requestScope.odetailno}" /> 
		</div>
		
		<div id="col3">
			<span class="colName">상품명</span>
			<input type="text" name="productname" readonly="readonly" value="${requestScope.productname}" />
		</div>
		
		<div id="col4">
			<span class="colName" style="height:30px;">사유<br><br></span>
			<textarea id="whycontent" name="whycontent" rows="5" cols="20"></textarea>
		</div>
		
		<br><br>
		<div style="margin-left:250px;"> 
			<button type="button" id="goRefund">접수완료</button>
			<button type="button" id="cancel">취소</button>
		</div>
		
		<input type="hidden" name="sortno" value="1" />	
	</form>
</div>    
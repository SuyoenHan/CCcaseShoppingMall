<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath= request.getContextPath();
%>


<style type="text/css">

	table.eachWishList tr{
		border: solid 1px red;
	}

	div#cartTitle{
		border: solid 1px red;
	}
	
	div#deleteEach{
		border: solid 1px red;
		float:left;
	}
	
	div#deleteAll{
		border: solid 1px red;
		float:right;
	}
	
	div#deleteSelected{border: solid 1px red;}
	
	div#deleteAll{border: solid 1px red;}
	
	table#priceInfo tr{border: solid 1px red;}
	
	div.bottomBt{border: solid 1px red;}
	
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		
		
		
	}); // end of $(document).ready(function(){-------------------------

</script>

<jsp:include page="../header.jsp" />
<div id="contents" style="clear:both; border: solid 1px blue; width:100%;">
	
	<div id="cartTitle"> ${name}&nbsp;님의&nbsp;장바구니</div>
	<table class="eachWishList">
		<tr>
			<td colspan="8"></td>
		</tr>
		<tr>
			<th>체크박스</th>
			<th>이미지</th>
			<th>상품정보</th>
			<th>판매가</th>
			<th>수량</th>
			<th>예상적립금</th>
			<th>배송비</th>
			<th>합계</th>
		</tr>
		<tr>
			<td>체크박스</td>
			<td>이미지</td>
			<td>상품정보</td>
			<td>판매가</td>
			<td>수량</td>
			<td>예상적립금</td>
			<td>배송비</td>
			<td>합계</td>
		</tr>
		<tr>
			<td colspan="8"></td>
		</tr>
	</table>
	
	<div id="deleteSelected">선택상품삭제하기</div>
	<div id="deleteAll">장바구니 비우기</div>
	
	<table id="priceInfo">
		<tr>
			<th>총상품금액</th>
			<th>총배송비</th>
			<th>총할인금액</th>
			<th>결제예정금액</th>
		</tr>
		<tr>
			<td>금액</td>
			<td>금액</td>
			<td>금액</td>
			<td>금액</td>
		</tr>
	</table>
	
	<div style="border: solid 1px red;">
		<span>할인내역 정보</span>
		<span>쇼핑계속하기</span>
	</div>
	
	<div class="bottomBt" id="orderAll">전체상품 주문하기</div>
	<div class="bottomBt" id="orderSelected">선택상품 주문하기</div>
	
</div>
<jsp:include page="../footer.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath= request.getContextPath();
%>


<style type="text/css">

	div#cartTitle{
		border: solid 0px red;
		height: 90px;
		font-size: 25pt;
		padding-left: 100px;
	}
	
	table.eachWishList{
		margin-bottom:30px;
		margin-left: 100px;
		width: 90%;
		text-align: center;
	}
	
	table.eachWishList tr{
		border: solid 0px red;
		line-height: 60px;
	}

	table.eachWishList th{
		border: solid 0px red;
		text-align: center;
	}
	
	img.cartImg{
		border-radius: 20%;
	}
	
	div#deleteEach{
		border: solid 1px red;
		float:left;
	}
	
	div#deleteAll{
		border: solid 1px red;
		float:right;
	}
	
	td.cartUpdate > span{
		background-color: #a0aca0;
	}
	
	td.cartUpdate > span:hover{
		background-color: #ecffb3;
	}
	
	
	div#deleteSelected{border: solid 1px red;}
	
	div#deleteAll{border: solid 1px red;}
	
	table#priceInfo tr{border: solid 1px red;}
	
	div.bottomBt{border: solid 1px red;}
	
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		func_height();
		
	}); // end of $(document).ready(function(){-------------------------

</script>

<jsp:include page="../header.jsp" />
<div id="contents" style="clear:both; border: solid 1px blue; margin-top:50px; width:100%;">
	
	<div id="cartTitle"><span style="color:blue;">${name}</span>님의&nbsp;장바구니</div>
	
	<c:forEach var="cartRequiredInfo" items="${cartRequiredInfoList}">
		<table class="eachWishList">
			<tr>
				<td colspan="9"><div style="background-color: #d1d7d1; height: 20px;"></div></td>
			</tr>
			<tr style="border-top: solid 1px #a0aca0; border-bottom: solid 1px #a0aca0;">
				<th style="width: 70px;">선택</th>
				<th style="width: 160px;">이미지</th>
				<th style="width: 230px;">상품정보</th>
				<th style="width: 90px;">색상</th>
				<th style="width: 130px;">판매가</th>
				<th style="width: 110px;">수량</th>
				<th style="width: 130px;">예상적립금</th>
				<th style="width: 150px;">배송비</th>
				<th>합계</th>
			</tr>
			<tr>
				<td rowspan="2"><input type="checkbox" name="checkList" value="${cartRequiredInfo.pnum}" /></td>
				<td rowspan="2"><img src="<%=ctxPath%>/images/${cartRequiredInfo.pimage1}" width="110px" height="100px" class="cartImg" /></td>
				<td>${cartRequiredInfo.productname}</td>
				<td>${cartRequiredInfo.pcolor}</td>
				<td style="text-decoration: line-through;">${cartRequiredInfo.price}원</td>
				<td rowspan="2">${cartRequiredInfo.cinputcnt}개</td>
				<td rowspan="2">${cartRequiredInfo.point}&nbsp;point</td>
				<c:if test="${cartRequiredInfo.doption eq '0'}">
					<td rowspan="2">무료배송</td>
				</c:if>
				<c:if test="${cartRequiredInfo.doption eq '1'}">
					<td rowspan="2">3,000원</td>
				</c:if>
				<c:if test="${cartRequiredInfo.doption eq '색상에 따라 상이'}">
					<td rowspan="2">색상에 따라 상이</td>
				</c:if>
				<td rowspan="2">${cartRequiredInfo.totalPrice}원</td>
			</tr>
			<tr>
				<td style="border-top:solid 1px #a0aca0;">[${cartRequiredInfo.cname}]&nbsp;[${cartRequiredInfo.modelname}]</td>
				<td class="cartUpdate"><span>변경하기</span></td>
				<td style="color:red;">${cartRequiredInfo.saleprice}원</td>
			</tr>
			<tr>
				<td colspan="9"><div style="background-color: #d1d7d1; height: 20px; border-top: solid 1px #a0aca0; "></div></td>
			</tr>
		</table>
	</c:forEach>
	
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
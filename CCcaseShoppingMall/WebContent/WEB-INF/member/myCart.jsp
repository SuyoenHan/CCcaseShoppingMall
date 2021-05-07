<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
	
	td.cartUpdate > span{
		background-color: #a0aca0;
		text-align: center;
	}
	
	td.cartUpdate > span:hover{
		background-color: #ecffb3;
	}
	
	div#delete > span{
		border: solid 0px red;
		display: inline-block;
		width: 160px;
		height: 40px;
		font-size: 13pt;
		text-align: center;
		padding-top: 8px;
		background-color: #a0aca0;
		margin-left: 100px;
		font-weight: bold;
	}
	
	div#delete > span:hover{
		background-color: #ecffb3;
	}
	
	table#priceInfo{
		border: solid 1px red;
		margin: 70px 0px 0px 100px;
	}
	
	table#priceInfo td, table#priceInfo th{
		border: solid 1px #979791;
		width: 305px;
		text-align: center;
		border-collapse: collapse;
		height: 70px;
		font-size: 13pt;
	}
	
	table#priceInfo th{
		background-color: #e6e6e5;
	}
	
	div.bottomBt{
		border: solid 1px green;
		width: 250px;
		height: 50px;
		background-color: #a0aca0;
		margin-left: 580px;
		margin-top: 10px;
		text-align: center;
		font-size: 13pt;
		font-weight: bold;
		padding-top: 15px;
	}
	
	div.bottomBt:hover{
		background-color: #ecffb3;
	}
	
	input.pcnt{
		width:50px;
		height: 30px;
		text-align: center;
	}
	
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		func_height();
		
		$("input.pcnt").prop("disabled",true);
		$("span#uncheckAll").hide();
			 
		// 색상 및 수량 변경 버튼 클릭 이벤트	 
	 	$("td.cartUpdate > span").click(function(){
	 		
	 		var cartno= $(this).parent().parent().parent().find("input.cartno").val();
	 		var pnum= $(this).parent().parent().prev().find("td.pnum").prop('id');
	 		var productid= $(this).parent().parent().parent().find("input.productid").val();
	 		var cinputcnt= $(this).parent().parent().prev().find("td.cinputcnt").prop('id');
			location.href="<%=ctxPath%>/product/productDetail.cc?productid="+productid+"&cartno="+cartno+"&pnum="+pnum+"&cinputcnt="+cinputcnt;	 		
	 		
	 	}); // end of $("div.cartUpdate > span").click(function(){-----------
	 	

	 	// 장바구니 비우기 버튼 클릭 이벤트
	 	$("span#deleteAll").click(function(){
	 		
	 		var userid= "${userid}";
	 		
	 		var result= confirm("장바구니를 비우시겠습니까?");
			if(result){
				$.ajax({
		 			url: "<%=ctxPath%>/member/myCartDeleteAll.cc",
		 			type:"post",
		 			data:{"userid":userid},
		 			dataType:"JSON",
		 			success:function(json){
		 				if(json.n>=1){
		 					alert("장바구니를 비웠습니다");
		 					location.href="<%=ctxPath%>/member/myCart.cc"
		 				}
		 			},
		 			error: function(request, status, error){
				           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				    }
		 		}); // end of $.ajax({----------------------------- 			
			} // end of if----------------------------------------
			
	 	}); // end of $("span#deleteAll").click(function(){----------------------------
	 	
	 	
	 	// 쇼핑계속하기 버튼 클릭 이벤트
	 	$("span#continueShopping").click(function(){
	 		
	 		location.href="javascript:history.back()";
	 		
	 	}); // end of $("span#continueShopping").click(function(){---------------------
	 	
	 	
	 	// 선택상품 삭제하기 클릭 이벤트
	 	$("span#deleteSelected").click(function(){
	 		
	 		var checkcnt= $("input:checkbox[name=checkList]:checked").length;
	 		
	 		if(checkcnt==0){
	 			alert("선택된 항목이 없습니다.");
	 		}
	 		else{
		 		var result= confirm("장바구니에서 "+checkcnt+"개의 항목을 삭제하시겠습니까?");
		 		if(result){ // 장바구니에서 선택항목 삭제
	 				
			 		$("input:checkbox[name=checkList]:checked").each(function(index,item){
			 			var cartno= $(item).parent().parent().parent().find("input.cartno").val();
						
			 			$.ajax({
			 				url: "<%=ctxPath%>/member/myCartDeleteOne.cc",
			 				type: "post",
			 				data: {"cartno":cartno},
			 				dataType: "JSON",
			 				success:function(json){},
			 				error: function(request, status, error){
						           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						    }
			 			}); // end of $.ajax(function(){----------
			 				
			 		}); // end of each-------------------
			 		
			 		alert(checkcnt+"개의 항목을 삭제했습니다."); // alert 1번만 띄우기 위해 each 밖에서 실행
				 	location.href="<%=ctxPath%>/member/myCart.cc";		
		 		}
		 	}
	 	}); // end of $("span#deleteSelected").click(function(){-----------------------
	 	
	 	
	 	// 전체상품 선택하기 클릭 이벤트
	 	$("span#checkAll").click(function(){
	 		 $("input:checkbox[name=checkList]").prop("checked",true);	
	 		 $("span#checkAll").hide();
	 		 $("span#uncheckAll").show();
	 		 
 		 
	 	 	var totalPrice=0;
		 	var dFee="-";
		 	var totalDiscountPrice=0;
		 	var finalPrice=0;
		 	
			$("input:checkbox[name=checkList]").each(function(index,item){
		 		
		 		var cinputcnt= $(item).parent().parent().find("td.cinputcnt").prop('id');
		 		cinputcnt= parseInt(cinputcnt)
		 		totalPrice= totalPrice+(parseInt($(item).parent().parent().find("td.price").prop("id")))*cinputcnt;
		 		
		 		var saleprice= $(item).parent().parent().next().find("td.salePrice").prop("id");
		 		
		 		if(saleprice == "0"){
		 			saleprice= $(item).parent().parent().find("td.price").prop("id");
		 		}
		 		
		 		finalPrice= finalPrice+(parseInt(saleprice))*cinputcnt;
		 	});
		 	
		 	$("input:checkbox[name=checkList]").each(function(index,item){
		 		
		 		var doption= $(item).parent().parent().parent().find("input.doption").val();
		 		
		 		if(doption=='색상에 따라 상이'){
		 			dFee='색상에 따라 상이';
		 			return true;
		 		}
		 		else if(doption=="1"){
		 			dFee="+ 3,000원";
		 			return false;
		 		}
		 		dFee="+ 0원";
		 	});
		 	
		 	totalDiscountPrice= totalPrice-finalPrice;
		 	
		 	$("td#totalPrice").text((totalPrice.toLocaleString('en'))+" 원");
		 	$("td#dFee").html("<span style='color:blue;'>"+dFee+"</span>");
		 	$("td#totalDiscountPrice").html("<span style='color:red;'>"+(totalDiscountPrice.toLocaleString('en'))+" 원</span>");
		 	$("td#finalPrice").text((finalPrice.toLocaleString('en'))+" 원");
		 	
	 	}); // end of $("span#checkAll").click(function(){-----------------------------
	 	
	 	

	 	// 전체상품 선택해제 클릭 이벤트
	 	$("span#uncheckAll").click(function(){
	 		 $("input:checkbox[name=checkList]").prop("checked",false);	
	 		 $("span#uncheckAll").hide();
	 		 $("span#checkAll").show();
	 		 
	 	 	totalPrice=0;
		 	dFee="-";
		 	totalDiscountPrice=0;
		 	finalPrice=0;
		 	
			$("td#totalPrice").text((totalPrice.toLocaleString('en'))+" 원");
		 	$("td#dFee").html("<span style='color:blue;'>"+dFee+"</span>");
		 	$("td#totalDiscountPrice").html("<span style='color:red;'>"+(totalDiscountPrice.toLocaleString('en'))+" 원</span>");
		 	$("td#finalPrice").text((finalPrice.toLocaleString('en'))+" 원");
		 	
		 	
	 	}); // end of $("span#uncheckAll").click(function(){-----------------------------
	 		
	 		
	 		
	 	// 선택된 상품들의 총상품금액, 총배송비, 총할인금액, 결제예정금액 구하기
	 	
	 	totalPrice=0;
	 	dFee="-";
	 	totalDiscountPrice=0;
	 	finalPrice=0;
	 	
		$("td#totalPrice").text(totalPrice+" 원");
	 	$("td#dFee").html("<span style='color:blue;'>"+dFee+"</span>");
	 	$("td#totalDiscountPrice").html("<span style='color:red;'>"+totalDiscountPrice+" 원</span>");
	 	$("td#finalPrice").text(finalPrice+" 원");
		 	
		 	
		$("input:checkbox[name=checkList]").click(function(){
		 
			 totalPrice=0;
			 dFee="-";
			 totalDiscountPrice=0;
			 finalPrice=0;
			 
		 	$("input:checkbox[name=checkList]:checked").each(function(index,item){
		 		
		 		
		 		var cinputcnt= $(item).parent().parent().find("td.cinputcnt").prop('id');
		 		cinputcnt= parseInt(cinputcnt)
		 		totalPrice= totalPrice+(parseInt($(item).parent().parent().find("td.price").prop("id")))*cinputcnt;
		 		
				var saleprice= $(item).parent().parent().next().find("td.salePrice").prop("id");
		 		if(saleprice == "0"){
		 			saleprice= $(item).parent().parent().find("td.price").prop("id");
		 		}
		 		finalPrice= finalPrice+(parseInt(saleprice))*cinputcnt;
		 	});
		 	
		 	$("input:checkbox[name=checkList]:checked").each(function(index,item){
		 		
		 		var doption= $(item).parent().parent().parent().find("input.doption").val();
		 		
		 		if(doption=='색상에 따라 상이'){
		 			dFee='색상에 따라 상이';
		 			return true;
		 		}
		 		else if(doption=="1"){
		 			dFee="+ 3,000원";
		 			return false;
		 		}
		 		dFee="+ 0원";
		 	});
		 	
		 	totalDiscountPrice= totalPrice-finalPrice;
		 	
		 	$("td#totalPrice").text((totalPrice.toLocaleString('en'))+" 원");
		 	$("td#dFee").html("<span style='color:blue;'>"+dFee+"</span>");
		 	$("td#totalDiscountPrice").html("<span style='color:red;'>"+(totalDiscountPrice.toLocaleString('en'))+" 원</span>");
		 	$("td#finalPrice").text((finalPrice.toLocaleString('en'))+" 원");
		 	
		}); // end of $("input:checkbox[name=checkList]").click(function(){------------  	
		
	}); // end of $(document).ready(function(){-------------------------

</script>

<jsp:include page="../header.jsp" />
<div id="contents" style="clear:both; margin-top:50px; width:100%;">
	
	<div id="cartTitle"><span style="color:blue;">${name}</span>님의&nbsp;장바구니</div>
	
	<c:forEach var="cartRequiredInfo" items="${cartRequiredInfoList}">
		<table class="eachWishList">
			<tr>
				<td><input type="hidden" class="cartno" value="${cartRequiredInfo.cartno}" /></td>
				<td><input type="hidden" class="productid" value="${cartRequiredInfo.productid}" /></td>
				<td><input type="hidden" class="doption" value="${cartRequiredInfo.doption}" /></td>
			</tr>
			<tr>
				<td colspan="9"><div style="background-color: #d1d7d1; height: 20px;"></div></td>
			</tr>
			<tr style="border-top: solid 1px #a0aca0; border-bottom: solid 1px #a0aca0;">
				<th style="width: 70px;">선택</th>
				<th style="width: 160px;">이미지</th>
				<th style="width: 230px;">상품정보</th>
				<th style="width: 90px;">색상</th>
				<th style="width: 130px;">수량</th>
				<th style="width: 110px;">판매가</th>
				<th style="width: 130px;">예상적립금</th>
				<th style="width: 150px;">배송비</th>
				<th>합계</th>
			</tr>
			<tr>
				<td rowspan="2" id="${cartRequiredInfo.pnum}" class="pnum"><input type="checkbox" name="checkList" value="${cartRequiredInfo.pnum}" /></td>
				<td rowspan="2"><img src="<%=ctxPath%>/images/${cartRequiredInfo.pimage1}" width="110px" height="100px" class="cartImg" /></td>
				<td>${cartRequiredInfo.productname}</td>
				<td class="color" id="${cartRequiredInfo.pcolor}">${cartRequiredInfo.pcolor}</td>
				<td class="cinputcnt" id="${cartRequiredInfo.cinputcnt}">
					<input type="number" min="1" max="50" value="${cartRequiredInfo.cinputcnt}"개 class="pcnt">&nbsp;&nbsp;개
				</td>
				<c:if test="${cartRequiredInfo.salepercent eq 0}">
					<td class="price" id="${cartRequiredInfo.price}"><fmt:formatNumber value="${cartRequiredInfo.price}" pattern="#,###,###" />원</td>
				</c:if>
				<c:if test="${cartRequiredInfo.salepercent ne 0}">
					<td style="text-decoration: line-through;" class="price" id="${cartRequiredInfo.price}"><fmt:formatNumber value="${cartRequiredInfo.price}" pattern="#,###,###" />원</td>
				</c:if>
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
				<td rowspan="2"><fmt:formatNumber value="${cartRequiredInfo.totalPrice}" pattern="#,###,###" />원</td>
			</tr>
			<tr>
				<td style="border-top:solid 1px #a0aca0;">[${cartRequiredInfo.cname}]&nbsp;[${cartRequiredInfo.modelname}]</td>
				<td colspan="2" class="cartUpdate"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;색상 및 수량 변경&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
				<c:if test="${cartRequiredInfo.salepercent eq 0}">
					<td class="salePrice" rowspan="2" id="0"></td>
				</c:if>
				<c:if test="${cartRequiredInfo.salepercent ne 0}">
					<td style="color:red;" class="salePrice" id="${cartRequiredInfo.saleprice}"><fmt:formatNumber value="${cartRequiredInfo.saleprice}" pattern="#,###,###" />원</td>
				</c:if>
				
			</tr>
			<tr>
				<td colspan="9"><div style="background-color: #d1d7d1; height: 20px; border-top: solid 1px #a0aca0; "></div></td>
			</tr>
		</table>
	</c:forEach>
	
	<div id="delete">
		<span id="deleteSelected">선택상품 삭제하기</span>
		<span id="deleteAll" style="margin-left: 20px;">장바구니 비우기</span>
		<span id="checkAll" style="margin-left: 520px;">전체상품 선택하기</span>
		<span id="uncheckAll" style="margin-left: 520px;">전체상품 선택해제</span>
		<span style="margin-left: 20px;" id="continueShopping">쇼핑계속하기</span>
	</div>
	
	<table id="priceInfo">
		<tr>
			<th>총상품금액</th>
			<th>총배송비</th>
			<th>총할인금액</th>
			<th>결제예정금액</th>
		</tr>
		<tr>
			<td id="totalPrice"></td>
			<td id="dFee"></td>
			<td id="totalDiscountPrice"></td>
			<td id="finalPrice"></td>
		</tr>
	</table>
	
	<div class="bottomBt" id="orderAll" style="margin-top:70px;">전체상품 주문하기</div>
	<div class="bottomBt" id="orderSelected"  style="margin-bottom:100px;">선택상품 주문하기</div>
	
</div>
<jsp:include page="../footer.jsp" />

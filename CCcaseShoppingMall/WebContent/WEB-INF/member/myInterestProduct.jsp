<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath= request.getContextPath();
%>

<style type="text/css">
	
	div#myInterestProduct{
		background-color: #3385ff;
	}	
	
	div#title{
		font-size: 20pt;
		height: 50px;
		border-bottom: solid 2px #a8aba6;
		margin-bottom:30px;
	}
	
	table.eachInterestProduct{
		margin-bottom:30px;
		width: 101%;
		text-align: center;
	}
	
	table.eachInterestProduct tr{
		border: solid 0px red;
		line-height: 60px;
	}

	table.eachInterestProduct td{
		border: solid 0px red;
		line-height: 40px;
	}
	
	table.eachInterestProduct th{
		border: solid 0px red;
		text-align: center;
	}
	
	img.interestProductImg{
		border-radius: 20%;
	}
	
	 span.funcBt{
	 	padding: 5px 0px;
	 	border: solid 2px #6d919c;
		text-align: center;
	 }

	span.funcBt:hover{
		background-color: #6D919C;
		color: #fff;
		font-weight: bold;
	}
	
	span.bottomBt{
		border: solid 0px red;
		display: inline-block;
		width: 160px;
		height: 40px;
		font-size: 13pt;
		text-align: center;
		padding-top: 8px;
		background-color:#98B7C1;
		font-weight: bold;
	}
	
	span.bottomBt:hover{
		background-color: #4d7380;
		color:#fff;
		font-weight: bold;
	}
	
	span#box{
		border: solid 2px #a8aba6;
		display: inline-block;
		width: 400px;
		height: 70px;
		font-weight: bold;
		text-align: center;
		padding-top: 15px;
		font-size: 13pt;
	}
	
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		func_height();
		$("span#uncheckAll").hide();
		
		// 전체상품 선택하기 클릭 이벤트
	 	$("span#checkAll").click(function(){
	 		 
	 		 $("input:checkbox[name=checkList]").prop("checked",true);	
	 		 $("span#checkAll").hide();
	 		 $("span#uncheckAll").show();
	 	
	 	}); // end of $("span#checkAll").click(function(){-----------------------------

	 		
	 	// 전체상품 선택해제 클릭 이벤트
	 	$("span#uncheckAll").click(function(){
	 		
	 		 $("input:checkbox[name=checkList]").prop("checked",false);	
	 		 $("span#uncheckAll").hide();
	 		 $("span#checkAll").show();
	 		
	 	}); // end of $("span#uncheckAll").click(function(){-----------------------------
		
	 		
	 	// 체크박스를 클릭했을때 전부 선택되어져 있으면 전체상품 선택해제 버튼 표시, 하나라도 선택이 안되어져 있으면 전체상품 선택하기 버튼 표시
	 	$("input:checkbox[name=checkList]").click(function(){
	 		
	 		$("input:checkbox[name=checkList]").each(function(){
				var length= $("input:checkbox[name=checkList]").length;
				var checkedLength=$("input:checkbox[name=checkList]:checked").length;
				
				if(length==checkedLength){
					 $("span#uncheckAll").show();
			 		 $("span#checkAll").hide();	
				}
				else{
					 $("span#uncheckAll").hide();
			 		 $("span#checkAll").show();
				}
	 		
	 		}); // end of each--------------------------------
	 		
	 	}); // end of $("input:checkbox[name=checkList]").click(function(){----------
	 		
	 		
	
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
		 		var result= confirm("관심상품 "+checkcnt+"개의 항목을 삭제하시겠습니까?");
		 		if(result){ // 관심상품에서 선택항목 삭제
	 				
			 		$("input:checkbox[name=checkList]:checked").each(function(index,item){
			 			var interestno= $(item).parent().parent().parent().find("input.interestno").val();
						// console.log(interestno);
	
						$.ajax({
			 				url: "<%=ctxPath%>/member/myInterestProductDelete.cc",
			 				type: "post",
			 				data: {"interestno":interestno},
			 				dataType: "JSON",
			 				success:function(json){},
			 				error: function(request, status, error){
						           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						    }
			 			}); // end of $.ajax({----------
			 				
			 		}); // end of each-------------------
		 			
			 		alert(checkcnt+"개의 항목을 삭제했습니다."); // alert 1번만 띄우기 위해 each 밖에서 실행
				 	location.href="<%=ctxPath%>/member/myInterestProduct.cc";		
		 		}
		 	}
	 	}); // end of $("span#deleteSelected").click(function(){-----------------------	
	 		
	 	
	 	// 하나의 상품 삭제하기 클릭 이벤트
	 	$("span.deleteOne").click(function(){
	 		
	 		var interestno= $(this).parent().parent().parent().find("input.interestno").val();
	 		var productname= $(this).parent().parent().prev().find("td.productname").prop('id');
	 		var pcolor= $(this).parent().parent().prev().find("td.color").text();
	 		
	 		$.ajax({
 				url: "<%=ctxPath%>/member/myInterestProductDelete.cc",
 				type: "post",
 				data: {"interestno":interestno},
 				dataType: "JSON",
 				success:function(json){
 					if(json.n==1){
 						alert(productname+"["+pcolor+"] 가 관심상품에서 삭제되었습니다.");	
 						location.href="<%=ctxPath%>/member/myInterestProduct.cc";
 					}
 				},
 				error: function(request, status, error){
			           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			    }
 			}); // end of $.ajax({----------
	 
 		}); // end of $("span.deleteOne").click(function(){-------------------------  
	 	
	 		
	 	// 선택상품 장바구니에 담기 클릭 이벤트
	 	
	 	$("span#addCartSelected").click(function(){
	 		
			var checkcnt= $("input:checkbox[name=checkList]:checked").length;
	 		if(checkcnt==0){
	 			alert("선택된 항목이 없습니다.");
	 		}
	 		else{	
			 	$("input:checkbox[name=checkList]:checked").each(function(index,item){

		 			var productid= $(item).parent().parent().parent().find("input.productid").val();
			 		var pnum=$(item).parent().prop('id'); // 색상 선택안한경우 pnum은 "-"
					var pcnt= "1";
			 		
					$.ajax({
		 				url: "<%=ctxPath%>/member/myCartInsert.cc",
		 				type: "post",
		 				data: {"productid":productid,"pnum":pnum,"userid":"${loginuser.userid}","pcnt":pcnt},
		 				dataType: "JSON",
		 				success:function(json){},
		 				error: function(request, status, error){
					           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					    }
		 			}); // end of $.ajax({-----------------------
		 			
		 			var interestno= $(this).parent().parent().parent().find("input.interestno").val();
		 			
		 			$.ajax({
		 				url: "<%=ctxPath%>/member/myInterestProductDelete.cc",
		 				type: "post",
		 				data: {"interestno":interestno},
		 				dataType: "JSON",
		 				success:function(json){},
		 				error: function(request, status, error){
					           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					    }
		 			}) // end of $.ajax({------------------------- 	
		 		});// end of each-------------------------
	 			
		 		var result= confirm(checkcnt+"개의 상품을 관심상품에서 장바구니로 옮겼습니다.\n장바구니로 이동하시겠습니까?"); // confirm 1번만 띄우기 위해 each 밖에서 실행
			 	if(result){
			 		location.href="<%=ctxPath%>/member/myCart.cc";	
			 		return;
			 	}
			 	else{
			 		location.href="<%=ctxPath%>/member/myInterestProduct.cc";
			 	}
	 		} // end of else--------------------------------------------------------
	 	}); // end of $("span$addCartSelected").click(function(){-------------------
	 	
	 	
	 	// 하나의 상품 장바구니 담기 클릭 이벤트
	 	$("span.addCartOne").click(function(){
	 		
	 		var interestno= $(this).parent().parent().parent().find("input.interestno").val();
	 		var productid= $(this).parent().parent().parent().find("input.productid").val();
	 		var pnum=$(this).parent().parent().find("td.pnum").prop('id'); // 색상 선택안한경우 pnum은 "-"
			var pcnt= "1";
	 		
			var productname= $(this).parent().parent().find("td.productname").prop('id');
	 		var pcolor= $(this).parent().parent().find("td.color").text();
	 		
			$.ajax({ // 장바구니로 insert
 				url: "<%=ctxPath%>/member/myCartInsert.cc",
 				type: "post",
 				data: {"productid":productid,"pnum":pnum,"userid":"${loginuser.userid}","pcnt":pcnt},
 				dataType: "JSON",
 				success:function(json){},
 				error: function(request, status, error){
			           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			    }
 			}); // end of $.ajax({-----------------------
 				
 			$.ajax({ // 관심상품에서 delete
 				url: "<%=ctxPath%>/member/myInterestProductDelete.cc",
 				type: "post",
 				data: {"interestno":interestno},
 				dataType: "JSON",
 				success:function(json){},
 				error: function(request, status, error){
			           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			    }
 			}); // end of $.ajax({----------
 			
			var result=confirm(productname+"["+pcolor+"]를 관심상품에서 장바구니로 옮겼습니다.\n장바구니로 이동하시겠습니까?.");	
			if(result){
				location.href="<%=ctxPath%>/member/myCart.cc";	
			}
			else{
				location.href="<%=ctxPath%>/member/myInterestProduct.cc";	
			}	
	
 		}); // $("span.addCartOne").click(function(){---------------- 	
	 		
	 		
	 		
	}); // end of $(document).ready(function(){----------

</script>



<jsp:include page="../header.jsp" />
<jsp:include page="../mypageleftSide.jsp" />
<jsp:include page="myPageHeader.jsp" />
<div id="contents" style="border: solid 0px red; margin:20px 0px 100px 20px; width:80%;">

	<div id="title">관심상품 조회</div>
	<c:forEach var="interestPRequiredInfo" items="${interestPRequiredInfoList}">
		<table class="eachInterestProduct">
			<tr>
				<td><input type="hidden" class="interestno" value="${interestPRequiredInfo.interestno}" /></td>
				<td><input type="hidden" class="productid" value="${interestPRequiredInfo.productid}" /></td>
			</tr>
			<tr>
				<td colspan="9"><div style="background-color: #b4c6cb; height: 20px;"></div></td>
			</tr>
			<tr style="border-top: solid 1px #6d919c; border-bottom: solid 1px #6d919c;">
				<th style="width: 50px;">선택</th>
				<th style="width: 160px;">이미지</th>
				<th style="width: 230px;">상품정보</th>
				<th style="width: 80px;">색상</th>
				<th style="width: 110px;">판매가</th>
				<th style="width: 110px;">예상적립금</th>
				<th style="width: 150px;">배송비</th>
				<th style="width: 110px;">합계</th>
				<th>선택</th>
			</tr>
			<tr>
				<td rowspan="2" id="${interestPRequiredInfo.pnum}" class="pnum"><input type="checkbox" name="checkList" value="${interestPRequiredInfo.pnum}" /></td>
				<td rowspan="2"><img src="<%=ctxPath%>/images/${interestPRequiredInfo.pimage1}" width="110px" height="100px" class="interestProductImg" /></td>
				<td class="productname" id="${interestPRequiredInfo.productname}">${interestPRequiredInfo.productname}</td>
				<td rowspan="2" class="color" id="${interestPRequiredInfo.pnum}">${interestPRequiredInfo.pcolor}</td>
				<c:if test="${interestPRequiredInfo.salepercent eq 0}">
					<td class="price" style="padding-top:10px;" id="${cartRequiredInfo.price}"><fmt:formatNumber value="${interestPRequiredInfo.price}" pattern="#,###,###" />원</td>
				</c:if>
				<c:if test="${interestPRequiredInfo.salepercent ne 0}">
					<td style="text-decoration: line-through;" class="price" id="${interestPRequiredInfo.price}"><fmt:formatNumber value="${interestPRequiredInfo.price}" pattern="#,###,###" />원</td>
				</c:if>
				<td rowspan="2">${interestPRequiredInfo.point}&nbsp;point</td>
				<c:if test="${interestPRequiredInfo.doption eq '0'}">
					<td rowspan="2">무료배송</td>
				</c:if>
				<c:if test="${interestPRequiredInfo.doption eq '1'}">
					<td rowspan="2">3,000원</td>
				</c:if>
				<c:if test="${interestPRequiredInfo.doption eq '색상에 따라 상이'}">
					<td rowspan="2">색상에 따라 상이</td>
				</c:if>
				<td rowspan="2"><fmt:formatNumber value="${interestPRequiredInfo.saleprice}" pattern="#,###,###" />원</td>
				<td>
					<span class="funcBt addCartOne">&nbsp;&nbsp;&nbsp;&nbsp;장바구니&nbsp;&nbsp;&nbsp;&nbsp;</span>
				</td>
			</tr>
			<tr>
				<td style="border-top:solid 1px #a0aca0;">[${interestPRequiredInfo.cname}]&nbsp;[${interestPRequiredInfo.modelname}]</td>
				<c:if test="${interestPRequiredInfo.salepercent eq 0}">
					<td class="salePrice" rowspan="2" id="0"></td>
				</c:if>
				<c:if test="${interestPRequiredInfo.salepercent ne 0}">
					<td style="color:red;" class="salePrice" id="${interestPRequiredInfo.saleprice}"><fmt:formatNumber value="${interestPRequiredInfo.saleprice}" pattern="#,###,###" />원</td>
				</c:if>
				<td><span class="funcBt deleteOne">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;삭제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
			</tr>
			<tr>
				<td colspan="9"><div style="background-color: #b4c6cb; height: 20px;"></div></td>
			</tr>
		</table>
	</c:forEach>

	<div>
		<span id="box">
			선택상품을
			<span class="bottomBt" id="deleteSelected" style="width: 100px; margin-left: 20px;">삭제하기</span>
			<span class="bottomBt" id="addCartSelected" style="margin-left: 10px; width: 110px;">장바구니담기</span>
		</span>
		<span class="bottomBt" id="checkAll" style="margin-left: 340px;">전체상품 선택하기</span>
		<span class="bottomBt" id="uncheckAll" style="margin-left: 340px;">전체상품 선택해제</span>
		<span class="bottomBt" style="margin-left: 20px;" id="continueShopping">쇼핑계속하기</span>
	</div>

</div>
<jsp:include page="../footer.jsp" />
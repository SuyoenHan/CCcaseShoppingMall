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
		width: 1200px;
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
		border: solid 2px #6d919c;
		text-align: center;
	}
	
	td.cartUpdate > span:hover{
		background-color: #6D919C;
		color: #fff;
		font-weight: bold;
	}
	
	div#delete > span{
		border: solid 0px red;
		display: inline-block;
		width: 160px;
		height: 40px;
		font-size: 13pt;
		text-align: center;
		padding-top: 8px;
		background-color: #98B7C1;
		margin-left: 100px;
		font-weight: bold;
	}
	
	div#delete > span:hover{
		background-color: #4d7380;
		color:#fff;
		font-weight: bold;
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
		background-color: #98B7C1;
		margin-left: 580px;
		margin-top: 10px;
		text-align: center;
		font-size: 13pt;
		font-weight: bold;
		padding-top: 15px;
	}
	
	div.bottomBt:hover{
		background-color: #4d7380;
		color:#fff;
		font-weight: bold;
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
			 
		// ?????? ??? ?????? ?????? ?????? ?????? ?????????	 
	 	$("td.cartUpdate > span").click(function(){
	 		
	 		var cartno= $(this).parent().parent().parent().find("input.cartno").val();
	 		var pnum= $(this).parent().parent().prev().find("td.pnum").prop('id');
	 		var productid= $(this).parent().parent().parent().find("input.productid").val();
	 		var cinputcnt= $(this).parent().parent().prev().find("td.cinputcnt").prop('id');
			location.href="<%=ctxPath%>/product/productDetail.cc?productid="+productid+"&cartno="+cartno+"&pnum="+pnum+"&cinputcnt="+cinputcnt;	 		
	 		
	 	}); // end of $("div.cartUpdate > span").click(function(){-----------
	 	

	 	// ???????????? ????????? ?????? ?????? ?????????
	 	$("span#deleteAll").click(function(){
	 		
	 		var userid= "${userid}";
	 		
	 		var result= confirm("??????????????? ??????????????????????");
			if(result){
				$.ajax({
		 			url: "<%=ctxPath%>/member/myCartDeleteAll.cc",
		 			type:"post",
		 			data:{"userid":userid},
		 			dataType:"JSON",
		 			success:function(json){
		 				if(json.n>=1){
		 					alert("??????????????? ???????????????");
		 					location.href="<%=ctxPath%>/member/myCart.cc"
		 				}
		 			},
		 			error: function(request, status, error){
				           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				    }
		 		}); // end of $.ajax({----------------------------- 			
			} // end of if----------------------------------------
			
	 	}); // end of $("span#deleteAll").click(function(){----------------------------
	 	
	 	
	 	// ?????????????????? ?????? ?????? ?????????
	 	$("span#continueShopping").click(function(){
	 		
	 		location.href="javascript:history.back()";
	 		
	 	}); // end of $("span#continueShopping").click(function(){---------------------
	 	
	 	
	 	// ???????????? ???????????? ?????? ?????????
	 	$("span#deleteSelected").click(function(){
	 		
	 		var checkcnt= $("input:checkbox[name=checkList]:checked").length;
	 		
	 		if(checkcnt==0){
	 			alert("????????? ????????? ????????????.");
	 		}
	 		else{
		 		var result= confirm("?????????????????? "+checkcnt+"?????? ????????? ?????????????????????????");
		 		if(result){ // ?????????????????? ???????????? ??????
	 				
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
			 		
			 		alert(checkcnt+"?????? ????????? ??????????????????."); // alert 1?????? ????????? ?????? each ????????? ??????
				 	location.href="<%=ctxPath%>/member/myCart.cc";		
		 		}
		 	}
	 	}); // end of $("span#deleteSelected").click(function(){-----------------------
	 	
	 	
	 	// ???????????? ???????????? ?????? ?????????
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
		 		
		 		if(doption=='????????? ?????? ??????'){
		 			dFee='????????? ?????? ??????';
		 			return true;
		 		}
		 		else if(doption=="1"){
		 			dFee="+ 3,000???";
		 			return false;
		 		}
		 		dFee="+ 0???";
		 	});
		 	
		 	totalDiscountPrice= totalPrice-finalPrice;
		 	
		 	$("td#totalPrice").text((totalPrice.toLocaleString('en'))+" ???");
		 	$("td#dFee").html("<span style='color:blue;'>"+dFee+"</span>");
		 	$("td#totalDiscountPrice").html("<span style='color:red;'>"+(totalDiscountPrice.toLocaleString('en'))+" ???</span>");
		 	$("td#finalPrice").text((finalPrice.toLocaleString('en'))+" ???");
		 	
	 	}); // end of $("span#checkAll").click(function(){-----------------------------
	 	
	 	

	 	// ???????????? ???????????? ?????? ?????????
	 	$("span#uncheckAll").click(function(){
	 		 $("input:checkbox[name=checkList]").prop("checked",false);	
	 		 $("span#uncheckAll").hide();
	 		 $("span#checkAll").show();
	 		 
	 	 	totalPrice=0;
		 	dFee="-";
		 	totalDiscountPrice=0;
		 	finalPrice=0;
		 	
			$("td#totalPrice").text((totalPrice.toLocaleString('en'))+" ???");
		 	$("td#dFee").html("<span style='color:blue;'>"+dFee+"</span>");
		 	$("td#totalDiscountPrice").html("<span style='color:red;'>"+(totalDiscountPrice.toLocaleString('en'))+" ???</span>");
		 	$("td#finalPrice").text((finalPrice.toLocaleString('en'))+" ???");
		 	
		 	
	 	}); // end of $("span#uncheckAll").click(function(){-----------------------------
	 		
	 	
	 	// ??????????????? ??????????????? ?????? ??????????????? ????????? ???????????? ???????????? ?????? ??????, ???????????? ????????? ???????????? ????????? ???????????? ???????????? ?????? ??????
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
	 	
	 		
	 		
	 		
	 	// ????????? ???????????? ???????????????, ????????????, ???????????????, ?????????????????? ?????????
	 	
	 	totalPrice=0;
	 	dFee="-";
	 	totalDiscountPrice=0;
	 	finalPrice=0;
	 	
		$("td#totalPrice").text(totalPrice+" ???");
	 	$("td#dFee").html("<span style='color:blue;'>"+dFee+"</span>");
	 	$("td#totalDiscountPrice").html("<span style='color:red;'>"+totalDiscountPrice+" ???</span>");
	 	$("td#finalPrice").text(finalPrice+" ???");
		 	
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
		 		
		 		if(doption=='????????? ?????? ??????'){
		 			dFee='????????? ?????? ??????';
		 			return true;
		 		}
		 		else if(doption=="1"){
		 			dFee="+ 3,000???";
		 			return false;
		 		}
		 		dFee="+ 0???";
		 	});
		 	
		 	totalDiscountPrice= totalPrice-finalPrice;
		 	
		 	$("td#totalPrice").text((totalPrice.toLocaleString('en'))+" ???");
		 	$("td#dFee").html("<span style='color:blue;'>"+dFee+"</span>");
		 	$("td#totalDiscountPrice").html("<span style='color:red;'>"+(totalDiscountPrice.toLocaleString('en'))+" ???</span>");
		 	$("td#finalPrice").text((finalPrice.toLocaleString('en'))+" ???");
		 	
		}); // end of $("input:checkbox[name=checkList]").click(function(){------------  	
		
			
		// ?????????????????? ???????????? ????????????
		$("div#orderSelected").click(function(){
			  
			var checkcnt= $("input:checkbox[name=checkList]:checked").length;
			if(checkcnt==0) {
				alert("????????? ????????? ????????????.");	
			}	
			else if(checkcnt>0){
						
	 			var flag= false;
 	        	$("input:checkbox[name=checkList]:checked").each(function(index,item){
 	        		var pnum= $(item).val();
 	        		
 	        		if("-"==pnum){ // ????????? ???????????? ?????? ??????
			 			flag=true;
			 			return false; // each??? break
			 		}
 	        	}); // end of each--------------------------------------------------
		 		
			 	if(flag){
			 		alert("?????? ????????? ???????????? ?????? ????????? ???????????????. \n????????? ????????? ?????????.");
			 		return false;
			 	}	
			 	else{ // ????????? ????????? ?????? => ????????? ??????

			 		 var pnumArr = new Array();
	         		 var cntArr = new Array();
	         		 var productnameArr = new Array();
	         		 var pcolorArr = new Array();
	         		 var cartnoArr= new Array();
	         		 
			 		 $("input:checkbox[name=checkList]:checked").each(function(index,item){
			 			
				 		var pnum= $(item).val();
			 			var cnt= $(item).parent().parent().find("td.cinputcnt").prop('id');
			 			var productname=$(item).parent().parent().find("td.productname").prop('id');
			 			var pcolor= $(item).parent().parent().find("td.color").prop('id');
			 			var cartno=$(item).parent().parent().parent().find("input.cartno").val();
			 			  
			 			pnumArr.push(pnum);
			 			cntArr.push(cnt);
			 			productnameArr.push(productname);
			 			pcolorArr.push(pcolor);
					 	cartnoArr.push(cartno);
					 	
					 }); // end of each----------------------------
					
				     // ????????? ???????????? ????????? ?????????
 	                 var str_pnumArr= pnumArr.join();
 	          	     var str_cntArr= cntArr.join();
 	          	     var str_productnameArr= productnameArr.join();
 	          	     var str_pcolorArr= pcolorArr.join();
 	          	     var str_cartno= cartnoArr.join();
 	          	   
	         	
			 		$.ajax({ // ???????????????
			 			url: "<%=ctxPath%>/product/checkProductQty.cc",
						type: "post",
						data: {"str_pnumArr": str_pnumArr,"str_cntArr":str_cntArr,"str_productnameArr":str_productnameArr,"str_pcolorArr":str_pcolorArr},
						dataType: "JSON",
						success:function(json){
							if(json.n==1){
								alert(json.productname+"["+json.pcolor+"]??? ???????????? "+json.qty+"?????????. ?????? ????????? ????????? ?????????!")
								return;
							}
							else{
				 	          	location.href="<%=ctxPath%>/order/payOrderMain.cc?pnum="+str_pnumArr+"&cnt="+str_cntArr+"&cartno="+str_cartno;
					          	return; 	
							}
						},
						error: function(request, status, error){
						    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						}
				     }); // end of $.ajax({---------------------
 	         		
		 		}// end of else-----------------------
			}// end of elseif------------------------------------------------------
		}); // end of $("div#orderAll").click(function(){
		
			
		// ?????????????????? ???????????? ????????????
		$("div#orderAll").click(function(){
						
 			var flag= false;
        	$("input:checkbox[name=checkList]").each(function(index,item){
        		var pnum= $(item).val();
        		
        		if("-"==pnum){ // ????????? ???????????? ?????? ??????
	 			flag=true;
	 			return false; // each??? break
	 			}
        	}); // end of each--------------------------------------------------
	 		
		 	if(flag){
		 		alert("?????? ????????? ???????????? ?????? ????????? ???????????????. \n????????? ????????? ?????????.");
		 		return false;
		 	}	
		 	else{ // ????????? ????????? ?????? => ????????? ??????

		 		 var pnumArr = new Array();
         		 var cntArr = new Array();
         		 var productnameArr = new Array();
         		 var pcolorArr = new Array();
         		 var cartnoArr= new Array();
         		 
		 		 $("input:checkbox[name=checkList]").each(function(index,item){
		 			
			 		var pnum= $(item).val();
		 			var cnt= $(item).parent().parent().find("td.cinputcnt").prop('id');
		 			var productname=$(item).parent().parent().find("td.productname").prop('id');
		 			var pcolor= $(item).parent().parent().find("td.color").prop('id');
		 			var cartno=$(item).parent().parent().parent().find("input.cartno").val();
		 			  
		 			pnumArr.push(pnum);
		 			cntArr.push(cnt);
		 			productnameArr.push(productname);
		 			pcolorArr.push(pcolor);
				 	cartnoArr.push(cartno);
				 	
				 }); // end of each----------------------------
				
			     // ????????? ???????????? ????????? ?????????
                 var str_pnumArr= pnumArr.join();
          	     var str_cntArr= cntArr.join();
          	     var str_productnameArr= productnameArr.join();
          	     var str_pcolorArr= pcolorArr.join();
          	     var str_cartno= cartnoArr.join();
          	   
         	
		 		$.ajax({ // ???????????????
		 			url: "<%=ctxPath%>/product/checkProductQty.cc",
					type: "post",
					data: {"str_pnumArr": str_pnumArr,"str_cntArr":str_cntArr,"str_productnameArr":str_productnameArr,"str_pcolorArr":str_pcolorArr},
					dataType: "JSON",
					success:function(json){
						if(json.n==1){
							alert(json.productname+"["+json.pcolor+"]??? ???????????? "+json.qty+"?????????. ?????? ????????? ????????? ?????????!")
							return;
						}
						else{
			 	          	location.href="<%=ctxPath%>/order/payOrderMain.cc?pnum="+str_pnumArr+"&cnt="+str_cntArr+"&cartno="+str_cartno;
				          	return; 	
						}
					},
					error: function(request, status, error){
					    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
			     }); // end of $.ajax({---------------------
	         		
	 		}// end of else-----------------------
	
		}); // end of $("div#orderAll").click(function(){
			
	}); // end of $(document).ready(function(){-------------------------

</script>

<jsp:include page="../header.jsp" />
<div id="contents" style="clear:both; margin-top:50px; width:100%;">
	
	<div id="cartTitle"><span style="color:#003399; font-weight: bold;">${name}</span>??????&nbsp;????????????</div>
	
	<c:forEach var="cartRequiredInfo" items="${cartRequiredInfoList}">
		<table class="eachWishList">
			<tr>
				<td><input type="hidden" class="cartno" value="${cartRequiredInfo.cartno}" /></td>
				<td><input type="hidden" class="productid" value="${cartRequiredInfo.productid}" /></td>
				<td><input type="hidden" class="doption" value="${cartRequiredInfo.doption}" /></td>
			</tr>
			<tr>
				<td colspan="9"><div style="background-color: #b4c6cb; height: 20px;"></div></td>
			</tr>
			<tr style="border-top: solid 1px #6d919c; border-bottom: solid 1px #6d919c;">
				<th style="width: 70px;">??????</th>
				<th style="width: 160px;">?????????</th>
				<th style="width: 230px;">????????????</th>
				<th style="width: 90px;">??????</th>
				<th style="width: 130px;">??????</th>
				<th style="width: 110px;">?????????</th>
				<th style="width: 130px;">???????????????</th>
				<th style="width: 150px;">?????????</th>
				<th>??????</th>
			</tr>
			<tr>
				<td rowspan="2" id="${cartRequiredInfo.pnum}" class="pnum"><input type="checkbox" name="checkList" value="${cartRequiredInfo.pnum}" /></td>
				<td rowspan="2"><img src="<%=ctxPath%>/images/${cartRequiredInfo.pimage1}" width="110px" height="100px" class="cartImg" /></td>
				<td class="productname" id="${cartRequiredInfo.productname}">${cartRequiredInfo.productname}</td>
				<td class="color" id="${cartRequiredInfo.pcolor}">${cartRequiredInfo.pcolor}</td>
				<td class="cinputcnt" id="${cartRequiredInfo.cinputcnt}">
					<input type="number" min="1" max="50" value="${cartRequiredInfo.cinputcnt}"??? class="pcnt">&nbsp;&nbsp;???
				</td>
				<c:if test="${cartRequiredInfo.salepercent eq 0}">
					<td class="price" id="${cartRequiredInfo.price}" style="padding-top:10px;"><fmt:formatNumber value="${cartRequiredInfo.price}" pattern="#,###,###" />???</td>
				</c:if>
				<c:if test="${cartRequiredInfo.salepercent ne 0}">
					<td style="text-decoration: line-through;" class="price" id="${cartRequiredInfo.price}"><fmt:formatNumber value="${cartRequiredInfo.price}" pattern="#,###,###" />???</td>
				</c:if>
				<td rowspan="2">${cartRequiredInfo.point}&nbsp;point</td>
				<c:if test="${cartRequiredInfo.doption eq '0'}">
					<td rowspan="2">????????????</td>
				</c:if>
				<c:if test="${cartRequiredInfo.doption eq '1'}">
					<td rowspan="2">3,000???</td>
				</c:if>
				<c:if test="${cartRequiredInfo.doption eq '????????? ?????? ??????'}">
					<td rowspan="2">????????? ?????? ??????</td>
				</c:if>
				<td rowspan="2" style="font-weight:bold;"><fmt:formatNumber value="${cartRequiredInfo.totalPrice}" pattern="#,###,###" />???</td>
			</tr>
			<tr>
				<td style="border-top:solid 1px #a0aca0;">[${cartRequiredInfo.cname}]&nbsp;[${cartRequiredInfo.modelname}]</td>
				<td colspan="2" class="cartUpdate"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;?????? ??? ?????? ??????&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
				<c:if test="${cartRequiredInfo.salepercent eq 0}">
					<td class="salePrice" rowspan="2" id="0"></td>
				</c:if>
				<c:if test="${cartRequiredInfo.salepercent ne 0}">
					<td style="color:red; font-weight: bold;" class="salePrice" id="${cartRequiredInfo.saleprice}"><fmt:formatNumber value="${cartRequiredInfo.saleprice}" pattern="#,###,###" />???</td>
				</c:if>
				
			</tr>
			<tr>
				<td colspan="9"><div style="background-color: #b4c6cb; height: 20px; border-top: solid 1px #6d919c; "></div></td>
			</tr>
		</table>
	</c:forEach>
	
	<div id="delete">
		<span id="deleteSelected">???????????? ????????????</span>
		<span id="deleteAll" style="margin-left: 20px;">???????????? ?????????</span>
		<span id="checkAll" style="margin-left: 520px;">???????????? ????????????</span>
		<span id="uncheckAll" style="margin-left: 520px;">???????????? ????????????</span>
		<span style="margin-left: 20px;" id="continueShopping">??????????????????</span>
	</div>
	
	<table id="priceInfo">
		<tr>
			<th>???????????????</th>
			<th>????????????</th>
			<th>???????????????</th>
			<th>??????????????????</th>
		</tr>
		<tr>
			<td id="totalPrice"></td>
			<td id="dFee"></td>
			<td id="totalDiscountPrice"></td>
			<td id="finalPrice"></td>
		</tr>
	</table>
	
	<div class="bottomBt" id="orderAll" style="margin-top:70px;">???????????? ????????????</div>
	<div class="bottomBt" id="orderSelected"  style="margin-bottom:100px;">???????????? ????????????</div>
	
</div>
<jsp:include page="../footer.jsp" />

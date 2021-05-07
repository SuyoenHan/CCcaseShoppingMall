<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath= request.getContextPath();
%>
<style type="text/css">

	div#contentTitle{
		width: 1100px;
		height: 100px;
		border: solid 0px black;
		background-color: #cbcdcb;
		margin-top: 15px;
		margin-left: 15px;
		padding-top: 20px;
	}

	select#modelName{
		border:solid 1px gray;
		width:200px;
		height: 35px;
	}
	
	div.productOuter{
		border: solid 0px red;
		float:left;
		margin: 0px 0px 100px 60px;
		width:210px;
		height: 300px;
	}
	
	span.netPrice{
		text-decoration: line-through;
		font-size: 10pt;
	}
	
	span.salePrice{
		color:red;
		font-weight: bold;
		font-size: 10pt;
	}
	
	div.productName{
		margin: 15px 0px;
		font-size: 11pt;
		border-bottom: solid 2px #caceca;
		padding-bottom: 10px;
	}
	
	span.spec{
		display: inline-block;
		width:40px;
		height:25px;
		border: solid 0px red;
		color: #fff;
		font-weight: bold;
		margin-top:10px;
		margin-right: 5px;
	}
	
	span.best{
		background-color: #009900;
	}
	
	span.new{
		background-color: #cc8800;
	}

	img.pmoImg{
		width: 30px;
		height: 30px;
		margin-top:5px;
		margin-right: 10px;
	}
	
	div.productOuter:hover  img.pImg{
		box-shadow: 5px 5px 5px 5px;
	}
	
	div.discountInfo{
		width: 100px;
		height: 40px;
		color: #fff;
		font-weight: bold;
		font-size: 18pt;
		padding-top: 10px;
		position: relative;
		top: 40px;
		background-color: #333300;
		float:right;
	}
	
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		func_height();
		$("div.hideIcon").hide();
		$("div.discountInfo").css("opacity","0");
		
		if("${modelName}" !=""){ // select 태그의 기종선택으로, 해당페이지에 다시 온 경우
			$("select#modelName").val("${modelName}");
		}
		
		$("select#modelName").bind('change',function(){
			
			var mdFrm= document.mdFrm;
			mdFrm.method= "GET";
			
			// [기종을 선택하세요]을 선택한 경우 ==> 해당 회사와 카테고리의 모든 기종 다 표시
			mdFrm.action= "<%=ctxPath%>/product/productList.cc"; 
			mdFrm.submit();
			
		}); // $("select#modelDropdown").bind('change',function(){
			
			
		
		// 제품이미지 마우스 오버시 할인율, 장바구니아이콘, 자세히보기 아이콘 표시
		$("div.productOuter").hover(function(){
			
			$(this).find("div.hideIcon").show();
			$(this).find("div.discountInfo").css("opacity","1");
			
		},function(){  // end of mouseover event-------------
			
			$(this).find("div.hideIcon").hide();
			$(this).find("div.discountInfo").css("opacity","0");
		
		}); // end of mouseout & hover event----------------	
		
		
		
		// 제품 클릭시 해당 제품 상세페이지로 이동
		$("div.productInner").click(function(){		
			var pIdForLink= $(this).find("input.linkInfo").val();
			location.href="<%=ctxPath%>/product/productDetail.cc?productid="+pIdForLink+"&goBackURL=${requestScope.goBackURL}";
		});
		
		
		// 장바구니 아이콘 클릭시 장바구니에 담기
		$("img.cart").click(function(){

			var productid= $(this).parent().prev().find("input.linkInfo").val();
			var productname=  $(this).parent().prev().find("div.productName").prop('id');
			
			$.ajax({
				url: "<%=ctxPath%>/member/myCartInsert.cc",
				type: "post",
				data: {"productid":productid,"pnum":"-","pcnt":"1","userid":"${loginuser.userid}"},
				dataType: "JSON",
				success:function(json){
		
					if(json.n==1){
						
						// 확인 또는 취소를 선택할 수 있는 있는 선택창
						var result= confirm("[ "+productname+" ] 을 "+json.message+"\n"
								           +"장바구니로 이동하시겠습니까?");
						if(result){ // 확인버튼
							location.href="<%=ctxPath%>/member/myCart.cc";
							return;
						}
						else{ // 취소버튼
							opener.location.reload(true);
						}
					}
					else if(json.n==2){
						var result= confirm(json.message+"\n장바구니로 이동하시겠습니까?");
						if(result){ // 확인버튼
							location.href="<%=ctxPath%>/member/myCart.cc";
							return;
						}
						else{ // 취소버튼
							opener.location.reload(true);
						}							
					}
					else{
						alert(json.message);
						opener.location.reload(true);
					}
					
				},
				error: function(request, status, error){
			           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			    }
			
			});// end of $.ajax({
			
		}); // end of $("img.cart").click(function(){---------------------
		
			
	    // 자세히보기 이미지 클릭시 해당 제품의 자세히보기 페이지로 이동
	    $("img.pdetailPage").click(function(){
	    	var productid= $(this).parent().prev().find("input.linkInfo").val();
	    	location.href="<%=ctxPath%>/product/productDetail.cc?productid="+productid+"&goBackURL=${requestScope.goBackURL}";
	    }); // end of $("img.cart").click(function(){---------------------
		
	}); // end of $(document).ready(function(){----------------------------
			
</script>

<jsp:include page="../header.jsp" />
<jsp:include page="../productListLeftSide.jsp" />

<div id="contents" style="margin-bottom: 100px;">
	
	<div id="contentTitle" align="center">
		<c:if test="${empty modelName}">
			<span style="font-size: 30pt; font-weight: bold;" >${cname}&nbsp;&nbsp;[${mname}]</span>
		</c:if>
		<c:if test="${!empty modelName}">
			<span style="font-size: 30pt; font-weight: bold;" >${cname}&nbsp;&nbsp;[${mname}&nbsp;${modelName}]</span>
		</c:if>
	</div>

	<div align="right" style="margin-top: 50px; ">
		<form name="mdFrm" method="get">
			<input type="hidden" name="cnum" value="${cnum}" />
			<input type="hidden" name="mnum" value="${mnum}" />
			<select name="modelName" id="modelName">
				<option value="" selected>&nbsp;&nbsp;&nbsp;기종을 선택하세요</option>
				<c:forEach var="modelName" items="${modelNameList}">
					<option value="${modelName}">&nbsp;&nbsp;&nbsp;${modelName}</option>
				</c:forEach>
			</select>
		</form>
	</div>

	<div style="border: solid 0px red;">
	 	
	 	<%-- 상품 한줄에 4개씩 배치 --%>
		<c:forEach var="pInfoMap" items="${pInfoList}" varStatus="status">
			
			<div class="productOuter" align="center">
				<div class="productInner">
					<input type="hidden" class="linkInfo" value="${pInfoMap.productid}" />
				    <div class="discountInfo">${pInfoMap.salepercent}%</div>
					<img src="<%=ctxPath%>/images/${pInfoMap.pimage1}" class="pImg" width="210" height="200" />
					<div class="productName" id="${pInfoMap.productname}">[${cname}]&nbsp;[${pInfoMap.modelname}]<br>${pInfoMap.productname}</div>
					
					<div>
						<c:if test="${pInfoMap.salepercent eq '0'}">					
							<span class="netPrice" style="text-decoration: none;">정가: <fmt:formatNumber value="${pInfoMap.price}" pattern="#,###,###" />원</span>&nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${pInfoMap.salepercent ne '0'}">					
							<span class="netPrice">정가: <fmt:formatNumber value="${pInfoMap.price}" pattern="#,###,###" />원</span>&nbsp;&nbsp;&nbsp;
							<span class="salePrice">할인가: <fmt:formatNumber value="${pInfoMap.saleprice}" pattern="#,###,###" />원</span>
						</c:if>
					</div>
					
					<%-- fk_snum이 0이면 BEST 상품, 1이면 NEW 상품, -1이면 해당 없음 --%>
					<div style="float: left">
						<c:if test="${pInfoMap.spec == 'BEST'}">
							<span class="best spec">BEST</span>
						</c:if>
						
						<c:if test="${pInfoMap.spec == 'NEW'}">
							<span class="new spec">NEW</span>
						</c:if>
						
						<c:if test="${pInfoMap.spec == 'BEST/NEW'}">
							<span class="best spec">BEST</span>
							<span class="new spec">NEW</span>
						</c:if>	
					</div>
				</div>
				<div style="float: right" class="hideIcon">
					<img src="../images/product/cart.png" class="pmoImg cart" />
					<img src="../images/product/look.png" class="pmoImg pdetailPage" />
				</div>
		    </div>
		    
			<c:if test="${status.count%4 eq 0 || status.last}">
				<div style="clear: both;"></div>  <%-- 줄바꿈 용도 --%> 
			</c:if>
		</c:forEach>
	</div>
	
	<div style="height: 50px;" align="center">
		<span style=" border: solid 0px blue; font-size: 15pt;">${pageBar}</span>
	</div>
	
</div>
<jsp:include page="../footer.jsp" />




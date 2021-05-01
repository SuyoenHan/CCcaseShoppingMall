<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
			
			
		
		// 제품이미지 마우스 오버시 할인율, 장바구니아이콘, 자세히보기 아이콘 표시, 제품이미지 흐리게하기
		$("div.productOuter").hover(function(){
			
			$(this).find("div.hideIcon").show();
			$(this).find("div.discountInfo").css("opacity","1");
			$(this).find("img.pImg").css("opacity","0.5");
			
		},function(){  // end of mouseover event-------------
			
			$(this).find("div.hideIcon").hide();
			$(this).find("div.discountInfo").css("opacity","0");
			$(this).find("img.pImg").css("opacity","1");
		
		}); // end of mouseout & hover event----------------	
		
		
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
			
				<input type="hidden" value="${pInfoMap.productid}" />
			    <div class="discountInfo">${pInfoMap.salepercent}%</div>
				<img src="<%=ctxPath%>/images/product/${pInfoMap.pimage1}" class="pImg" id="${pInfoMap.productid}" width="210" height="200" />
				<div class="productName">[${cname}]&nbsp;[${pInfoMap.modelname}]<br>${pInfoMap.productname}</div>
				<hr>
				
				<div>
					<span class="netPrice">정가: ${pInfoMap.price}</span>&nbsp;&nbsp;&nbsp;
					<span class="salePrice">할인가: ${pInfoMap.saleprice}</span>
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
				
				<div style="float: right" class="hideIcon">
					<img src="../images/product/cart.png" class="pmoImg"/>
					<img src="../images/product/look.png" class="pmoImg"/>
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




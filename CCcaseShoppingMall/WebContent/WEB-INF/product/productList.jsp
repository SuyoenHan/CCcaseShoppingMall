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
		margin-left: 15px;
		padding-top: 20px;
	}

	select#modelDropdown{
		border:solid 1px gray;
		width:200px;
		height: 35px;
	}
	
	div.productOuter{
		border: solid 0px red;
		display: inline-block;
		margin: 0px 0px 90px 60px;
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

</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		func_height();
	});
			
</script>

<jsp:include page="../header.jsp" />
<jsp:include page="../leftSide.jsp" />

<div id="contents">
	
	<div id="contentTitle" align="center">
		<span style="font-size: 30pt; font-weight: bold;" >${cname}&nbsp;&nbsp;[${mname}]</span>
	</div>

	<div align="right" style="margin: 50px 0px; ">
		<select id="modelDropdown">
			<option>&nbsp;&nbsp;&nbsp;기종을 선택하세요</option>
			<c:forEach var="modelName" items="${modelNameList}">
				<option>&nbsp;&nbsp;&nbsp;${modelName}</option>
			</c:forEach>
		</select>
	</div>

 	<%-- 상품 한줄에 4개씩 배치 --%>
	<c:forEach var="pInfoMap" items="${pInfoList}" varStatus="status">
		<c:if test="${status.count%4 ne 0}"> 
			<div class="productOuter" align="center">
				<img src="<%=ctxPath%>/images/product/${pInfoMap.pimage1}" width="210" height="200" />
				<div class="productName">[${pInfoMap.modelname}]&nbsp;&nbsp;${pInfoMap.productname}</div>
				<hr>
				<span class="netPrice">정가: ${pInfoMap.price}</span>&nbsp;&nbsp;&nbsp;
				<span class="salePrice">할인가: ${pInfoMap.saleprice}</span>
			</div>
		</c:if>
		
		<c:if test="${status.count%4 eq 0}">
			<div class="productOuter" align="center">
				<img src="<%=ctxPath%>/images/product/${pInfoMap.pimage1}" width="210" height="200" />
				<div class="productName">[${pInfoMap.modelname}]&nbsp;&nbsp;${pInfoMap.productname}</div>
				<hr>
				<span class="netPrice">정가: ${pInfoMap.price}</span>&nbsp;&nbsp;&nbsp;
				<span class="salePrice">할인가: ${pInfoMap.saleprice}</span>
			</div>
			<div></div>  <%-- 줄바꿈 용도 --%>
		</c:if>
	</c:forEach>
</div>
<jsp:include page="../footer.jsp" />




<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp" />
<jsp:include page="../communityLeftSide.jsp" /> 

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>  

<style>

div#container{
	width: 80%;
	margin-top:30px;
	margin-bottom:30px;
}


table{
	border: solid 1px gray;
	width:80%;
	height:100px;
}
th ,td{
border: solid 1px gray;
}

img



</style>


<script type="text/javascript">

	$(document).ready(function(){
		
	});
	
</script>


<div id="container">
<h1>배송조회 페이지 입니다</h1>


<table>
<c:forEach var="ovoList" items="${requestScope.ovoList}">
	<tr>
		<th style="width:100px;">주문번호:</th>
		<td>${ovoList.orderno}</td>
	</tr>
		<tr>
			<th>상품명</th>
			<td>${ovoList.pvo.productname}-${ovoList.pdvo.pcolor}</td>
		</tr>
		<tr>
			<th>수량: </th>
			<td>${ovoList.odvo.odqty}</td>
		</tr>
	</c:forEach>
</table>

<div><img src="/CCcaseShoppingMall/images/shipStatus/cj대한통운배송조회이미지.png" /></div>
<span style="color:#d9d9d9;">이미지 출처: cj대한통운</span>

<hr>
<button type="button" style="margin-top: 50px;" onclick="javascript:history.back();">주문목록</button>
</div>

<jsp:include page="../footer.jsp" />
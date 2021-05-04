<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />
<jsp:include page="../communityLeftSide.jsp"/>

<style type="text/css">

	#revBox {
		border: solid 1px black;
	}

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
		
	}); // end of $(document).ready(function(){})--------------------------------------
	
	// Function Declaration 
	
	// 이미지 보여주기
	function showBig(val) {
	 var obj = document.getElementById("big");
	  obj.src = "../images/" + val;
	} 

	function revEdit() {	
		location.href="<%=ctxPath%>/board/reviewEdit.cc"
	}
	
	function revDel() {
		location.href="<%=ctxPath%>/board/reviewDel.cc"
	}
	
</script>

<c:if test="${empty requestScope.rvo}">
	존재하지 않는 리뷰입니다.<br>
</c:if>

<c:if test="${not empty requestScope.rvo}">

<div id="title"> 
	커뮤니티
</div>

<h3>고객리뷰</h3>
<div class="row">

	<div id="revImg" class="col-md-3 line">
			<img src="../images/1.jpg" width="400" height="400" id="big"/>
			<br/><br/>
			<img src="../images/1.jpg" width="130" height="130" onmouseover="showBig('1.jpg');"/>
			<img src="../images/2.jpg" width="130" height="130" onmouseover="showBig('2.jpg');"/>
			<img src="../images/3.jpg" width="130" height="130" onmouseover="showBig('3.jpg');"/>
	</div>

<div class="col=md-9 line" align="left">
		<div id="prodInfo" >
			
		</div>

		<div id="reviewInfo">
			
			<span id="rating">
				<c:choose>
					<c:when test="${requestScope.rvo.satisfaction eq '1'}">
						★☆☆☆☆
					</c:when>
					<c:when test="${requestScope.rvo.satisfaction eq '2'}">
						★★☆☆☆
					</c:when>
					<c:when test="${requestScope.rvo.satisfaction eq '3'}">
						★★★☆☆
					</c:when>
					<c:when test="${requestScope.rvo.satisfaction eq '4'}">
						★★★★☆
					</c:when>
					<c:otherwise>
						★★★★★
					</c:otherwise>
				</c:choose>
			</span><br>
		
			<div id="revBox">
				<span>${sessionScope.loginuser.userid}&nbsp;|&nbsp;</span>
				<span>${requestScope.rvo.rregisterdate}&nbsp;|&nbsp;</span>			
				<span>${requestScope.rvo.rviewcount}&nbsp;|&nbsp;</span><br>	
				<span>${requestScope.rvo.rvtitle}</span><br>
				<p>${requesetScope.rvo.rvcontent}</p>
			</div>
		</div>
	</div>
</div>	
	
</c:if>
	
	
	
	<div id="btnRevList" align="right">
		<button type="button" onclick="javascript:location.href='<%= ctxPath%>/board/reviewList.cc' ">목록</button>
		<button type="button" onclick="revEdit()">수정</button><%-- 로그인 후에 보여질지 결정 --%>
		<button type="button" onclick="revDel()">삭제</button><%-- 로그인 후에 보여질지 결정 --%>
	</div>


<jsp:include page="../footer.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />
<jsp:include page="../communityLeftSide.jsp"/>

<style type="text/css">



</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
		
	}); // end of $(document).ready(function(){})--------------------------------------
	
	// Function Declaration 

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

	<div id="revImg">
		
	</div>

	<div id="reviewInfo">
		<ol>
			<li><span></span></li>	
		</ol>	
	
	</div>
</c:if>
	
	
	<div id="btnRevList" align="right">
		<button type="button" onclick="javascript:location.href='<%= ctxPath%>/board/reviewList.cc' ">목록</button>
		<button type="button" onclick="revEdit()">수정</button><%-- 로그인 후에 보여질지 결정 --%>
		<button type="button" onclick="revDel()">삭제</button><%-- 로그인 후에 보여질지 결정 --%>
	</div>


<jsp:include page="../footer.jsp" />
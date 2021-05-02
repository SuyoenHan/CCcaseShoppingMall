<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />
<jsp:include page="../communityLeftSide.jsp"/>

<style type="text/css">

		

</style>

<script type="text/javascript">

	$(document).ready(function(){
			
		
		
	});

	function goRevList() {
		location.href="<%= ctxPath%>/"+goBackURL;
	}
	
</script>

<c:if test="${empty requestScope.rvo}">
	존재하지 않는 리뷰입니다.<br>
</c:if>

<c:if test="${not empty requestScope.rvo}">
	
	<div id="imgSection"></div>
	
	<div id="showPord"></div>
	
	<div id="rvoInfo" float="left">
		
	</div>
		
	


</c:if>

	<div id="btnRevList" align="right">
		<button type="button" onClick="goRevList()">리뷰목록</button>
	</div>

<jsp:include page="../footer.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />
<jsp:include page="../communityLeftSide.jsp"/>

<style type="text/css">



</style>


	

<script type="text/javascript">


function goRevList() {
	location.href="<%= ctxPath%>/"+goBackURL;
}

</script>

<c:if test="">
	존재하지 않는 리뷰입니다.<br>
</c:if>

<c:if test="">


</c:if>

	<div id="btnRevList" align="right">
		<button type="button" onClick="">리뷰목록</button>
	</div>


<jsp:include page="../footer.jsp" />
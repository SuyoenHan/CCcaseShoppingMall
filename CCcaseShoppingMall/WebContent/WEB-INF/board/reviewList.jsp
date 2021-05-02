<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../header.jsp" />
<jsp:include page="../communityLeftSide.jsp"/>

<style>
	
	#description {
		font-size: 12pt;
		color: #a6a6a6;
	}
	

</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		$().click(function(){
			
			
			location.href="<%=ctxPath%>/board/reviewOneDetail.cc?subject="+subject+"&goBackURL=";
			
		});
		
		
	});

</script>

<h3>고객리뷰</h3>

<div>포토리뷰 모아보기(<span></span>)&nbsp;&nbsp;&nbsp;<span id="description">최근 1년간의 포토리뷰를 확인하세요</span></div>

<ul class="pager"><li><button type=button>&lt;</button></li><li><button type=button>&gt;</button></li></ul>

<div></div>

<form name="searchReviewFrm">
	<button type="button" id="searchReview" onClick=""><img src="../images/product/look.png">검색</button>
	<input type="text" id="searchProd" placeholder="제품명 입력"/>
</form>


<table>
	<tbody>
		<c:forEach var="" items="">
		<tr class="reviewInfo">
			<td></td>
		</tr>
		</c:forEach>
	</tbody>
</table>

<div style="text-align:center; padding: 20px 0;">
		${requestScope.pageBar}
</div>

<jsp:include page="../footer.jsp" />
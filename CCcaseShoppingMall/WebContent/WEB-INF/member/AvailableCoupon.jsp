<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../../WEB-INF/header.jsp" />
<jsp:include page="../../WEB-INF/mypageleftSide.jsp" />

<style type="text/css">


</style>

<script type="text/javascript">

	$(document).ready(function(){
		$("button#aval").click(function(){
			
		});
		
		$("button#notAval").click(function(){
			
			location.href="<%= ctxPath%>/member/"; <%-- 사용완료 쿠폰으로 이동--%>
		});
		
	});	
	
</script>

<h3>나의 쿠폰 조회</h3>
<hr>

<div>
	<button type="button" id="aval">사용가능 쿠폰(<span id="cnt"></span>)</button>
	<button type="button" id="notAval">사용완료 쿠폰(<span id="cnt"></span>)</button>
</div>

<table>
	<thead>
		<tr>
			<th>구분</th>
			<th>쿠폰명</th>
			<th>최소사용 금액</th>
			<th>할인 금액</th>
			<th>발행일</th>
			<th>유효기간</th>
			<th>남은 날짜</th>
		</tr>
	</thead>
	
	<tbody>
		<c:forEach var="map" items="">
			<tr class="couponInfo"><%-- 아래 내용 아직 예시 --%>
				<td>cpcontent</td>
				<td>cpname</td>
				<td>5,000원</td>
				<td>cpdiscount</td>
				<td>issuedate</td>
				<td>expirationdate</td><%-- 발행일로부터 14일 후 --%>
				<td>expirationdate-sysdate</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<jsp:include page="../../WEB-INF/footer.jsp" />




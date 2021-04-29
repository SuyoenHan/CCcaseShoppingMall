<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../../WEB-INF/header.jsp" />
<jsp:include page="../../WEB-INF/mypageleftSide.jsp" />

<style type="text/css">

	button.btn {
		border: none;
		width: 150px;
		padding: 10px 0;
		font-weight: bold;
		border-radius: 10px;
	}

	button:hover {
		background-color: #4d4d4d;
		color: white;
	}
	
</style>

<script type="text/javascript">

		$(document).ready(function(){

			$("button#aval").click(function(){
				location.href="<%= ctxPath%>/member/availableCoupon.cc"; <%-- 사용가능 쿠폰으로 이동--%>
			});
			
			$("button#unAval").click(function(){
				javascript:history.go(0);
			});
		
		});

</script>

<h3>나의 쿠폰 조회</h3>
<hr>

<br><br><br><br><br>

<div>
	<button type="button" id="aval" class="btn">사용가능 쿠폰(<span class="cnt">${requestScope.cnt}</span>)</button>
	<button type="button" id="unAval" class="btn">사용완료 쿠폰(<span class="cnt">${requestScope.cnt}</span>)</button>
</div>

<br>

<table id="memberTbl" class="table" style="align: center; width:80%; margin-top:20px;">
	<thead>
		<tr>
			<th>쿠폰번호</th>
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
	<c:set var="today"> <fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy-mm-dd" /></c:set>
	<c:if test="${requestScope.cvo.cpstatus eq '1' || requestScope.cvo.cpstatus eq '2'}">
		<c:forEach var="cvo" items="${requestScope.cvo}">
			<tr class="couponInfo"><%-- 아래 내용 아직 예시 --%>
				<td>${cvo.cpno}</td>
				<td>${cvo.cpcontent}</td>
				<td>${cvo.cpname}</td>
				<td>5,000원</td>
				<td>${cvo.cpdiscount}</td>
				<td>${cvo.issudate}</td>
				<td>${cvo.expirationdate}</td><%-- 발행일로부터 14일 후 --%>
				<td>D-(${cvo.expirationdate}-${today})</td>
			</tr>
		</c:forEach>
	</c:if>
	<c:if test=""></c:if>
	</tbody>
</table>


<jsp:include page="../../WEB-INF/footer.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../../WEB-INF/header.jsp" />
<jsp:include page="../../WEB-INF/mypageleftSide.jsp" />
<jsp:include page="../../WEB-INF/member/myPageHeader.jsp" />

<style type="text/css">
	
	div#btns {
		margin-left: 20px;
	}
	
	button.btn1 {
		border: none;
		width: 150px;
		padding: 10px 0;
		font-weight: bold;
		border-radius: 10px;
		margin-right: 10px;
	}
	
	button.btn1:hover {
		background-color: #4d4d4d;
		color: white;
	}
	
	div#myCouponList{
		background-color: #6D919C;
		
	}
	
	 div#myCouponList:hover{
		background-color: #CCF2F4;
		transition: 1s;
	}
	

</style>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.css" />

<script type="text/javascript">
	 

	$(document).ready(function(){
		
		func_height();
		
		$("button#aval").click(function(){
			location.href="<%= ctxPath%>/member/availableCoupon.cc"; <%-- 사용완료 쿠폰으로 이동--%>
		})
		
		$("button#unAval").click(function(){
			location.href="<%= ctxPath%>/member/unavailableCoupon.cc"; <%-- 사용완료 쿠폰으로 이동--%>
		});
		
		
		
		
	});	 // end of $(document).ready(function(){})---------------------------------------
	
	
</script>

<h3 style="font-weight: bold;">나의 쿠폰 조회</h3>
<hr style="background-color:black; height:1px;">

<br><br><br><br><br>

<div >

</div>


<div id="btns">
	<button type="button" id="aval" class="btn1">사용가능 쿠폰(<span class="cnt">${requestScope.acnt}</span>)</button>
	<button type="button" id="unAval" class="btn1">사용완료 쿠폰(<span class="cnt">${requestScope.ucnt}</span>)</button>
</div>

<br>

<table id="memberTbl" class="table" style="align: center; width:80%; margin-top:20px; ">
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
		
		<c:forEach var="cvo" items="${requestScope.cpList}">
			<tr class="couponInfo"><%-- 아래 내용 아직 예시 --%>
				<td>${cvo.cpno}</td>
				<td>
				<c:choose>
					<c:when test="${cvo.cpcontent eq '0'}">
						무료배송					
					</c:when>
					<c:otherwise>
						할인쿠폰
					</c:otherwise>	
				</c:choose></td>
				<td>${cvo.cpname}</td>
				<td>5,000원</td>
				<td>
					<c:if test="${cvo.cpdiscount ne '30'}"><fmt:formatNumber value="${cvo.cpdiscount*100}" pattern="0"/><span>%</span></c:if>
					<c:if test="${cvo.cpdiscount eq '30'}">무료배송(${cvo.cpdiscount*100})</c:if>
				</td>
				<td>${cvo.issuedate}</td>
				<td>${cvo.expirationdate}</td><%-- 발행일로부터 14일 후 --%>
				<td>
					<c:if test="${cvo.cpstatus eq '0'}">D-<span>${cvo.remaindate}</span></c:if>
					<c:if test="${cvo.cpstatus eq '1'}">사용완료</c:if>
					<c:if test="${cvo.cpstatus eq '2'}">기간만료</c:if>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<jsp:include page="../../WEB-INF/footer.jsp" />




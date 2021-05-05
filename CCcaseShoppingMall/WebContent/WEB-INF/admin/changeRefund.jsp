<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<jsp:include page="../adminheader.jsp" />



<style type="text/css">
	
	th {
		border:solid 1px black;
		width: 120px;
		font-size: 12pt;
		font-weight: bolder;
		text-align: center !important;
		background-color: #cccccc;
	}
	
	td {
		border:solid 1px black;
		text-align: center;
	}


</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		// leftside랑 content랑 길이 맞추기
		func_height();
		
		
		
		
	}); // end of $(document).ready(function(){


</script>

<div id="contents"> 
	
	<table>
		<thead> 
			<tr> 
				<th>일련번호</th>
				<th>주문번호</th>
				<th>제품상세번호</th>
				<th>제품상세명</th>
				<th>접수자ID</th>
				<th>접수일</th>
				<th>구분</th>
				<th>사유</th>
				<th>승인여부</th>
			</tr>
		</thead>
		
		<tbody>
			<c:forEach var="chRefundMap" items="${requestScope.chRefundList}">
				<tr> 
					<td>${chRefundMap.chRefundno}</td>
					<td>${chRefundMap.odetailno}</td>
					<td>${chRefundMap.pnum}</td>
					<td>${chRefundMap.pname}</td>
					<td>${chRefundMap.fk_userid}</td>
					<td>${chRefundMap.cregisterdate}</td>
					<td>
						<c:choose>
							<c:when test="${chRefundMap.sortno eq 0}">교환</c:when>
							<c:when test="${chRefundMap.sortno eq 1}">환불</c:when>
						</c:choose>
					</td>
					<td>${chRefundMap.whycontent}</td>
					<td><button type="button">승인</button></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<jsp:include page="../footer.jsp" />

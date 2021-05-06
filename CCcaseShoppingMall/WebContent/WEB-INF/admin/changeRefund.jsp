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
		
		
		$("button.goStatus").click(function(){
			
			var changeOrRefund = "";
			var name = $(this).parent().parent().find("td#fk_userid").text();
			var sortno = $(this).parent().parent().find("input#sortno").val();
			var odetailno = $(this).parent().parent().find("td#odetailno").text();
			
			if(sortno==0){
				changeOrRefund = "교환";
			}
			else{
				changeOrRefund = "환불";
			}
			

			var bool = confirm(name+"님의 "+changeOrRefund+"요청을 승인하시겠습니까?");
			
			if(bool){ //ajax를 통하여 url변동이 없이, 승인을 누르면 해당 행을 자동 삭제해주겠다.
				
				$.ajax({
					url:"<%=request.getContextPath()%>/admin/changeRefund.cc",
					type:"post",
					data:{"odetailno":odetailno,"sortno":sortno},
					dataType:"json",
					success:function(json){
						
						if(json.n==1){
							alert("승인이 완료되었습니다.");
							location.href="javascript:history.go(0)";	
						}
						
					},
				    error: function(request, status, error){
		               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		            } 
				});
				
			}
			else{
				   alert(" 승인을 취소하셨습니다.");
		    }
			
			
		});
		
		
		
	}); // end of $(document).ready(function(){


</script>

<div id="contents"> 
	
	<table>
		<thead> 
			<tr> 
				<th>일련번호</th>
				<th>주문번호</th>
				<th>주문상세번호</th>
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
					<td>${chRefundMap.orderno}</td>
					<td id="odetailno">${chRefundMap.odetailno}</td>
					<td>${chRefundMap.pnum}</td>
					<td>${chRefundMap.pname}</td>
					<td id="fk_userid">${chRefundMap.fk_userid}</td>
					<td>${chRefundMap.cregisterdate}</td>
					<td>
						<input type="hidden" id="sortno" value="${chRefundMap.sortno}"/>
						<c:choose>
							<c:when test="${chRefundMap.sortno eq 0}">교환</c:when>
							<c:when test="${chRefundMap.sortno eq 1}">환불</c:when>
						</c:choose>
					</td>
					<td>${chRefundMap.whycontent}</td>
					<td><button type="button" class="goStatus">승인</button></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<c:if test="${not empty requestScope.message}">
		<br>
		<span style="color:red; font-size:15pt; font-weight: bolder;">${requestScope.message}</span>
		<br>
	</c:if>
</div>

<jsp:include page="../footer.jsp" />

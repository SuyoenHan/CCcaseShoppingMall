<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<% String ctxPath=request.getContextPath(); %>

<jsp:include page="../adminheader.jsp" />  




<style>

	tr{
		border-bottom : solid 1px black;
		line-height: 50px;
	}
	
	th, td{
		border: solid 0px black;
		font-size : 13pt;
		width: 100px;
	}
	
	td.qtyComment {
		font-size:15pt !important;
		font-weight: bolder;
		width: 300px !important;
		border-right: solid 1px black;
	}

</style>

<script>

	$(document).ready(function(){
		
		// leftside랑 길이맞추기
		func_height();
		
		// 자바스크립트에서 session에서 담아온 값이, null일경우 ""으로 나오는 이슈가있음. => "" 하니깐?
		// 반대로 html 태그안에 바로 값을 넣어주면 0으로 잘나옴.
		
		// 문서를 자동으로 15초간격으로 새로고침 시키겠다.
		// 문서로딩시 func_loopTimer() 함수 호출
		
		var refresh = setInterval(function(){
			location.href="javascript:history.go(0)";
		},10000);
			
		
	}); // end of $(document).ready(function(){
		
	// Function Declaration


</script>

<div id="contents">
	<div id="container">
	
		<table class="salesQty">
			<thead>
				<tr>
					<th colspan="2">총 판매량</th>
				</tr>
			</thead>
				<tr> 
					<td class="qtyComment">전일</td>
					<td class="qtyComment">금일</td>
				</tr>
				<tr> 
					<td>${sessionScope.yesterdayPdQty}개</td>
					<td>${sessionScope.todayPdQty}개</td>
				</tr>
			</tbody>
		</table>
			
		<table class="salesAmount">	
			<thead>
				<tr>
					<th colspan="2">총 판매액</th>
				</tr>
			</thead>
			<tbody>			
				<tr> 
					<td class="qtyComment">전일</td>
					<td class="qtyComment">금일</td>
				</tr>
				
				<tr> 
					<td id="yProfit"><fmt:formatNumber value="${sessionScope.yProfit}" pattern="#,###" />원</td>
					<td id="tProfit"><fmt:formatNumber value="${sessionScope.tProfit}" pattern="#,###" />원</td>
				</tr>
			</tbody>
		</table>
		
		<table>
			<thead>
				<tr>
					<th colspan="2">금일 케이스별 판매량</th>
				</tr>
			</thead>
			<tbody>
				<tr> 
					<td>하드케이스</td>
					<td>${sessionScope.hardSaleQty}개</td>
				</tr>				
				<tr> 
					<td>젤리케이스</td>
					<td>${sessionScope.jellySaleQty}개</td>
				</tr>			
				<tr> 
					<td>범퍼케이스</td>
					<td>${sessionScope.bumpperSaleQty}개</td>
				</tr>
			</tbody>
		</table>
		
		<table class="totalMember">
			<thead>
				<tr>
					<th colspan="2">회원수</th>
				</tr>
			</thead>
			<tbody>
				<tr> 
					<td colspan="2">총회원수[${sessionScope.allMemberCnt}명] </td>
					<td>탈퇴회원수</td>
				</tr>
				
				<tr> 
					<td>활동중</td>
					<td>휴면</td>
					<td>${sessionScope.outMemberCnt}명</td>
				</tr>
				
				<tr> 
					<td>${sessionScope.activeMemberCnt}명</td>
					<td>${sessionScope.humanMemberCnt}명</td>
				</tr>
				<tr> 
					<td class="qtyComment">금일 가입회원수</td>
					<td>${sessionScope.todayRegisterCnt}명</td>
				</tr>
			</tbody>
		</table>
			
		<table>
			<tbody>	
				<tr> 
					<td class="qtyComment">QNA 미답변글수</td>
				</tr>
				<tr>
					<td>${sessionScope.noCmtCnt}개</td>
				</tr>				
			</tbody>
		</table>
	
	
	
	</div>
</div>
<jsp:include page="../footer.jsp" /> 
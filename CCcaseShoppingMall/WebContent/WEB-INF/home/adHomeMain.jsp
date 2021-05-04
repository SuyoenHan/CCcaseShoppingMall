<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<% String ctxPath=request.getContextPath(); %>

<jsp:include page="../adminheader.jsp" />  
<jsp:include page="../adminleftSide.jsp" />

<style>
	tr{
		border-bottom : solid 1px black;
		line-height: 50px;
	}
	
	td{
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
	
		<table>
			<tbody>
				<tr> 
					<td class="qtyComment">1. 전일 총 판매량</td>
					<td colspan="3">${sessionScope.yesterdayPdQty}개</td>
				</tr>
				<tr> 
					<td class="qtyComment">2. 금일 총 판매량</td>
					<td colspan="3">${sessionScope.todayPdQty}개</td>
				</tr>
				
				<tr> 
					<td class="qtyComment">3. 전일 총 판매액</td>
					<td colspan="3" id="yProfit"><fmt:formatNumber value="${sessionScope.yProfit}" pattern="#,###" />원</td>
				</tr>
				
				<tr> 
					<td class="qtyComment">4. 금일 총 판매액</td>
					<td colspan="3" id="tProfit"><fmt:formatNumber value="${sessionScope.tProfit}" pattern="#,###" />원</td>
				</tr>
				
				<tr> 
					<td rowspan="3" class="qtyComment">5. 금일 케이스별 판매량</td>
					<td>하드케이스</td>
					<td colspan="2">${sessionScope.hardSaleQty}개</td>
				</tr>
				
				
				<tr> 
					<td>젤리케이스</td>
					<td colspan="2">${sessionScope.jellySaleQty}개</td>
				</tr>
				
				<tr> 
					<td>범퍼케이스</td>
					<td colspan="2">${sessionScope.bumpperSaleQty}개</td>
				</tr>
				
				<tr> 
					<td rowspan="3" class="qtyComment">6. 회원수</td>
					<td>총회원수 </td>
					<td>${sessionScope.allMemberCnt}명</td>
					<td>탈퇴회원수</td>
				</tr>
				
				<tr> 
					<td>활동중</td>
					<td>휴먼</td>
					<td>${sessionScope.outMemberCnt}명</td>
				</tr>
				
				<tr> 
					<td>${sessionScope.activeMemberCnt}명</td>
					<td colspan="2">${sessionScope.humanMemberCnt}명</td>
				</tr>
				
				<tr> 
					<td class="qtyComment">7. 금일 가입회원수</td>
					<td colspan="3">${sessionScope.todayRegisterCnt}명</td>
				</tr>
				
				<tr> 
					<td class="qtyComment">8.QNA 미답변글수</td>
					<td colspan="3">${sessionScope.noCmtCnt}개</td>
				</tr>
				
			</tbody>
		</table>
	
	
	
	</div>
</div>
<jsp:include page="../footer.jsp" /> 
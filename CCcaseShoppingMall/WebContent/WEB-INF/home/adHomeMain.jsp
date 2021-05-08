<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<% String ctxPath=request.getContextPath(); %>

<jsp:include page="../adminheader.jsp" />  

<style>

	div#contents {
		display: table;
		margin-left: 10%;
		margin-bottom: 10%;
	}
	
	div.container-row{
		display: table-row;
	}

	div.tdstatus{
		display: table-cell;
		padding: 20px;
	}
	
	table{
		margin: 0 3% 5% 0;
		width: 300px;
		height: auto;
	}

	tr{
		line-height: 50px;
	}
	
	td{
		text-align: center;
		font-size : 13pt;
		width: 150px;
	}
	
	td.qtyComment {
		font-size:15pt !important;
		font-weight: bolder;
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


</script>
<div id="tatalControl">
<div id="contents">
	<div id="container">
		<div class="container-row">
			<div class="tdstatus">
			<table class="salesQty" style="border: 1px solid #D5E2E2; ">
				<thead style="background-color: #D5E2E2;">
					<tr>
						<th colspan="2" style="text-align: center; font-weight: bold; font-size: 25px;">총 판매량</th>
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
			</div>
			<div class="tdstatus">
			<table class="salesAmount" style="border: 1px solid #CAD9DF; margin-left: 5%;">	
				<thead style="background-color: #CAD9DF;">
					<tr>
						<th colspan="2" style="text-align: center; font-weight: bold; font-size: 25px;">총 판매액</th>
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
			</div>	
			<div class="tdstatus">
			<table style="border: 1px solid #AFCAD8; margin-left: 5%;">
				<thead style="background-color: #AFCAD8">
					<tr>
						<th colspan="3" style="width: 100%; text-align: center; font-weight: bold; font-size: 25px;">금일 케이스별 판매량</th>
					</tr>
				</thead>
				<tbody>
					<tr> 
						<td colspan="2">하드케이스</td>
						<td>${sessionScope.hardSaleQty}개</td>
					</tr>				
					<tr> 
						<td colspan="2">젤리케이스</td>
						<td>${sessionScope.jellySaleQty}개</td>
					</tr>			
					<tr> 
						<td colspan="2">범퍼케이스</td>
						<td>${sessionScope.bumpperSaleQty}개</td>
					</tr>
				</tbody>
			</table>
			</div>
		</div>
		<div class="container-row">
			<div class="tdstatus">
			<table class="totalMember" style="border: 1px solid #7EAAC0;">
				<thead style="background-color: #7EAAC0;">
					<tr>
						<th colspan="3" style="text-align: center; font-weight: bold; font-size: 25px;">회원수</th>
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
						<td rowspan="2">${sessionScope.outMemberCnt}명</td>
					</tr>
					
					<tr> 
						<td>${sessionScope.activeMemberCnt}명</td>
						<td>${sessionScope.humanMemberCnt}명</td>
					</tr>
					<tr> 
						<td class="qtyComment" colspan="2"  style="background-color: #7EAAC0;">금일 가입회원수</td>
						<td>${sessionScope.todayRegisterCnt}명</td>
					</tr>
				</tbody>
			</table>
			</div>
			<div class="tdstatus">
			<table style="border: 1px solid #93C0C3; margin-left: 5%;">
				<thead style="background-color: #93C0C3;">
					<tr>
						<th colspan="2" style="text-align: center; font-weight: bold; font-size: 25px;">게시물 현황</th>
					</tr>
				</thead>
				<tbody>	
					<tr> 
						<td style="width: 50%">공지사항</td>
						<td style="width: 50%">${sessionScope.noticeCnt}개</td>
					</tr>
					<tr> 
						<td>FAQ</td>
						<td>${sessionScope.faqCnt}개</td>
					</tr>
					<tr> 
						<td>QnA</td>
						<td>${sessionScope.qnaCnt}개</td>
					</tr>
					<tr>
						<td>QNA 미답변글수</td>
						<td>${sessionScope.noCmtCnt}개</td>
					</tr>				
				</tbody>
			</table>
			</div>
		</div>
	</div>
	</div>
</div>
<jsp:include page="../footer.jsp" /> 
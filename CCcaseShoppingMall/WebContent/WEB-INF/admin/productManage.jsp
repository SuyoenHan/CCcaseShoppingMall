<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../adminheader.jsp" />    

<style>
	div#leftSide{
		clear:both; 
	}
	
	th{
		border:solid 1px red;
		width:150px;
	}
	
	td{
		border:solid 1px red;
		text-align: left;
	}
</style>



<div id="contents">
	
	<table>
		<thead>
			<tr> 
				<th>상품번호</th>
				<th colspan="2">상품명</th>
				<th>색상</th>
				<th>제품정가</th>
				<th>제품판매가</th>
				<th>재고량</th>
				<th>제품입고일자</th>
				<th>배송조건</th>
				<th>추가 정보</th>
			</tr>
		</thead>
		
		<tbody>
			<tr> 
				<td>나나나나나나</td>
				<td colspan="2">나나나나나나나나나나나나나나나나나나</td>
				<td>나나나나나나</td>
				<td>나나나나나나</td>
				<td>나나나나나나</td>
				<td>나나나나나나</td>
				<td>나나나나나나</td>
				<td>나나나나나나</td>
				<td>나나나나나나</td>
				
			</tr>
		</tbody>
	
	</table>	



</div>


<jsp:include page="../footer.jsp" />
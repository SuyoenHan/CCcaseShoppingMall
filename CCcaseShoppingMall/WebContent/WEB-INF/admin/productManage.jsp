<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
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
			<c:forEach var="proMap" items="${requestScope.proList}">
				<tr>
					<td>${proMap.pnum}</td>
					<td colspan="2">${proMap.productname}</td>
					<td>${proMap.pcolor}</td>
					<td>${proMap.originalprice}원</td>
					<td>${proMap.saleprice}원</td>
					<td>${proMap.pqty}개</td>
					<td>${proMap.pinputdate}</td>
					<td>
						 <c:choose> 
							<c:when test="${proMap.doption eq '0'}">무료</c:when> 
						 </c:choose>
						 <c:choose> 
							<c:when test="${proMap.doption eq '1'}">유료</c:when> 
						 </c:choose>
					</td> 
					<td><button type="button">더보기</button></td>
				</tr>	
			</c:forEach>	
			
		</tbody>
	
	</table>	



</div>


<jsp:include page="../footer.jsp" />
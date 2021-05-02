<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
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

<script type="text/javascript">
	
	$(document).ready(function(){
	
		$("select#sizePerPage").val("${requestScope.sizePerPage}");
		
		
		var frm = document.search;

		// select태그로 보여줄 갯수를  정하는 이벤트
		$("select#sizePerPage").bind("change",function(){
			
			frm.action="<%= request.getContextPath() %>/admin/productmanage.cc";
			frm.submit();
			// method를 생략했으면 get방식

		});
		
		// == 검색어에 내가 선택한 값 표기하기 ==
		// 검색어에 공백이 아닌값을 검색할 경우에만 해당 값이 보이도록 받아와서 다시 값을 넣어주는 것이다.	
		if("${fn:trim(requestScope.searchWord)}"!=""){
	         $("select#searchType").val("${requestScope.searchType}");
	         $("input#searchWord").val("${requestScope.searchWord}");
	     }
		
		// 검색어에서 바로 엔터를 쳤을때도 값을 넘겨주도록 한다.
		$("input#searchWord").bind("keyup",function(event){
			
			if(event.keyCode == 13){
				frm.action="<%= request.getContextPath() %>/admin/productmanage.cc";
				frm.submit();
			}
			
		});
		
		// 검색어를 입력 후 검색버튼을 눌렀을때
		$("button#searchBtn").click(function(){
			
			frm.action="<%= request.getContextPath() %>/admin/productmanage.cc";
			frm.submit();
		})
		
		
		// 추가상품등록하기 버튼을 클릭했을때
		$("button#moreRegister").click(function(){
			
			var pnum = $(this).parent().parent().find("#pnum").text();
			var mname= ${requestScope.proList.mname};
			var productname= ${requestScope.proList.productname};
			var cname= ${requestScope.proList.cname};
			var salepercent= ${requestScope.proList.salepercent};
			var pimage1= ${requestScope.proList.pimage1};
			

			location.href="<%= request.getContextPath() %>/admin/productRegister.cc?pnum="+pnum+"&mname";					

		});// end of $("button#moreRegister").click(function(){
		
	}); // end of $(document).ready(function(){
	
	
</script>

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
				<th colspan="2">추가 정보</th>
			</tr>
		</thead>
		
		<tbody>
			<c:forEach var="proMap" items="${requestScope.proList}">
				<tr>
					<td id="pnum">${proMap.pnum}</td>
					<td colspan="2">${proMap.pname}</td>
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
					<td><button type="button" id="moreOrUpdate">더보기 및 수정</button></td>
					<td><button type="button" id="moreRegister">추가상품 등록</button></td>
				</tr>	
			</c:forEach>	
			
		</tbody>
	
	</table>	
	<form name="search">
		<input type="hidden" name="currentShowPageNo" value="${requestScope.currentShowPageNo}" />
		<select name="sizePerPage" id="sizePerPage">
			<option value="10">10</option>
			<option value="5">5</option>
			<option value="3">3</option>
		</select>
		
		<select name="searchType">
			<option value="pnum">상품번호</option>
			<option value="pname">상품명</option>
			<option value="pcolor">색상</option>
		</select>
		<input type="text" name="searchWord" id="searchWord"/>
		<button type="button" id="searchBtn" style="margin-right: 30px;">검색</button>
	</form>
	
	<div>${requestScope.pageBar}</div>
	
</div>


<jsp:include page="../footer.jsp" />
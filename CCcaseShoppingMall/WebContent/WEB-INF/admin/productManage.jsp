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
		border:solid 1px black;
		width:170px;
		text-align: center !important;
	}
	
	td{
		border:solid 1px black;
		text-align: center;
	}
	
	table{
		padding-left: 100px;
	}
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
	
		$("select#sizePerPage").val("${requestScope.sizePerPage}");
		
		if("${requestScope.searchType}"!=""){
			$("select#searchType").val("${requestScope.searchType}");
		}
		$("input#searchWord").val("${requestScope.searchWord}");
		
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
		$("button.proMoreRegister").click(function(){
			
			var productid =$(this).parent().prop('class');
			
			location.href="<%= request.getContextPath() %>/admin/productRegister.cc?productid="+productid; 					
			
		});// end of $("button#moreRegister").click(function(){
			
		
		// 더보기 및 수정버튼을 클릭했을때
		$("button.prodetailOrUpdate").click(function(){
			
			// 해당행의 제품상세번호(pnum)를 get방식으로 넘겨주기.
			var pnum = $(this).parent().prop('class');
			
			location.href="<%= request.getContextPath()%>/admin/prodetailOrUpdate.cc?pnum="+pnum;
		
		});// end of $("button.moreOrUpdate").click(function(){
		
		
	}); // end of $(document).ready(function(){
	
	
</script>

<div id="contents">
	
	<table>
		<thead>
			<tr> 
				<th style="width:110px;">상품번호</th>
				<th colspan="2" style="width:220px;">상품명</th>
				<th style="width:90px;">색상</th>
				<th style="width:110px;">제품정가</th>
				<th style="width:110px;">제품판매가</th>
				<th style="width:90px;">재고량</th>
				<th style="width:110px;">제품입고일자</th>
				<th style="width:90px;">배송조건</th>
				<th colspan="2">추가 정보</th>
			</tr>
		</thead>
		
		<tbody>
			<c:forEach var="proMap" items="${requestScope.proList}" >
				<tr>
					<td>${proMap.pnum}</td>
					<td colspan="2">${proMap.pname}</td>
					<td>${proMap.pcolor}</td>
					<td>${proMap.originalprice}원</td>
					<td>${proMap.saleprice}원</td>
					<td>${proMap.pqty}개</td>
					<td>${proMap.pinputdate}</td>
					<td>
						 <c:choose> 
							<c:when test="${proMap.doption eq '0'}">무료</c:when> 
							<c:when test="${proMap.doption eq '1'}">유료</c:when>
						 </c:choose>
					</td>
					<%-- id값이 아닌 class값으로 넣어주는 이유는 반복문이여서 id값 중복방지를 위해,
					 안되는건 아니지만, 관례상 id값은 한개만! --%> 
					<td class="${proMap.pnum}"><button type="button" class="prodetailOrUpdate">더보기 및 수정</button></td>
					<td class="${proMap.productid}"><button type="button" class="proMoreRegister">추가상품 등록</button></td>

				</tr>	
			</c:forEach>	
			
		</tbody>
	
	</table>
	<br>	
	<form name="search">
		<input type="hidden" name="currentShowPageNo" value="${requestScope.currentShowPageNo}" />
		<select name="sizePerPage" id="sizePerPage">
			<option value="10">10</option>
			<option value="5">5</option>
			<option value="3">3</option>
		</select>
		
		<select name="searchType" id="searchType">
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
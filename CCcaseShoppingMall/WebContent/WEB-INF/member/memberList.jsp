<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../adminheader.jsp" />

<style type="text/css">



</style>

<script type="text/javascript">


</script>

<h2>회원목록</h2>

<form name="memberFrm">

	<select>
		<option>선택</option>	<%-- 첫화면/선택 안했을시 기본으로 보여지는 텍스트 --%>
		<option></option>
		<option></option>
		<option></option>
	</select>
	<input type="text" id="searchWord" name="searchWord" />
	<input type="text" style="display: none;">
	<button type="button" onclick="goSearch();" style="margin-right: 30px;">검색</button>
	
	<select id="sizePerPage" name="sizePerPage">
		<option>페이지 보기설정</option> <%-- 첫화면/선택 안했을시 기본으로 보여지는 텍스트 --%>
		<option>20</option> 
		<option>10</option>
		<option>5</option>
		<option>3</option>
	</select>

</form>

<table>
	<thead>
		<tr>
			<th>아이디</th>
			<th>회원명</th>
			<th>이메일</th>
			<th>전화번호</th>
			<th>주소</th>
		</tr>
	</thead>

	<tbody>
		<c:forEach var ="mvo" items="">
			<tr>
				
			</tr>	
		</c:forEach>
	</tbody>
</table>

	<div>
			${requestScope.pageBar}
	</div>

<jsp:include page="../footer.jsp" />
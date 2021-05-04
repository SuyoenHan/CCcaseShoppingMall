<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />
<jsp:include page="../communityLeftSide.jsp"/>

<style>

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
		
	});// end of $(document).ready(function(){})----------------------------------

</script>

<div id="title"> 
	커뮤니티
</div>

<div id="container">
<h3>고객리뷰</h3>

<form name="reviewRegFrm">
	
	<table id="tblReviewRegister">
		<c:set var="now" value="<%=new java.util.Date()%>" />
		<tbody>
			<tr>
				<td>제목</td>
				<td>
					<input type="text" id="rtitle" class="rqdInfo" name="rtitle"/>
			</tr>
			<tr>
				<td>작성자</td>
				<td>
					${sessionScope.loginuser.userid}
				</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td>
					${sessionScope.loginuser.email}
				</td>
			</tr>
			<tr>
				<td>리뷰제품명</td>
				<td>
					<%-- 제품 연결..ㅠ --%>
				</td>
			</tr>
			<tr>
				<td>제품만족도</td>
				<td>
					<select id="ratingType" name="ratingType">
						<option value="choose">별점을 선택하세요.</option>
						<option value="1">★☆☆☆☆</option>
						<option value="2">★★☆☆☆</option>
						<option value="3">★★★☆☆</option>
						<option value="4">★★★★☆</option>
						<option value="5">★★★★★</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>등록일</td>
				<td>
					${requestScope.rvo.rregisterdate}
				</td>
			</tr>
			<tr>
				<td colspan="2" id="revcontent">
				<label for="rcontent">글쓰기</label>
				<textarea id="rcontent" name="rcontent" class="rqdInfo" placeholder="내용을 입력하세요.">
					
				</textarea>
				</td>
			</tr>
			
			<%-- ==== 첨부파일 타입 추가하기 ==== --%>
			<tr>
				<td class="revImgName">첨부파일(선택)</td>
				<td>
					<label for="spinnerImgQty">파일갯수 : </label>
					<input id="spinnerImgQty" value="0" style="width:30px; height:20px;">
					<div id="divfileattach"></div>
					
					<input type="hidden" name="attachCount" id="attachCount" />
				</td>
			</tr>
		</tbody>
	</table>
	
	<button type="button" class="button editComplete" style="align:right;">수정</button>&nbsp;
	<button type="button" class="button editCancel" style="align:right;">취소</button>
</form>

</div>
	
<jsp:include page="../footer.jsp" />	
	
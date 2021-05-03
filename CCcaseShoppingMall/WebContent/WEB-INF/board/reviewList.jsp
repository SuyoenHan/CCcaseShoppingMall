<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../header.jsp" />
<jsp:include page="../communityLeftSide.jsp"/>

<style>
	
	div#title{
	/* 	border:solid 1px gray; */
		background-color: #ccc;
		width:100%;
		height:60px;
		padding:15px;
		margin:20px auto;
		text-align: left;
		font-size: 20pt;
	}
	
	#description {
		font-size: 12pt;
		color: #a6a6a6;
	}
	
	#searchImg {
		height: 30px;
		width: 30px;
		box-shadow: 3px 3px 3px gray;
	}
	
	input#searchWord {
		padding: 3.3px 0;
		margin-right: 0;
		vertical-align: middle; 
	}

</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		func_height();
		
		$("li#revDetail").click(function(){
			
			if(${sessionScope.loginuser != null}){
			location.href="<%=ctxPath%>/board/reviewOneDetail.cc?subject="+subject+"&goBackURL=";
			}
			else {
				alert("로그인 후에 사용 가능합니다!");
			}
			
		});
		
		$("button#btnWrite").click(function(){
			location.href="<%=ctxPath%>/board/reviewWrite.cc";
		});
		
	});// end of $(document).ready(function(){})----------------------------------
	
	function goRSearch() {
		
		var frm = document.searchReviewFrm;
		frm.action = "reviewList.cc";
		frm.method="GET";
		frm.submit();
		
	}// end of function goRSearch() {}----------------------------------------

	
</script>

<div id="title"> 
	커뮤니티
</div>

<h3>고객리뷰</h3>

		<div>포토리뷰 모아보기(<span></span>)&nbsp;&nbsp;&nbsp;<span id="description">최근 1년간의 포토리뷰를 확인하세요</span></div>
		
		<ul class="pager" style="align: right"><li><button type=button>&lt;</button></li><li><button type=button>&gt;</button></li></ul>
		<ul>
			<c:forEach var="rvo" items="${requestScope.revList}">
				<li id="revDetail">
					<c:if test="${rvo.reviewimage1 != null}"><a><img src="${rvo.reviewimage1}"></a></c:if>
					<c:if test="${rvo.reviewimage eq null}"><a><img src="../images/noimage.png"></a></c:if>
				</li>
			</c:forEach>
		</ul>
		
		<form name="searchReviewFrm">
		
			<select id="searchType" name="searchType" style="height: 30px;">
				<option value="choose">선택</option>
				<option value="fk_pname">제품명</option>
				<option value="rvtitle">글제목</option>
				<option value="rvcontent">글내용</option>
			</select>
			<input type="text" id="searchWord" placeholder="제품명 입력"/>
			<a onClick="goRSearch()"><img id="searchImg" src="../images/product/look.png"></a>
		</form>
		
		<table>
			<tbody>
				<c:forEach var="rvo" items="${requestScope.revList}">
				<tr class="reviewInfo">
					<td>${rvo.reviewimage1}</td>
					<td class="rvtitle">${rvo.rvtitle}</td>
					<td>${rvo.rvcontent}</td>
					<td>${rvo.rregisterdate}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div style="text-align:center; padding: 20px 0;">
				${requestScope.pageBar}
		</div>

		<button type="button" id="btnWrite" style="align: right;">글쓰기</button>

<jsp:include page="../footer.jsp" />
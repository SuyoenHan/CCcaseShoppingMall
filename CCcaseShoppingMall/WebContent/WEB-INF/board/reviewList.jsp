<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% String ctxPath = request.getContextPath(); %>


<jsp:include page="../header.jsp" />
<jsp:include page="../communityLeftSide.jsp"/>

<style>
	
		div#title{
		float:left;
		background-color: #ccc;
		width:84%;
		height:60px;
		padding:15px;
		margin:20px auto;
		text-align: left;
		font-size: 20pt;
	}
	
	h2 {
		clear:both;
	}
	
	.container{
		width:100% !important;
		margin-top:20px;
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
		
		if("${fn:trim(requestScope.searchWord)}" != "") {
			$("select#searchType").val("${requestScope.searchType}");
			$("input#searchWord").val("${requestScope.searchWord}");
		}
		
		$("input#searchWord").bind("keyup",function(){
			if(event.keyCode == 13) {
				goRSearch();
			}
		});
		
		// 특정 리뷰를 클릭하면 그 리뷰의 상세내용를 보여주도록 한다.
		$("tr.reviewInfo").click(function(){
			
			var subject = $(this).children(".rvtitle").text();
			
			location.href="<%=ctxPath%>/board/reviewOneDetail.cc?subject="+subject+"&goBackURL=";
		});
		
		$("button#write").click(function(){
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

	<div id="title"> 커뮤니티</div>
	<h3>고객리뷰</h3>
	
	<div class="container">
		<div>
			<span style="color: black; font-size: 13pt; font-weight: bold;">포토리뷰 모아보기(<span id="totalCnt"></span>)</span>&nbsp;&nbsp;&nbsp;
			<span style="color:#a6a6a6;">최근 1년간의 포토리뷰를 확인하세요</span>
			<ul class="pager" style="float:right;"><li><button type=button id="prev">&lt;</button></li><li><button type=button id="next">&gt;</button></li></ul>
		</div>
		
		
		<div class="thumbnail" style="float:middle; width: 100%;">
			<ul>
				<c:forEach var="rvo" items="${requestScope.revList}">
					<li id="revDetail">
						<c:if test="${rvo.reviewimage1 != null}"><a><span><img src="../images/${rvo.reviewimage1}"></span></a></c:if>
						<c:if test="${rvo.reviewimage1 eq null}"><a><span><img src="../images/review/noimage.png"></span></a></c:if>
					</li>
				</c:forEach>
			</ul>
		</div>
		
		<form name="searchReviewFrm" style="float:right;">
		
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
					<td class="">${rvo.rvtitle}</td>
					<td>${rvo.rvcontent}</td>
					<td>${rvo.rregisterdate}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div style="text-align:center; padding: 20px 0;">
				${requestScope.pageBar}
		</div>
		
		<div><button type="button" id="write">글쓰기</button></div>
		
	</div>

<jsp:include page="../footer.jsp" />
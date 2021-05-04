<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />
<jsp:include page="../communityLeftSide.jsp"/>

<style>
	
	#rcontainer {
		float: right;
		width: 84%;
	}
	
	div#title{
		background-color: #ccc;
		width:100%;
		height:60px;
		padding:15px;
		margin:20px auto;
		text-align: left;
		font-size: 20pt;
	}
	
	#btnGroup button{
		float: right;
		background-color: black;  
		color: white; 
		padding: 1px;
		align: right;
		font-weight: bold;
		box-shadow: 3px 3px 3px gray;
	}
	
	#revDetail {
		cursor:pointer;
	}
	
	#photoReview {
		float: right;
		width: 100%;
		background-color: #f2f2f2;
	}
	
	#description {
		font-size: 12pt !important;
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
	
	#container > table {
		border-top: solid 1px gray;
		border-botton: solid 1px gray;
		border-collapse: collapse;
	}
	
	tr {
		width: 84%;
	}
	
	tr > td {
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
		
		$("a#searchBtn").click(function(){
			goRSearch();
		});
		
		
		$("input#searchWord").bind("keyup",function(){
			if(event.keyCode == 13) {
				goRSearch();
			}
		
		$("li#revDetail").click(function(){
			
			var revImg = $(this).text();
			// alert(revImg);
			location.href="<%=ctxPath%>/board/reviewOneDetail.cc?thumbnail="+revImg+"&goBackURL=${requestScope.goBackURL}";
			
		});
		
		$("button#btnWrite").click(function(){
			if(${sessionScope.loginuser != null}){	
				location.href="<%=ctxPath%>/board/reviewWrite.cc";
			}
			else {
				alert("로그인 후에 사용 가능합니다!");
			}
		});
		
	});// end of $(document).ready(function(){})----------------------------------
	
	function goRSearch() {
		
		var frm = document.searchReviewFrm;
		frm.action = "reviewList.cc";
		frm.method="GET";
		frm.submit();
		
	}// end of function goRSearch() {}----------------------------------------

	
</script>

<div id="title" style="float: left; width:84%;"> 
	커뮤니티
</div>

<div id="rcontainer">
<h2 style="font-weight:bolder;">고객리뷰</h2>

		<div style="font-size: 15pt;">포토리뷰 모아보기(<span id="rtotalCnt">${requestScope.rtotalCnt}</span>)&nbsp;&nbsp;&nbsp;<span id="description">최근 1년간의 포토리뷰를 확인하세요</span></div>
		
		<div id="btnGroup">
			<button id="btnNext" >&nbsp;&gt;&nbsp;</button>&nbsp;<button id="btnPrev" style="right;">&nbsp;&lt;&nbsp;</button>
		</div>
		
		<br>
		
		<div id="photoReview">
		<ul style="list-style:none; margin-top: 10px;">
			<c:forEach var="rvo" items="${requestScope.revList}">
				<li id="revDetail" style="display : inline;">
					<c:if test="${rvo.reviewimage1 != null}"><a><img src="../images/${rvo.reviewimage1}" style="width:100px; height:100px"></a></c:if>
				</li>
			</c:forEach>
		</ul>
		</div>
		
		<br>		
		
		<form name="searchReviewFrm" style="float:right; margin: 40px 0;">
		
			<select id="searchType" name="searchType" style="height: 31px; vertical-align:top;">
				<option value="choose">선택</option>
				<option value="fk_pname">제품명</option>
				<option value="rvtitle">글제목</option>
				<option value="rvcontent">글내용</option>
			</select>
			<input type="text" id="searchWord" style="vertical-align:top;"placeholder="제품명 입력"/>
			<a id="searchBtn"  style="cursor:pointer;"><img id="searchImg" src="../images/product/look.png"></a>
		</form>
		
		<table class="table" style="float:right; ">
			<tbody>
				<c:forEach var="rvo" items="${requestScope.revList}">
				<tr class="reviewInfo">
					<td style="vertical-align:middle; text-align: center;">${rvo.reviewno}</td>
					<td style="vertical-align:middle; width:20%; text-align: left;">
						<c:if test="${rvo.reviewimage1 eq null}"><img src="../images/review/noimage.png"></c:if>
						<c:if test="${rvo.reviewimage1 != null}"><img src="../images/${rvo.reviewimage1}" style="width:200px; height:150px;"></c:if>
					</td>
					<td class="rvtitle" style="text-align:left; vertical-align:middle;"><span style="font-weight:bold; font-size:14pt;">${rvo.rvtitle}</span><br>
						${rvo.rvcontent}</td>
					<td style="text-align:right; vertical-align:middle;">${rvo.rregisterdate}<br><br>
						<span style="font-weight:bold;">${rvo.fk_userid}</span></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<br>
		
		<div id="pager" style="text-align:center; padding: 20px 0; clear:both;">
				${requestScope.pageBar}
		</div>
		
		<br>
		
		<button type="button" id="btnWrite" style="float: right; margin-bottom: 30px; border: none; background-color:#33ccff; color:white; padding: 7px 7px; font: 15pt bold;">글쓰기</button>
		
</div>
<jsp:include page="../footer.jsp" />
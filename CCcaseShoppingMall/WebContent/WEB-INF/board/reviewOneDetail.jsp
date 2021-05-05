<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<jsp:include page="../header.jsp" />
<jsp:include page="../communityLeftSide.jsp"/>

<style type="text/css">
	
	#revcontainer {
		width: 100%;
	}
	
	div#title{
		background-color: #ccc;
		height:60px;
		padding:15px;
		margin:20px auto;
		text-align: left;
		font-size: 20pt;
		float: left; 
		width:84%;
	}
	
	#revBox {
		border: solid 1px black;
		float:left;
		width: 750px;
		height:430px;
		margin-top: 8px;
	}

	#btnRevList {
		margin: 30px 0;
		float:right;
	}
	
	#btnRevList > button {
		background-color: black;
		color: white;
		box-shadow: 3px 3px 3px gray;
	}
	
	button#btnDetail {
		border: none;
	}
	
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
	
	var goBackURL = "";
	
	$(document).ready(function(){
		
		goBackURL = "${requestScope.goBackURL}"	;
		goBackURL = goBackURL.replace(/ /gi, "&");
		
	}); // end of $(document).ready(function(){})--------------------------------------
	
	// Function Declaration 
	function goBack2List() {
			location.href="<%=ctxPath%>/board/reviewList.cc";
	}
	
	// 이미지 보여주기
	function showBig(val) {
	 var obj = document.getElementById("big");
	  obj.src = "../images/" + val;
	} 
	
	function revEdit() {	
		location.href="<%=ctxPath%>/board/reviewEdit.cc"
	}
	
	function revDel() {
		location.href="<%=ctxPath%>/board/reviewDel.cc"
	}
	
</script>


<div id="title" style=""> 
	커뮤니티
</div>

<div id="revcontainer">
<h3>&nbsp;고객리뷰</h3>
<div class="row">

	<div id="revImg" class="col-md-4 line">
			<img src="../images/${requestScope.rvo.reviewimage1}" width="400" height="400" id="big"/>
			<br/><br/>
			<img src="../images/${requestScope.rvo.reviewimage1}" width="130" height="130" onmouseover="showBig('${requestScope.rvo.reviewimage1}');"/>
			<img src="../images/${requestScope.rvo.reviewimage2}" width="130" height="130" onmouseover="showBig('${requestScope.rvo.reviewimage2}');"/>
			<img src="../images/${requestScope.rvo.reviewimage3}" width="130" height="130" onmouseover="showBig('${requestScope.rvo.reviewimage3}');"/>
	</div>

<div id="main">
<div class="col=md-8 line">
		
		<table>
			<tbody>
				<tr style="border:solid 1px gray; height:40px;">
					<td><img src="../images/${requestScope.pvo.pimage1}"></td>
					<td><span>${requestScope.spvo.sname}</span><br>
							<span>${requestScope.pvo.productname}</span><br>
							<span>${requestScope.pvo.price}</span>&nbsp;&nbsp;&nbsp;
							<button id="btnDetail" type="button" onclick="location.href='<%=ctxPath%>/product/productDetail.cc?productid="+ productid + "&snum="+snum+"&goBackURL="+${requestScope.goBackURL}+" ' ">제품상세보기</button><br>
					</td>
				</tr>
			</tbody>
		</table>

		<br>
		
		<div id="reviewInfo">
			
			<span id="rating" style="font-size: 15pt;">
				<c:choose>
					<c:when test="${requestScope.rvo.satisfaction eq '1'}">
						★☆☆☆☆
					</c:when>
					<c:when test="${requestScope.rvo.satisfaction eq '2'}">
						★★☆☆☆
					</c:when>
					<c:when test="${requestScope.rvo.satisfaction eq '3'}">
						★★★☆☆
					</c:when>
					<c:when test="${requestScope.rvo.satisfaction eq '4'}">
						★★★★☆
					</c:when>
					<c:otherwise>
						★★★★★
					</c:otherwise>
				</c:choose>
			</span>
		
			<div id="revBox">
				<span>${sessionScope.loginuser.userid}&nbsp;|&nbsp;</span>
				<span>${requestScope.rvo.rregisterdate}&nbsp;|&nbsp;</span>			
				<span>${requestScope.rvo.rviewcount}&nbsp;|&nbsp;</span><br>	
				<span>${requestScope.rvo.rvtitle}</span><br>
				<p>${requesetScope.rvo.rvcontent}</p>
			</div>
		</div>
	</div>
</div>	
	</div>
	<div id="btnRevList" align="right">
		<button type="button" onclick="goBack2List()">목록</button>
		<button type="button" onclick="revEdit()">수정</button><%-- 로그인 후에 보여질지 결정 --%>
		<button type="button" onclick="revDel()">삭제</button><%-- 로그인 후에 보여질지 결정 --%>
	</div>
</div>

<jsp:include page="../footer.jsp" />
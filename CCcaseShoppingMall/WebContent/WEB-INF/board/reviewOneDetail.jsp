<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		width: 700px;
		height:430px;
		margin-top: 8px;
		padding: 20px;
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
		
		goLikeCnt();
		
		goBackURL = "${requestScope.goBackURL}"	;
		goBackURL = goBackURL.replace(/ /gi, "&");
		
		$("button#btnDetail").click(function(){
			goProdDetail();
		});
		
		$(document).on("mouseover","#imgRev", function(){
			var obj = document.getElementById("big");
			var index = $(this).index();
			obj.src = $(this).eq(index).src;
		});
	
		
		
	}); // end of $(document).ready(function(){})--------------------------------------
	
	// Function Declaration
	
	function goBack2List() {
			location.href="<%=ctxPath%>/board/reviewList.cc";
	}
	
	
	// **** 특정제품에 대한 좋아요 등록하기 **** // 
	function goAddlike(reviewno) {
		
		if(${empty sessionScope.loginuser}) {
			alert("도움이 돼요를 누르시려면 먼저 로그인 하셔야 합니다.");
			return;
		}
		
		$.ajax({
			url: "<%=ctxPath%>/board/likeAdd.cc",
			type: "POST",
			data: {"userid":"${sessionScope.loginuser.userid}"
						,"reviewno":reviewno},
			dataType: "json",
			success:function(json){
				alert(json.msg);
				goLikeCnt(reviewno);
			},
			error: function(request, status, error) {
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
	}// end of function goAddlike() {}-----------------------------------------------------------

	// **** 특정 제품에 대한 좋아요, 싫어요 갯수를 보여주기 **** //
	function goLikeCnt(reviewno) {
		
		$.ajax ({
			url:"<%=ctxPath%>/board/likeCount.cc",
			data:{"reviewno": reviewno},
			dataType:"json",
			success:function(json) {
				$("span#likeCnt").html(json.likecnt);
			},
			error: function(request,status,error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
	}

	function goProdDetail() {
		var productid = "${requestScope.pdvo.fk_productid}";
		var snum = "${requestScope.snum}";
		location.href="<%=ctxPath%>/product/productDetail.cc?productid="+ productid + "&snum="+snum+"&goBackURL=${requestScope.goBackURL}";
	}
	
	// 리뷰 삭제하기
	function goDelOneRev(reviewno) {
		if(confirm("리뷰를 삭제하시겠습니까?")) {
			
			$.ajax({
				url:"<%=ctxPath%>/board/reviewDel.cc",
				type:"post",
				data:{"reviewno":reviewno},
				dataType:"json",
				success:function(json){
					if(json.n == 1){
						alert("리뷰를 삭제하였습니다.");
						location.href="reviewList.cc";
					}	
				},
				error: function(request, status, error) {
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
			
		}
		else {
			alert("리뷰 삭제를 취소하셨습니다.");
		}
	}
	
</script>


<div id="title"> 
	커뮤니티
</div>

<div id="revcontainer">
<h3>&nbsp;고객리뷰</h3>
<div class="row">

	<div id="revImg" class="col-md-4 line">
			<img src="../images/${requestScope.rvo.reviewimage1}" width="400" height="400" id="big"/>
			<br/><br/>
			<img src="../images/${requestScope.rvo.reviewimage1}" width="130" height="130" id="imgRev">
			<img src="../images/${requestScope.rvo.reviewimage2}" width="130" height="130" id="imgRev">
			<img src="../images/${requestScope.rvo.reviewimage3}" width="130" height="130" id="imgRev">
	</div>

<div id="main" style="float:right; width: 700px;"class="col=md-8 line">
		
		<table>
			<tbody>
				<tr style="border:solid 1px gray; height:40px;">
					<td style="padding: 10px;"><img src="../images/${requestScope.pvo.pimage1}" width="80px" height="80px">
					<input type="hidden" id="productid" name="productid" value="${requestScope.pdvo.fk_productid}"/>
					<input type="hidden" id="pnum" name="pnum" value="${requestScope.pdvo.pnum}" /></td>
					<td style="padding: 10px; width: 650px;">
						<c:if test="${requestScope.snum eq 1}">
							<span style="background-color: #cc8800; font-weight:bold; font-size:8pt; color:white;">NEW</span><br>
						</c:if>
						<c:if test="${requestScope.snum eq 0}">
							<span style="background-color:#009900; font-weight:bold; font-size:8pt; color:white;">BEST</span><br>
						</c:if>
						<c:if test="${requestScope.snum eq -1}">
							<span>-</span><br>   <%-- 신상품도 베스틑상품도 아닌경우 --%>
						</c:if>
						<span style="font-weight:bold;">${requestScope.pvo.productname}</span><br>
						<span><fmt:formatNumber value="${requestScope.pvo.price}" pattern="#,###" />원</span>&nbsp;&nbsp;&nbsp;
						<button id="btnDetail" type="button" onclick="goProdDetail()" style="">제품상세보기</button><br>
					</td>
				</tr>
			</tbody>
		</table>

		<br>
		
		<div id="reviewInfo" style="width: 700px; height: 700px;">
			<input type="hidden" id="satisfaction" name="satisfaction" value="${requestScope.rvo.satisfaction}"/>
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
					<input type="hidden" id="fk_userid" name="fk_userid" value="${requestScope.rvo.fk_userid}"/>
					<span style="font-weight:bold;">${requestScope.rvo.fk_userid}&nbsp;|&nbsp;</span>
					<input type="hidden" id="reviewno" name="reviewno" value="${requestScope.reviewno}">
					<input type="hidden" id="rregisterdate" name="rregisterdate" value="${requestScope.rregisterdate}" />
					<span>${requestScope.rvo.rregisterdate}&nbsp;|&nbsp;</span>	
					<c:if test="${requestScope.rvo.rregisterdate ne requestScope.rvo.rupdatedate}">
						<input type="hidden" id="rupdatedate" name="rupdatedate" value="${requestScope.rupdatedate}" />
						<span>${requestScope.rvo.rupdatedate}&nbsp;|&nbsp;</span>	
					</c:if>	
					<span>${requestScope.rvo.rviewcount}</span><br><br>
					<input type="hidden" id="rvtitle" name="rvtitle" value="${requestScope.rvo.rvtitle}"/>
					<span style="font-size: 15pt; font-weight: bolder;">${requestScope.rvo.rvtitle}</span><br>
					<input type="hidden" id="rvcontent" name="rvcontent" value="${requestScope.rvo.rvcontent}"/>
					<p>${requestScope.rvo.rvcontent}</p>
				</div>
				<div id="ddabong" >
					<img src="<%=ctxPath%>/images/review/thumbsupicon.png" style="cursor:pointer; width: 60px; height:60px; margin: 20px; filter:drop-shadow(5px 5px 5px #000);" onclick="goAddlike(${requestScope.reviewno})"/>&nbsp;&nbsp;
					<span id="likeCnt" style="color:black; font-weight: bold; font-size:15pt;"></span>
				</div>
			
				<div id="btnRevList" style="float:right;">
					<button type="button" onclick="location.href='<%=ctxPath%>/board/reviewList.cc'">목록</button>
				<c:if test="${sessionScope.loginuser.userid eq requestScope.rvo.fk_userid}">	
					<button type="button" onclick="location.href='<%=ctxPath%>/board/reviewEdit.cc'">수정</button><%-- 로그인 후에 보여질지 결정 --%>
					<input type="hidden" id="reviewno" name="reviewno" value="${requestScope.reviewno}"/>
					<button type="button" onclick="goDelOneRev(${requestScope.reviewno});">삭제</button><%-- 로그인 후에 보여질지 결정 --%>
				</c:if>	
				</div>
		</div>		
		
	
	</div>
	
	
</div>

</div>
<jsp:include page="../footer.jsp" />
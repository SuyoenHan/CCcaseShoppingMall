<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath= request.getContextPath();
%>

<style type="text/css">

	div.homeBorderImg{
		border: solid 0px blue;
		width: 1100px;
		height: 5px;
		clear: both;
		margin-left: 30px;
		background-color: #fff;
	}
	
	div.productOuter{
		border: solid 0px red;
		float:left;
		margin: 0px 10px 100px 35px;
		width:210px;
		height: 300px;
		cursor: pointer;
	}
	
	span.netPrice{
		text-decoration: line-through;
		font-size: 10pt;
	}
	
	span.salePrice{
		color:red;
		font-weight: bold;
		font-size: 10pt;
	}
	
	div.productName{
		margin: 15px 0px;
		font-size: 11pt;
		border-bottom: solid 2px #caceca;
		padding-bottom: 10px;
	}
	
	span.spec{
		display: inline-block;
		width:40px;
		height:25px;
		border: solid 0px red;
		color: #fff;
		font-weight: bold;
		margin-top:10px;
		margin-right: 5px;
	}
	
	span.best{
		background-color: #009900;
	}
	
	span.new{
		background-color: #cc8800;
	}

	img.pmoImg{
		width: 30px;
		height: 30px;
		margin-top:5px;
		margin-right: 10px;
	}
	
	div.discountInfo{
		width: 100px;
		height: 40px;
		color: #fff;
		font-weight: bold;
		font-size: 18pt;
		padding-top: 10px;
		position: relative;
		top: 40px;
		background-color: #333300;
		float:right;
	}
	
	img.movebt{
		width: 30px;
		height:30px;
		border: solid 0px blue;
	}

	div.caseGroup{
		float: left;
		margin-top: 30px;
	}
	
	div.mainTitle{
		font-size: 40pt;
		font-weight: bold;
		margin-top: 30px;
	}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		
		func_height();
		$("div.discountInfo").css("opacity","0");
		
		// 제품에 마우스오버시 제품이미지 흐리게하기
		$("div.productOuter").hover(function(){
			$(this).find("img.pImg").css("opacity","0.5");
		},function(){  // end of mouseover event-------------
			$(this).find("img.pImg").css("opacity","1");
		}); // end of mouseout & hover event----------------	

	
		
		// ======= 베스트상품 오른쪽 화살표 버튼 누를경우 이미지 하나씩 넘기기 작업
		
		$("div#bestContainer div.productOuter").hide();
		$("div#bestContainer div.productOuter").each(function(){
			
			for(var i=1;i<=4;i++){
				if("BEST"+i == $(this).prop("id")){
					$(this).show();
				}
			}
		}); // end of $("div.productOuter").each(function(){---------
			
		var bestPShowStart= 1;    // 보여줄 베스트 이미지 시작순번
		var lastBCnt= ${pBestCnt}; // 마지막베스트제품 순번 
		
		$("div#bNext").click(function(event){
				
			if(bestPShowStart==(lastBCnt-3)){
				return false;	// 이벤트 중지
			}
				
 			bestPShowStart++;
			$(this).prev().find("div.productOuter").hide()
			
			$(this).prev().find("div.productOuter").each(function(){
				for(var j=bestPShowStart;j<=bestPShowStart+3;j++){
					if("BEST"+j == $(this).prop("id")){
						$(this).show()
					}
				}
			}); // end of $("div.productOuter").each(function(){---------
			
		}); // end of $("div#bNext").click(function(event){-------------
					
		// ======= 베스트 상품 왼쪽 화살표 버튼 누를경우 이미지 하나씩 넘기기 작업	
			
		$("div#bPrev").click(function(event){
			
			if(bestPShowStart<=1){
				return false;  // 이벤트 중지
			}

			$(this).next().find("div.productOuter").hide()
			
			$(this).next().find("div.productOuter").each(function(){
				for(var j=bestPShowStart-1;j<=bestPShowStart+2;j++){
					if("BEST"+j == $(this).prop("id")){
						$(this).show()
					}
				}
			}); // end of $("div.productOuter").each(function(){---------
				
			bestPShowStart--;
		}); // end of $("div#bPrev").click(function(event){---------------
		
		
			
			
		// ======= 신상품 오른쪽 화살표 버튼 누를경우 이미지 하나씩 넘기기 작업
		
		$("div#newContainer div.productOuter").hide();
		$("div#newContainer div.productOuter").each(function(){
			
			for(var i=1;i<=4;i++){
				if("NEW"+i == $(this).prop("id")){
					$(this).show();
				}
			}
		}); // end of $("div.productOuter").each(function(){---------
			
		var newPShowStart= 1;    // 보여줄 신상 이미지 시작순번
		var lastNCnt= ${pNewCnt}; // 마지막 신상제품 순번 
		
		$("div#nNext").click(function(event){
				
			if(newPShowStart==(lastNCnt-3)){
				return false;	// 이벤트 중지
			}
				
 			newPShowStart++;
			$(this).prev().find("div.productOuter").hide()
			
			$(this).prev().find("div.productOuter").each(function(){
				for(var j=newPShowStart;j<=newPShowStart+3;j++){
					if("NEW"+j == $(this).prop("id")){
						$(this).show()
					}
				}
			}); // end of $("div.productOuter").each(function(){---------
			
		}); // end of $("div#nNext").click(function(event){----------
					
			
		// ======= 신상품 왼쪽 화살표 버튼 누를경우 이미지 하나씩 넘기기 작업	
			
		$("div#nPrev").click(function(event){
			
			if(newPShowStart<=1){
				return false;  // 이벤트 중지
			}

			$(this).next().find("div.productOuter").hide()
			
			$(this).next().find("div.productOuter").each(function(){
				for(var j=newPShowStart-1;j<=newPShowStart+2;j++){
					if("NEW"+j == $(this).prop("id")){
						$(this).show()
					}
				}
			}); // end of $("div.productOuter").each(function(){---------
				
			newPShowStart--;
		}); // end of $("div#nPrev").click(function(event){---------	
			
		
			
			
		// ======= 무료배송상품 오른쪽 화살표 버튼 누를경우 이미지 하나씩 넘기기 작업
		
		$("div#freeContainer div.productOuter").hide();
		$("div#freeContainer div.productOuter").each(function(){
			
			for(var i=1;i<=4;i++){
				if("FREE"+i == $(this).prop("id")){
					$(this).show();
				}
			}
		}); // end of $("div.productOuter").each(function(){---------
			
		var freePShowStart= 1;    // 보여줄 신상 이미지 시작순번
		var lastFCnt= ${pFreeCnt}; // 마지막 신상제품 순번 
		
		$("div#fNext").click(function(event){
				
			if(freePShowStart==(lastFCnt-3)){
				return false;	// 이벤트 중지
			}
				
 			freePShowStart++;
			$(this).prev().find("div.productOuter").hide()
			
			$(this).prev().find("div.productOuter").each(function(){
				for(var j=freePShowStart;j<=freePShowStart+3;j++){
					if("FREE"+j == $(this).prop("id")){
						$(this).show()
					}
				}
			}); // end of $("div.productOuter").each(function(){---------
			
		}); // end of $("div#fNext").click(function(event){---------------
					
			
		// ======= 무료배송상품 왼쪽 화살표 버튼 누를경우 이미지 하나씩 넘기기 작업	
			
		$("div#fPrev").click(function(event){
			
			if(freePShowStart<=1){
				return false;  // 이벤트 중지
			}

			$(this).next().find("div.productOuter").hide()
			
			$(this).next().find("div.productOuter").each(function(){
				for(var j=freePShowStart-1;j<=freePShowStart+2;j++){
					if("FREE"+j == $(this).prop("id")){
						$(this).show()
					}
				}
			}); // end of $("div.productOuter").each(function(){---------
				
			freePShowStart--;
		}); // end of $("div#fPrev").click(function(event){--------------	
				
			
			
		
		// 문서 로딩시 베스트상품, 신상품, 무료배송상품 오른쪽으로 넘기는 버튼 자동 실행시키기	
		
		var nNextAuto= setInterval(function(){
						$('div#nNext').trigger('click');//이벤트 발생
				  },2000);

		var bNextAuto= setInterval(function(){
						$('div#bNext').trigger('click');//이벤트 발생
  				  },2000);
		
		var fNextAuto= setInterval(function(){
						$('div#fNext').trigger('click');//이벤트 발생
		  		  },2000);
		
		
		
		// 제품 이미지 클릭시 제품상세페이지로 넘어가기 => best, new에 해당하는 제품상세 정보 같이 넘겨서 미리 입력
		$("div.productInnerBySpec").click(function(){		
			var pIdForLink= $(this).find("input.linkInfo").val();
			var snum= $(this).find("input.snum").val();
			location.href="<%=ctxPath%>/product/productDetail.cc?productid="+pIdForLink+"&snum="+snum+"&goBackURL=${requestScope.goBackURL}";
		});
		
		// 제품 이미지 클릭시 제품상세페이지로 넘어가기 => 무료배송에 해당하는 제품상세 정보 같이 넘겨서 미리 입력
		$("div.productInnerByDOption").click(function(){		
			var pIdForLink= $(this).find("input.linkInfo").val();
			var doption= $(this).find("input.doption").val();
			location.href="<%=ctxPath%>/product/productDetail.cc?productid="+pIdForLink+"&doption="+doption+"&goBackURL=${requestScope.goBackURL}";
		});
		
	
		
	}); // end of $(document).ready(function(){-----------------------
	
	
	
</script>

<jsp:include page="../header.jsp" />
<jsp:include page="../leftSide.jsp" />

<div id="contents" style="height:2900px;">

	<div class="homeBorderImg" style="margin:30px 0px 50px 130px; width:900px; height: 400px;">
		<img src="<%=ctxPath%>/images/homeMain/homeMain2.jpg" style="width:900px; height: 400px;"  />
	</div>

	
	<div class="mainTitle" align="center">&nbsp;&nbsp;BEST</div>	
	<div class="caseGroup" style="margin-top:120px; margin-left:30px;"  id="bPrev">
		<img src="<%=ctxPath%>/images/homeMain/prevIcon.png" class="movebt" />
	</div>
	<div class="caseGroup" id="bestContainer">		
		<%-- 메인화면의 베스트상품 나열 --%>
		<c:forEach var="pInfoMapBest" items="${pInfoListBest}" varStatus="statusB">
			
			<div class="productOuter" align="center" id="BEST${statusB.count}">
				<div class="productInnerBySpec">
					<input type="hidden" class="linkInfo" value="${pInfoMapBest.productid}" />
					<input type="hidden" class="snum" value="0" />
					<img src="<%=ctxPath%>/images/${pInfoMapBest.pimage1}" class="pImg" id="${pInfoMapBest.productid}" width="210" height="200" />
					<div class="productName">[${pInfoMapBest.cname}]&nbsp;[${pInfoMapBest.modelname}]<br>${pInfoMapBest.productname}</div>
					
					
					<div>
						<c:if test="${pInfoMapBest.salepercent eq '0'}">					
							<span class="netPrice" style="text-decoration: none;">정가: <fmt:formatNumber value="${pInfoMapBest.price}" pattern="#,###,###" />원</span>&nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${pInfoMapBest.salepercent ne '0'}">					
							<span class="netPrice">정가: <fmt:formatNumber value="${pInfoMapBest.price}" pattern="#,###,###" />원</span>&nbsp;&nbsp;&nbsp;
							<span class="salePrice">할인가: <fmt:formatNumber value="${pInfoMapBest.saleprice}" pattern="#,###,###" />원</span>
						</c:if>
					</div>
					
					<%-- fk_snum이 0이면 BEST 상품, 1이면 NEW 상품, -1이면 해당 없음 --%>
					<div style="float: left">
						<c:if test="${pInfoMapBest.spec == 'BEST'}">
							<span class="best spec">BEST</span>
						</c:if>
						
						<c:if test="${pInfoMapBest.spec == 'NEW'}">
							<span class="new spec">NEW</span>
						</c:if>
						
						<c:if test="${pInfoMapBest.spec == 'BEST/NEW'}">
							<span class="best spec">BEST</span>
							<span class="new spec">NEW</span>
						</c:if>	
					</div>
				</div>
		    </div>
		</c:forEach>
	</div>
	<div class="caseGroup" id="bNext" style="margin-left:20px; margin-top:120px;">
		<img src="<%=ctxPath%>/images/homeMain/nextIcon.png" class="movebt" />
	</div>


	<div class="homeBorderImg" style="clear:both; margin:100px 0px 0px 100px; width:900px; height: 400px;">
		<img src="<%=ctxPath%>/images/homeMain/homeMain5.jpg" style="width:980px; height: 300px; padding-top:50px;"  />
	</div>
	
	
	<div class="mainTitle" align="center">&nbsp;&nbsp;NEW</div>	
	<div class="caseGroup" style="margin-top:80px; margin-left:30px;"  id="nPrev">
		<img src="<%=ctxPath%>/images/homeMain/prevIcon.png" class="movebt" />
	</div>
	<div class="caseGroup" id="newContainer">		
		<%-- 메인화면의 신상품 나열 --%>
		<c:forEach var="pInfoMapNew" items="${pInfoListNew}" varStatus="statusN">
			
			<div class="productOuter" align="center" id="NEW${statusN.count}">
				<div class="productInnerBySpec">
					<input type="hidden" class="linkInfo" value="${pInfoMapNew.productid}" />
					<input type="hidden" class="snum" value="1" />
					<img src="<%=ctxPath%>/images/${pInfoMapNew.pimage1}" class="pImg" id="${pInfoMapNew.productid}" width="210" height="200" />
					<div class="productName">[${pInfoMapNew.cname}]&nbsp;[${pInfoMapNew.modelname}]<br>${pInfoMapNew.productname}</div>
					
					<div>
						<c:if test="${pInfoMapNew.salepercent eq '0'}">					
							<span class="netPrice" style="text-decoration: none;">정가: <fmt:formatNumber value="${pInfoMapNew.price}" pattern="#,###,###" />원</span>&nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${pInfoMapNew.salepercent ne '0'}">					
							<span class="netPrice">정가: <fmt:formatNumber value="${pInfoMapNew.price}" pattern="#,###,###" />원</span>&nbsp;&nbsp;&nbsp;
							<span class="salePrice">할인가: <fmt:formatNumber value="${pInfoMapNew.saleprice}" pattern="#,###,###" />원</span>
						</c:if>
					</div>
					
					<%-- fk_snum이 0이면 BEST 상품, 1이면 NEW 상품, -1이면 해당 없음 --%>
					<div style="float: left">
						<c:if test="${pInfoMapNew.spec == 'BEST'}">
							<span class="best spec">BEST</span>
						</c:if>
						
						<c:if test="${pInfoMapNew.spec == 'NEW'}">
							<span class="new spec">NEW</span>
						</c:if>
						
						<c:if test="${pInfoMapNew.spec == 'BEST/NEW'}">
							<span class="best spec">BEST</span>
							<span class="new spec">NEW</span>
						</c:if>	
					</div>
				</div>
		    </div>
		</c:forEach>
	</div>
	<div class="caseGroup" id="nNext" style="margin-left:20px; margin-top:120px;">
		<img src="<%=ctxPath%>/images/homeMain/nextIcon.png" class="movebt" />
	</div>
	
	
	<div class="homeBorderImg" style="clear:both; margin:100px 0px 0px 100px; width:900px; height: 400px;">
		<img src="<%=ctxPath%>/images/homeMain/homeMain7.png" style="width:980px; height: 300px; padding-top:50px;"  />
	</div>
	
	<%-- 배송비여부는 제품별이 아닌 제품상세별로 다르다. 따라서 홈메인에는 제품 이미지를 보여주겠지만, 해당 이미지를 클릭해서 상세페이지로 넘어갔을때 옵션(색상)에, 
	           해당 제품 중 무료배송인 제품상세의 정보 값을 넣어 줄 것이다  --%>
	
	
	<div class="mainTitle" align="center">&nbsp;&nbsp;무료배송</div>	
	<div class="caseGroup" style="margin-top:120px; margin-left:30px;"  id="fPrev">
		<img src="<%=ctxPath%>/images/homeMain/prevIcon.png" class="movebt" />
	</div>
	<div class="caseGroup" id="freeContainer">		
		<%-- 메인화면의 무료배송상품 나열 --%>
		<c:forEach var="pInfoMapFree" items="${pInfoListDFree}" varStatus="statusf">
			
			<div class="productOuter" align="center" id="FREE${statusf.count}">
				<div class="productInnerByDOption">
					<input type="hidden" class="linkInfo" value="${pInfoMapFree.productid}" />
					<input type="hidden" class="doption" value="0" />
					<img src="<%=ctxPath%>/images/${pInfoMapFree.pimage1}" class="pImg" id="${pInfoMapFree.productid}" width="210" height="200" />
					<div class="productName">[${pInfoMapFree.cname}]&nbsp;[${pInfoMapFree.modelname}]<br>${pInfoMapFree.productname}</div>
					
					<div>
						<c:if test="${pInfoMapFree.salepercent eq '0'}">					
							<span class="netPrice" style="text-decoration: none;">정가: <fmt:formatNumber value="${pInfoMapFree.price}" pattern="#,###,###" />원</span>&nbsp;&nbsp;&nbsp;
						</c:if>
						<c:if test="${pInfoMapFree.salepercent ne '0'}">					
							<span class="netPrice">정가: <fmt:formatNumber value="${pInfoMapFree.price}" pattern="#,###,###" />원</span>&nbsp;&nbsp;&nbsp;
							<span class="salePrice">할인가: <fmt:formatNumber value="${pInfoMapFree.saleprice}" pattern="#,###,###" />원</span>
						</c:if>
					</div>
					
					<%-- fk_snum이 0이면 BEST 상품, 1이면 NEW 상품, -1이면 해당 없음 --%>
					<div style="float: left">
						<c:if test="${pInfoMapFree.spec == 'BEST'}">
							<span class="best spec">BEST</span>
						</c:if>
						
						<c:if test="${pInfoMapFree.spec == 'NEW'}">
							<span class="new spec">NEW</span>
						</c:if>
						
						<c:if test="${pInfoMapFree.spec == 'BEST/NEW'}">
							<span class="best spec">BEST</span>
							<span class="new spec">NEW</span>
						</c:if>	
					</div>
				</div>
		    </div>
		</c:forEach>
	</div>
	<div class="caseGroup" id="fNext" style="margin-left:20px; margin-top:120px;">
		<img src="<%=ctxPath%>/images/homeMain/nextIcon.png" class="movebt" />
	</div>

</div>
	
<jsp:include page="../footer.jsp" />
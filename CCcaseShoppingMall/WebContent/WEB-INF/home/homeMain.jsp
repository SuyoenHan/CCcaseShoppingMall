<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath= request.getContextPath();
%>

<style type="text/css">

	div.homeBorderImg{
		border: solid 0px blue;
		width: 1100px;
		height: 100px;
		clear: both;
		margin-left: 30px;
		background-color: #dcdcda;
	}
	
	div.productOuter{
		border: solid 0px red;
		float:left;
		margin: 0px 10px 100px 35px;
		width:210px;
		height: 300px;
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
			
			
		
		// 문서 로딩시 오른쪽으로 넘기는 버튼 자동 실행시키기	
		
		var nNextAuto= setInterval(function(){
						$('div#nNext').trigger('click');//이벤트 발생
				  },2000);

		var bNextAuto= setInterval(function(){
						$('div#bNext').trigger('click');//이벤트 발생
  				  },2000);
		
	}); // end of $(document).ready(function(){-----------------------
	
	
	
</script>

<jsp:include page="../header.jsp" />
<jsp:include page="../leftSide.jsp" />

<div id="contents" style="height:1600px;">

	<div class="homeBorderImg" style="margin-top:30px;">경계이미지</div>

	
	<div class="mainTitle" align="center">&nbsp;&nbsp;BEST</div>	
	<div class="caseGroup" style="margin-top:120px; margin-left:30px;"  id="bPrev">
		<img src="<%=ctxPath%>/images/homeMain/prevIcon.png" class="movebt" />
	</div>
	<div class="caseGroup" id="bestContainer">		
		<%-- 메인화면의 베스트상품 나열 --%>
		<c:forEach var="pInfoMapBest" items="${pInfoListBest}" varStatus="statusB">
			
			<div class="productOuter" align="center" id="BEST${statusB.count}">
				<input type="hidden" value="${pInfoMapBest.productid}" />
				<img src="<%=ctxPath%>/images/product/${pInfoMapBest.pimage1}" class="pImg" id="${pInfoMapBest.productid}" width="210" height="200" />
				<div class="productName">[${pInfoMapBest.cname}]&nbsp;[${pInfoMapBest.modelname}]<br>${pInfoMapBest.productname}</div>
				
				<div>
					<span class="netPrice">정가: ${pInfoMapBest.price}</span>&nbsp;&nbsp;&nbsp;
					<span class="salePrice">할인가: ${pInfoMapBest.saleprice}</span>
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
		</c:forEach>
	</div>
	<div class="caseGroup" id="bNext" style="margin-left:20px; margin-top:120px;">
		<img src="<%=ctxPath%>/images/homeMain/nextIcon.png" class="movebt" />
	</div>


	<div class="homeBorderImg" style="clear:both;">경계이미지</div>
	
	
	<div class="mainTitle" align="center">&nbsp;&nbsp;NEW</div>	
	<div class="caseGroup" style="margin-top:120px; margin-left:30px;"  id="nPrev">
		<img src="<%=ctxPath%>/images/homeMain/prevIcon.png" class="movebt" />
	</div>
	<div class="caseGroup" id="newContainer">		
		<%-- 메인화면의 베스트상품 나열 --%>
		<c:forEach var="pInfoMapNew" items="${pInfoListNew}" varStatus="statusN">
			
			<div class="productOuter" align="center" id="NEW${statusN.count}">
				<input type="hidden" value="${pInfoMapNew.productid}" />
				<img src="<%=ctxPath%>/images/product/${pInfoMapNew.pimage1}" class="pImg" id="${pInfoMapNew.productid}" width="210" height="200" />
				<div class="productName">[${pInfoMapNew.cname}]&nbsp;[${pInfoMapNew.modelname}]<br>${pInfoMapNew.productname}</div>
				
				<div>
					<span class="netPrice">정가: ${pInfoMapNew.price}</span>&nbsp;&nbsp;&nbsp;
					<span class="salePrice">할인가: ${pInfoMapNew.saleprice}</span>
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
		</c:forEach>
	</div>
	<div class="caseGroup" id="nNext" style="margin-left:20px; margin-top:120px;">
		<img src="<%=ctxPath%>/images/homeMain/nextIcon.png" class="movebt" />
	</div>
	
</div>
	
<jsp:include page="../footer.jsp" />
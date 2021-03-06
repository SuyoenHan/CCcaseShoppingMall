<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath= request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">

	button.funcBt{
		font-size: 13pt;
		font-weight: bold;
		width: 150px;
		height: 50px;
		background-color: #e1e8ea;
		border: solid 1px #6d919c;
	}
	
	button.funcBt:hover{
		background-color: #87a3ab;
		color: #fff;
		font-weight: bold;
	}

	table#cardTable{
		border: solid 0px red;
		width: 500px;
	}
	
	table#cardTable th {
		text-align: center;
		line-height: 40px;
		border-right: solid 2px #caceca;
		background-color: #f0f4f5;
		border-bottom: solid 2px #caceca;
	}

	table#cardTable td{
		padding-left: 20px;
	}

	div#event{
		background-color: #6d919c;
		font-weight: bold;
	}
	
	div#event a{
		text-decoration: none;
		color:#fff;
		font-weight: bold;
	}
</style>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

	var arrImg= ["cardGameImg1","cardGameImg2","cardGameImg3","cardGameImg4","cardGameImg5"]; // 기본배열
	var arrNewImg=[];  // 랜덤으로 넣을 배열 
	
	
	$(document).ready(function(){
		
		$("button#goCoupon").hide();
		goBackURL = "${requestScope.goBackURL}";
		goBackURL = goBackURL.replace(/ /gi, "&");
		
		var html="";
		for(var i=0;i<arrImg.length;i++){
			html+="<img class='cardBack' src='<%=ctxPath%>/images/event/cardGameBackImg.png' width='180' height='230' style='margin-left:25px; cursor:pointer;' />";
		}
		
		$("div#div1").html(html);
	    
	    var arrOld=[];
	    for(var i=0;i<arrImg.length;i++){
	    	arrOld[i]=-1;  // 사용되지 않는 숫자로 배열 초기화 
	    }
	    
	    var arrRndIndex=[];
	    for(var i=0; i<arrImg.length; i++){
	    	var nRandom= Math.floor( Math.random()*(4-0+1) ) + 0; 
	    	var bFlag= false;
	    	for(var j=0;j<arrOld.length;j++){
	    		if(arrOld[j]==nRandom){  
	    			bFlag=true;
	    			break;
	    		}
	    	} // end of for------------------

	    	if(!bFlag){ // 해당배열에 같은 숫자가 존재하지 않는 경우 배열에 넣어주기
	    		arrOld[i]= nRandom;	
	    		arrRndIndex[i]=nRandom; 
	    	}
	    	else{ // 해당배열에 같은 숫자가 존재하는 경우 다시 뽑기
	    		i--;
	    	    continue;
	    	}
	    }
		
	    for(var i=0; i<arrRndIndex.length;i++){
	    	var j= arrRndIndex[i];
	    	arrNewImg[i] = arrImg[j];
	    	
	    }// end of for-------------------
	
		$(document).on('click',"img.cardBack",function(){

			if("${sessionScope.loginuser.userid}" != ""){
				var fk_userid= "${userid}";
				var indexCardBack= $("img.cardBack").index($(this));
			
				$.ajax({ // 중복참여 방지 테이블에insert
					url:"<%=request.getContextPath()%>/board/gawibawiboEventInsert.cc",
					type:"post",
					data:{"userid":"${userid}",
						  "eventno":"${eventno}"},
					dataType:"json",
					success:function(json){
						if(json.n==0){ // 중복참여자인 경우
							alert(json.msg);
							location.href="<%=ctxPath%>/board/eventList.cc";
							return;
						}
						else{
							var html="";
							for(var i=0;i<arrNewImg.length;i++){
								html+="<img class='cardFront' src='<%=ctxPath%>/images/event/"+arrNewImg[i]+".png' width='180' height='230' style='margin-left:25px; cursor:pointer;' />";
							}
							$("div#div1").html(html);
							
							if(arrNewImg[indexCardBack]=="cardGameImg1" || arrNewImg[indexCardBack]=="cardGameImg5"){
								$("div#result").html("꽝입니다! 이벤트에 참여해주셔서 감사합니다.").css({'color':'red','font-size':'13pt'});
							}
							else if(arrNewImg[indexCardBack]=="cardGameImg2" ){
								$("div#result").html("10% 할인 쿠폰 당첨!<br/> 마이페이지 > 쿠폰함에서 확인 가능합니다.").css({'color':'red','font-size':'13pt'});
								$("button#goCoupon").show();
								insertCoupon(fk_userid,"0","1","이벤트 당첨 할인쿠폰[10%]","0.1");
							}
							else if(arrNewImg[indexCardBack]=="cardGameImg3" ){
								$("div#result").html("20% 할인 쿠폰 당첨!<br/> 마이페이지 > 쿠폰함에서 확인 가능합니다.").css({'color':'red','font-size':'13pt'});
								$("button#goCoupon").show();
								insertCoupon(fk_userid,"0","1","이벤트 당첨 할인쿠폰[20%]","0.2");
							}
							else if(arrNewImg[indexCardBack]=="cardGameImg4" ){
								$("div#result").html("50% 할인 쿠폰 당첨!<br/> 마이페이지 > 쿠폰함에서 확인 가능합니다.").css({'color':'red','font-size':'13pt'});
								$("button#goCoupon").show();
								insertCoupon(fk_userid,"0","1","이벤트 당첨 할인쿠폰[50%]","0.5");
							}
							
							$("div#div1 > img.cardFront").eq(indexCardBack).css('border','solid 2px blue');
						}
					},
					error: function(request, status, error){
				           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				    }
				}); // end of $.ajax({--------------------	
		
			}
			
			else{
				alert("회원 로그인 후 이용 가능합니다.");
				location.href="<%=ctxPath%>/"+goBackURL;
			} // end of else----------------------------------------	
		}); // end of click event---------------------------------
		
		func_height();		
		
		
		$("button#goEventList").click(function(){
			location.href = "<%=ctxPath%>/"+goBackURL;
		}); 
		
		$("button#goCoupon").click(function(){
			location.href = "<%=ctxPath%>/member/availableCoupon.cc";
		});
		
		$("span#prevEvent").click(function(){
			location.href="<%=ctxPath%>/board/gawibawiboEvent.cc?eventno=1&goBackURL=${requestScope.goBackURL}"; 
		})
		
		
		
	}); // end of $(document).ready(function(){}------------

			
	// function declaration
	function insertCoupon(fk_userid,cpstatus,cpcontent,cpname,cpdiscount){
		
		$.ajax({
			url: "<%=ctxPath%>/board/eventCouponInsert.cc",
			type: "post",
			data: {"fk_userid":fk_userid,"cpstatus":cpstatus,"cpcontent":cpcontent,"cpname":cpname,"cpdiscount":cpdiscount},
			dataType: "JSON",
			success:function(json){},
			error: function(request, status, error){
		           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		    }
		}); // end of $.ajax({------------------- 
	}// end of function insertCoupon-----------------------------------------
	

</script>
<jsp:include page="../header.jsp" />
<jsp:include page="../communityLeftSide.jsp"/>
<div id="contents" style="border: solid 0px red; margin-left:30px; margin-bottom:100px;">

	<h2 style="margin: 20px;">EVENT</h2>
	<table id="cardTable">

        <tr>
            <th>제목</th>
            <td>${title}</td>        
        </tr>
        <tr>
            <th>작성자</th>
            <td>${fk_adminid}</td>
        </tr>
        <tr>
            <th>시작일</th>
            <td>${startdate}</td>
        </tr>
        <tr>
            <th>종료일</th>
            <td>${enddate}</td>
        </tr>
        <tr>
            <th style="border-bottom:none;">등록일</th>
            <td>${registerdate}</td>
        </tr>
	</table>
	
	<div style="border-bottom: solid 2px #caceca; margin-top: 20px;"></div>

	<div style="border: solid 0px red; margin: 30px 0px 50px 0px; font-size:15pt;" align="center">
		카드 한장을 선택해주세요 [60% 당첨확률]
	</div>
	<div id="div1"></div>
	<div id="result" align="center" style="margin: 30px 0px 50px 0px;"></div>
	
	<div align="center">
		<button type="button" class="funcBt" id="goCoupon">쿠폰함 가기</button>
		<button type="button" class="funcBt" id="goEventList">목록으로</button>
	</div>
	

	<div style="font-weight: bold; margin-top:100px; font-size:12pt; height: 30px; border-bottom: 1px solid #444444;">
		이전글
		<c:choose>
			<c:when test="${requestScope.epvo.eventno eq null}">
				<span style="color: red; padding: 10px; text-align: center;">
					 이전글이 없습니다. 
				</span>
			</c:when>
			<c:when test="${requestScope.epvo.eventno ne null}">
				<span style="margin-left:20px;">${requestScope.epvo.eventno}</span>
				<span id="prevEvent" style="cursor: pointer; margin-left:20px;">${requestScope.epvo.title}</span>
			</c:when>
		</c:choose>
	</div>
	<div style="font-weight: bold; margin-top:10px; font-size:12pt;">
		다음글
		<c:choose>
			<c:when test="${requestScope.envo.eventno eq null}">
				<span style="color: red; padding: 10px; text-align: center; margin-left:20px;">
					 다음 글이 없습니다. 
				</span>
			</c:when>
			<c:when test="${requestScope.envo.eventno ne null}">
				<span style="margin-left:20px;">${requestScope.envo.eventno}</span>
				<span style="cursor: pointer; margin-left:20px;">${requestScope.envo.title}</span>
			</c:when>
		</c:choose>
	</div>
	
</div>
<jsp:include page="../footer.jsp" />

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%String ctxPath= request.getContextPath();%>

<style type="text/css">
	
	div.myShopping {
		background-color: navy;
		color: white;
		text-align: center;
		padding: 15px 0;
		font-wieght: bold;
	}
	
	div.lside {
		text-align : center;
		background-color: #f2f2f2;
		border-bottom: solid 1px #cecfce; 
		cursor: pointer;
		padding: 15px 0;
		align:center;
	}
	
	div.lside > a{
		color: black;
		text-decoration: none;
		display: inline-block;
		width: 170px;
		border: solid 0px red;
	}
	
	div.lside:hover {
		background-color: #99ccff;
		text-decoration: none;
		text-align: center;
		font-weight: bold;
	} 
	
	div#leftContainer{
		position: relative;
	}
	
</style>
<script type="text/javascript">


	$(document).ready(function(){
			
		// === 스크롤 위치에 따라 왼쪽 사이드바 위치 옮겨주기 
		$(window).scroll(function(){
			
			var scrollTop= $(window).scrollTop();
			if(scrollTop>400){
				return false; // footer 부분 침범하지 않도록 이벤트 종료
			}
			
			$("div#leftContainer").css("top",scrollTop);	
			
		}); // end of scroll event--------------------
		
		
	}); // end of $(document).ready(function(){ 


	
	function goMyboard(userid){
		location.href="<%= request.getContextPath()%>/member/memberWriteListMain.cc?userid="+userid;
	}
	
	// === 회원정보수정 이동 함수 ===
	function myProfile(userid){
		location.href="<%= request.getContextPath()%>/member/memberEditMain.cc?userid="+userid;
	}

</script>
<div id="leftSide" style="margin-bottom: 200px;">

	<div id="leftContainer">	
		<div class="myShopping" style="margin-bottom: 10px;">나의 쇼핑 내역</div>
		<div class="lside" id="editMyInfo" onclick="myProfile('${(sessionScope.loginuser).userid}');">회원&nbsp;정보&nbsp;수정</a></div>
		<div class="lside" id="myOrderList"><a href="<%= ctxPath%>/order/myOrderList.cc">주문&nbsp;내역&nbsp;조회</a></div>
		<div class="lside" id="myCouponList"><a href="<%= ctxPath%>/member/availableCoupon.cc">쿠폰&nbsp;조회</a></div>
		<div class="lside" id="myInterestProduct"><a href="<%= ctxPath%>/member/myInterestProduct.cc">관심상품&nbsp;조회</a></div>
		<div class="lside" id="myWriting" style="border-bottom: none;"><a href="javascript:goMyboard('${(sessionScope.loginuser).userid}');">게시물&nbsp;관리</a></div>
	</div>
</div>
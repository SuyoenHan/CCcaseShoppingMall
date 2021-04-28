<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%String ctxPath= request.getContextPath();%>

<style type="text/css">
	
	#container {
		align: center;
	}
	
	.myShopping {
		width: 40px;
		border-radius: 20px;
	}

	#myProfileOpt {
		width: 40px;
		border-radius: 20px;	
	}
	
	#myProfileOpt:hover {
		background-color: #99ccff;
		color: white;
	}
	
</style>

<div id="leftSide">

	<div id="container">
			
		<div class="myShopping" >나의 쇼핑 내역</div>
		<div class="myProfileOpt" id="myOrderList">주문 내역 조회</div>
		<div class="myProfileOpt" id="myInfoEdit">회원 정보 수정</div>
		<div class="myProfileOpt" id="myPoint">적립금 내역</div>
		<div class="myProfileOpt" id="myCoupon">쿠폰 조회</div>
		<div class="myProfileOpt" id="myFavList">관심상품 조회</div>
		<div class="myProfileOpt" id="myPost">게시물 관리</div>
		
	</div>
</div>
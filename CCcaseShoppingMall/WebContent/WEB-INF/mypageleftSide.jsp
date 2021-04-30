<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%String ctxPath= request.getContextPath();%>

<style type="text/css">
	
	.myShopping {
		background-color: navy;
		color: white;
		text-align: center;
		padding: 15px 0;
		font-wieght: bold;
	}
	
	.lside {
		text-align : center;
		background-color: #f2f2f2;
	}
	
	#myProfileOpt {
		display: inline-block;
		border: none;
		cursor: pointer;
		padding: 15px 0;
		align:center;
		text-decoration: none;
		
	}
	
	.lside:hover {
		background-color: #99ccff;
		color: white;
		text-decoration: none;
		text-align: center;
		font-weight: bold;
	}
	
</style>

<div id="leftSide">

	<div id="leftContainer">
			
		<div class="myShopping">나의 쇼핑 내역</div>
		<div class="lside"><a href="" id="myProfileOpt">주문&nbsp;내역&nbsp;조회</a></div>
		<div class="lside"><a href="" id="myProfileOpt">회원&nbsp;정보&nbsp;수정</a></div>
		<div class="lside"><a href="" id="myProfileOpt">적립금&nbsp;내역</a></div>
		<div class="lside"><a href="<%= ctxPath%>/member/availableCoupon.cc" id="myProfileOpt">쿠폰&nbsp;조회</a></div>
		<div class="lside"><a href="" id="myProfileOpt">관심상품&nbsp;조회</a></div>
		<div class="lside"><a href="" id="myProfileOpt" class="waveEffect">게시물&nbsp;관리</a></div>
	</div>
</div>
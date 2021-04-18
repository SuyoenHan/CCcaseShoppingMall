<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath= request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>HomeMain</title>

<link rel="stylesheet" href="css/style.css" />
</head>

<body>

	<div id="container">
	
		<div id="logo">
			<img src="images/homeMain/logo.png" alt="로고이미지" width="250" height="100" />
		</div>
		
		<div id="mainMenu">
			<span class="menuSection" id="allCase">전체메뉴</span>
			<span class="menuSection" id="hardCase">하드케이스</span>
			<span class="menuSection" id="jellyCase">젤리케이스</span>
			<span class="menuSection" id="bumperCase">범퍼케이스</span>
			<span class="menuSection" id="acc">악세사리</span>
			<span class="menuSection" id="community">커뮤니티</span>
		</div>
		
		<div id="login">
			<div>
				<button type="button" onclick="location.href='login/login.jsp'">로그인</button>
				<span class="loginSection" id="register">회원가입</span>
			</div>
			<div>
				<span class="loginSection" id="wishlist">장바구니</span>
				<span class="loginSection" id="myPage">마이페이지</span>
			</div>
		</div>	
		
		<div id="leftSide">
			<div id="leftContainer">
				<div class="leftSection" id="best">Best 50</div>
				<div class="leftSection" id="new">신상 10% 할인</div>
				<div class="leftSection" id="accLeft">악세사리</div>
				<div class="leftSection" id="free">무료배송 상품</div>
			</div>
		</div>
		
		<div id="contents"> 컨텐츠 내용</div>
		
		<div id="rightSide">오른쪽 사이드</div>
		
		<div id="footer">
			<div class="footerSection">
				<span style="font-size:20pt; font-weight: bold;">CCcase</span><br>
				COPYRIGHT &copy; CCcase ALL RIGHTS RESERVED<br><br><br><br><br>
			</div>
			<div class="footerSection" style="padding-left:50px; margin-left: 120px;">
				<span style="font-weight: bold;">BANK INFO</span><br>
				농협 000-0000-0000-00<br>
				신한 000-0000-0000-00<br>
				국민 000-0000-0000-00<br>
				예금주 (주) CCcase<br><br><br>
			</div>
			<div class="footerSection" style="padding-left:100px;">
				<br>
				<table>
					<tr>
						<td rowspan="2">전화이미지</td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;02-0000-0000</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;010-0000-0000</td>
					</tr>
				</table>
				<br>
				<span style="font-weight: bold;">영업일</span><br>
				평일 오전 09:00~오후5:30<br>
				점심 오후 1:00~ 오후 2:00<br>
				토 / 일 / 공휴일 휴무
			</div>
			<div style="margin-left:50px; margin-top:40px;">
				<button type="button" class="footerNavigator" id="companyInfo">회사소개</button>
				<button type="button" class="footerNavigator" id="location">위치</button>
				<button type="button" class="footerNavigator" id="notice">공지사항</button>
				<button type="button" class="footerNavigator" id="q&a">상품문의</button>
				<button type="button" class="footerNavigator" id="orderDetail">주문조회</button>
				<button type="button" class="footerNavigator" id="review">고객리뷰</button>
			</div>
		</div>
	</div>

</body>
</html>
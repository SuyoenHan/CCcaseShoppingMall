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
<title>HomeMain 화면</title>

<link rel="stylesheet" href="../../css/style.css" />
</head>

<body>

	<div id="container">
	
		<div id="logo">
			<img src="<%= ctxPath%>/images/homeMain/logo.png" alt="로고이미지" width="170" height="80" />
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
				<span class="loginSection" id="login">로그인</span>
				<span class="loginSection" id="register">회원가입</span>
			</div>
			<div>
				<span class="loginSection" id="wishlist">장바구니</span>
				<span class="loginSection" id="myPage">마이페이지</span>
			</div>
		</div>	
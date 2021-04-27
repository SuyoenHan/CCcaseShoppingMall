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
<title>AdHomeMain 화면</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		
		$("span#login").click(function(){
			
			location.href="<%= ctxPath %>/admin/adminlogin.cc";
		});// end of $("span#login").click(function(){
		
		
		
		
	});// end of $(document).ready(function(){


</script>
</head>

<body>

	<div id="container">
	
		<div id="logo">
			<img src="<%= ctxPath%>/images/homeMain/logo.png" alt="로고이미지" width="170" height="80" />
		</div>
		
		<div id="mainMenu">
			<span class="menuSection" id="registerProduct">상품등록</span>
			<span class="menuSection" id="updateProduct">상품수정</span>
			<span class="menuSection" id="viewMember">회원조회</span>
			<span class="menuSection" id="viewBoard">게시판관리</span>
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
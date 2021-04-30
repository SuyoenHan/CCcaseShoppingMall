<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath= request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>관리자페이지</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css" />

<style>

	span, img#logo {
		cursor : pointer;
	}
	

</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		// 로그인 버튼 클릭시 로그인페이지로 이동
		$("span#login").click(function(){
			
			location.href="<%= ctxPath %>/admin/adminlogin.cc";

		});// end of $("span#login").click(function(){
		
			
		// 로그아웃 버튼 클릭시 홈페이지로 이동
		$("span#logout").click(function(){
			
			location.href="<%= ctxPath %>/admin/adminlogout.cc";
			
			
		});// end of $("span#logout").click(function(){
			
			
		// 로고 클릭시 홈페이지로 이동
		
		$("img#logo").click(function(){
		
			location.href="<%= ctxPath %>/admin.cc"
			
		});//end of $("img#logo").click(function(){
		
			

	});// end of $(document).ready(function(){


</script>
</head>

<body>

	<div id="container">
	
		<div id="logo">
			<img id="logo" src="<%= ctxPath%>/images/homeMain/logo.png" alt="로고이미지" width="170" height="80" />
		</div>
		
		<div id="mainMenu">
			<span class="menuSection" id="registerProduct" onclick="location.href='<%= ctxPath%>/admin/productRegister.cc';">상품등록</span>
			<span class="menuSection" id="updateProduct" onclick="location.href='<%= ctxPath%>/admin/productmanage.cc'">상품관리</span>
			
			<span class="menuSection" id="viewMember" onclick="location.href='<%= ctxPath%>/admin/memberList.cc';" >회원조회</span>
			
			<span class="menuSection" id="viewBoard">교환 및 환불관리</span>
			<span class="menuSection" id="viewBoard" onclick="location.href='<%= ctxPath%>/board/faqList.cc';">FAQ관리 </span>
			<span class="menuSection" id="viewBoard" onclick="location.href='<%= ctxPath%>/board/noticeList.cc';">공지사항 관리 </span>
			
		</div>
		
		<div id="login">
			<div>
				<c:if test="${empty sessionScope.adminUser}">
				<span class="loginSection" id="login">로그인</span>
				</c:if>
				<c:if test="${not empty sessionScope.adminUser}">
				<span class="loginSection" id="logout">로그아웃</span>
				</c:if>
				<span class="loginSection" id="register">관리자페이지</span>
			</div>
			<div>
				<span class="loginSection" id="wishlist">공란</span>
				<span class="loginSection" id="myPage">공란</span>
			</div>
		</div>	
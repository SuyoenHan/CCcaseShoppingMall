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
<title>CCcase 관리자페이지</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css" />

<style>
	
	div.menuEachContainer{
		border: solid 0px red;
		display: inline-block;
		height: 150px;
		width: 140px;
		margin-left: 15px;
		padding-top: 20px;
		padding-left: 10px;
	}
	
	button.menuEach{
		background-color: #fff;
		border: none;
		border-bottom: solid 2px #6d919c;		
		text-align: center;
		width: 140px;
		height: 50px;
		cursor: pointer;
		font-size:12pt;
	}
	
	div.menuSort{
		display: none;
		margin-top: 15px;
		padding-left: 10px;
		background-color: #fff;
		border: solid 1px #e1e1db;
	}
	
	div.menuEachContainer:hover > div.menuSort{
		display:block;
	}
	
	div.menuEachContainer:hover > button.menuEach{
		background-color: #e1e8ea;
		font-weight: bold;
		cursor: pointer;
	}
	
	button.loginSection:hover {
		background-color: #33ccff;
	}
	
	button#logout{
		border: solid 0px blue;
		background-color: #f0f4f5;
		display: inline-block;
		font-size: 10pt;
		width: 175px;
		height: 40px;
		margin-top: 15px;
		margin-left: 5px;
		text-align: center;
		cursor: pointer;
	}
	
	button#logout:hover{
		background-color: #b4c6cb;
		font-weight: bold;
	}

	div.menuSort span{
		border: solid 0px red;
		display: inline-block;
		width: 100px;
		margin-left:10px;
		margin-bottom: 8px;
	}
	
	div.menuSort span:hover{
		background-color: #b4c6cb;
		cursor: pointer;
	}
	
	span.dropMenu{
		display: block;
		margin-bottom: 8px;
		font-size: 10pt;
	}
	
	span.dropMenu:hover{
		background-color: #f2f28c;
		color: black;
	}
	
	button.loginSection{
		border: solid 0px blue;
		background-color:  #f0f4f5;
		display: inline-block;
		font-size: 10pt;
		width: 170px !important;
		height: 40px;
		margin-top: 5px;
		margin-left: 5px;
		text-align: center;
		cursor: pointer;
	}
	
	button.loginSection:hover {
		background-color: #b4c6cb;
		cursor: pointer;
		font-weight: bold;
	}
	
	img#logoImg{
		position: relative;
		top:10px;
		left:20px;
		cursor: pointer;
		margin-bottom: 20px !important;
	}
	

	
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		// 로그인 버튼 클릭시 로그인페이지로 이동
		$("button#login").click(function(){
			
			location.href="<%= ctxPath %>/admin/adminlogin.cc";

		});// end of $("span#login").click(function(){
		
			
		// 로그아웃 버튼 클릭시 홈페이지로 이동
		$("button#logout").click(function(){
			
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
			<img id="logo" src="<%= ctxPath%>/images/homeMain/logo.png" alt="로고이미지" width="180" height="100" id="logoImg" />
		</div>
		
		<div id="mainMenu">
		
			<div class="menuEachContainer" style="position:absolute; top: 80px; left: 300px;">
				<button type="button" class="menuEach case" onclick="location.href='<%= ctxPath%>/admin/productRegister.cc';">상품등록</button>
	  		</div>
	  		
	  		<div class="menuEachContainer" style="position:absolute; top: 80px; left: 470px;">
				<button type="button" class="menuEach case" onclick="location.href='<%= ctxPath%>/admin/productmanage.cc'">상품관리</button>
	  		</div>
			
	  		
			<div class="menuEachContainer" style="position:absolute; top: 80px; left: 640px;">
				<button type="button" class="menuEach case" onclick="location.href='<%= ctxPath%>/admin/memberList.cc';">회원조회</button>
	  		</div>
			
			<div class="menuEachContainer" style="position:absolute; top: 80px; left: 810px;">
				<button type="button" class="menuEach case" onclick="location.href='<%= ctxPath%>/admin/changeRefund.cc'">교환 및 환불관리</button>
	  		</div>
			
			<div class="menuEachContainer" style="position:absolute; top: 80px; left: 980px;">
				<button type="button" class="menuEach case">게시물관리</button>
				<div class="menuSort">
					<span class="dropMenu" onclick="location.href='<%= ctxPath%>/board/faqList.cc';" style="margin-top: 8px;">FAQ관리</span>
					<span class="dropMenu" onclick="location.href='<%= ctxPath%>/board/qnaList.cc';">QNA관리</span>
					<span class="dropMenu" onclick="location.href='<%= ctxPath%>/board/noticeList.cc';">공지사항관리</span>
					<span class="dropMenu" onclick="location.href='<%= ctxPath%>/board/eventList.cc';">이벤트관리</span>
				</div>
	  		</div>

		</div>
		
		<div id="login">
			<div>
				<c:if test="${empty sessionScope.adminUser}">
				<button type="button" class="loginSection" id="login" style="margin-top: 20px;">로그인</button>
				</c:if>
				<c:if test="${not empty sessionScope.adminUser}">
				<button type="button" class="loginSection" id="logout" style="margin-top: 20px;">로그아웃</button>
				</c:if>
			</div>
			<div>
				<button type="button" class="loginSection" onclick="location.href='<%= ctxPath%>/home.cc';">홈페이지로 이동</button>
			</div>
		</div>	
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath= request.getContextPath();
%>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>CCcase Shop</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" />

<style type="text/css">

	a.dropMenu{
		display: block;
		margin-bottom: 8px;
		font-size: 10pt;
		text-decoration: none;
	}
	
	div.menuEachContainer{
		border: solid 1px red;
		display: inline-block;
		height: 150px;
		width: 140px;
		margin-left: 15px;
		padding-top: 20px;
		padding-left: 10px;
	}
	
	button.menuEach{
		background-color: #d6d6c2;
		border: none;
		text-align: center;
		width: 120px;
		height: 80px;
	}
	
	a.dropMenu:hover{
		background-color: #f2f28c;
		color: black;
		text-decoration: none;
	}
	
	div.menuSort{
		display: none;
		margin-top: 15px;
		padding-left: 10px;
		background-color: #e1e1db;
		border: solid 1px #e1e1db;
	}
	
	div.menuEachContainer:hover > div.menuSort{
		display:block;
	}
	
	div.menuEachContainer:hover > button.menuEach{
		background-color: #33ccff;
		color: #fff;
	}
	
	button.loginSection:hover {
		background-color: #33ccff;
		color: black;
	}
	
	button#logout{
		border: solid 0px blue;
		background-color: #f2f2f2;
		display: inline-block;
		font-size: 10pt;
		width: 175px;
		height: 40px;
		margin-top: 15px;
		margin-left: 5px;
		text-align: center;
	}
	
	button#logout:hover{
		background-color: #33ccff;
		color: black;
	}

</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
	
			$("button#btnlogin").click(function(){
				location.href="<%= ctxPath%>/login/loginform.cc";
			});
		
			$("button#register").click(function(){
				location.href="<%= ctxPath%>/member/memberRegister.cc";
			});
			
			$("button.case").click(function(){
				
				var selectMenu= $(this).val();
				location.href="<%= ctxPath%>/modelList.cc?cnum="+selectMenu;
				
			}); // end of $("button.menuEach").click(function(){------------
			
				
			$("button#commu").click(function(){
				location.href="<%=ctxPath%>/board/faqList.cc";
			});
			
			
		
	}); // $(documnet).ready(function(){--------------------------------
	
		
	// === 로그아웃 처리 함수 === 	
	function goLogOut() {

		// 로그아웃을 처리해주는 페이지로 이동
		location.href="<%= request.getContextPath()%>/login/logout.cc";
	}
	
	// === 마이페이스 이동 함수 ===
	function myProfile(userid){
		
		location.href="<%= request.getContextPath()%>/member/memberEditMain.cc?userid="+userid;
	}

</script>

</head>

<body>

	<div id="container">
	
		<div id="logo">
			<a href="<%= ctxPath%>/home.cc"><img src="<%= ctxPath%>/images/homeMain/logo.png" alt="로고이미지" width="170" height="80" /></a>
		</div>
		
		<div id="mainMenu">
		
			<div class="menuEachContainer" style="position:absolute; top: 50px; left: 260px;">
	  		 	전체메뉴
		  		<div class="menuSort">
		  			여긴아직~~
		  		</div>
	  		</div>
	  		<div class="menuEachContainer" style="position:absolute; top: 50px; left: 410px;">
	  		 	<button class="menuEach case" id="hardCase" value="1">하드케이스</button>
		  		<div class="menuSort">
		  			<a href="<%= ctxPath%>/product/productList.cc?mnum=1000&cnum=1" class="dropMenu">삼성&nbsp;&nbsp;&nbsp;${sessionScope.paraMap.hardSamCnt}개</a>
		  			<a href="<%= ctxPath%>/product/productList.cc?mnum=2000&cnum=1" class="dropMenu">애플&nbsp;&nbsp;&nbsp;${paraMap.hardAppCnt}개</a>
		  			<a href="<%= ctxPath%>/product/productList.cc?mnum=3000&cnum=1" class="dropMenu">LG&nbsp;&nbsp;&nbsp;&nbsp;${paraMap.hardLgCnt}개</a>
		  		</div>
	  		</div>
	  		<div class="menuEachContainer" style="position:absolute; top: 50px; left: 560px;">
		  		<button class="menuEach case" id="jellyCase" value="2">젤리케이스</button>
		  		<div class="menuSort">
		  			<a href="<%= ctxPath%>/product/productList.cc?mnum=1000&cnum=2" class="dropMenu">삼성&nbsp;&nbsp;&nbsp;${paraMap.jellySamCnt}개</a>
		  			<a href="<%= ctxPath%>/product/productList.cc?mnum=2000&cnum=2" class="dropMenu">애플&nbsp;&nbsp;&nbsp;${paraMap.jellyAppCnt}개</a>
		  			<a href="<%= ctxPath%>/product/productList.cc?mnum=3000&cnum=2" class="dropMenu">LG&nbsp;&nbsp;&nbsp;&nbsp;${paraMap.jellyLgCnt}개</a>
		  		</div>
	  		</div>
	  		<div class="menuEachContainer" style="position:absolute; top: 50px; left: 710px;">
	  		 	<button class="menuEach case" id="bumperCase" value="3">범퍼케이스</button>
		  		<div class="menuSort">
		  			<a href="<%= ctxPath%>/product/productList.cc?mnum=1000&cnum=3" class="dropMenu">삼성&nbsp;&nbsp;&nbsp;${paraMap.bumpSamCnt}개</a>
		  			<a href="<%= ctxPath%>/product/productList.cc?mnum=2000&cnum=3" class="dropMenu">애플&nbsp;&nbsp;&nbsp;${paraMap.bumpAppCnt}개</a>
		  			<a href="<%= ctxPath%>/product/productList.cc?mnum=3000&cnum=3" class="dropMenu">LG&nbsp;&nbsp;&nbsp;&nbsp;${paraMap.bumpLgCnt}개</a>
		  		</div>
	  		</div>
	  		<div class="menuEachContainer" style="position:absolute; top: 50px; left: 860px;">
	  		 	<button class="menuEach">악세사리</button>
		  		<div class="menuSort">
		  			<a href="" class="dropMenu">에어팟케이스&nbsp;&nbsp;&nbsp;수량</a>
		  			<a href="" class="dropMenu">버즈케이스&nbsp;&nbsp;&nbsp;수량</a>
		  			<a href="" class="dropMenu">그립톡&nbsp;&nbsp;&nbsp;&nbsp;수량</a>
		  		</div>
	  		</div>
	  		<div class="menuEachContainer" style="position:absolute; top: 50px; left: 1010px;">
	  		 	<button class="menuEach" id="commu">커뮤니티</button>
		  		<div class="menuSort">
		  			<a href="<%=ctxPath%>/board/faqList.cc" class="dropMenu">FAQ</a>
		  			<a href="<%=ctxPath%>/board/qnaList.cc" class="dropMenu">Q&A</a>
		  			<a href="" class="dropMenu">이벤트</a>
		  			<a href="" class="dropMenu">공지사항</a>
		  			<a href="" class="dropMenu">고객리뷰</a>
		  		</div>
	  		</div>
	  		
		</div>

		<div id="login">
			<c:if test="${empty sessionScope.loginuser}">
				<div>
					<button type="button" class="loginSection" id="btnlogin" >로그인</button>
					<button class="loginSection" id="register">회원가입</button>
				</div>
			</c:if>
			
			<c:if test="${not empty sessionScope.loginuser}">	
				<div>	
					<button type="button" onclick="goLogOut();" id="logout" >로그아웃</button>
				</div>
			</c:if>
					
				<div>
					<button class="loginSection" id="wishlist">장바구니</button>
					<button class="loginSection" id="myPage" onclick="myProfile('${(sessionScope.loginuser).userid}');">마이페이지</button>
				</div>
			
		</div>	
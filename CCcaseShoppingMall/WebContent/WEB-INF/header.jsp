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
		border: solid 0px red;
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
	
	div#mainAll{
		width: 900px;
		height: 600px;
	}
	
	div.mainAllContent{
		border-right: solid 2px #caceca;
		float: left;
		margin-top: 40px;
		width: 160px;
		padding-left: 15px;
		height: 500px;
	}
	
	div.mainAllContent ul{
		list-style-type: none;
		padding-left: 0px;
	}
	
	li.mainAllTitle{
		background-color: #2c302c;
		color: #fff;
		border-radius: 5%;
		text-align: center;
		padding-top: 10px;
		width: 130px;
		height: 40px;	
		font-weight: bold;	
	}
	
	li.mainAllCom{
		background-color:  #fff;
		border-radius: 5%;
		text-align: center;
		padding-top: 10px;
		width: 130px;
		height: 40px;
		font-weight: bold;
		margin: 8px 0px;
	}

	li.mdname{
		line-height: 25px;
	}
	
	li.mdname:hover{
		background-color: #ffffcc;
		font-weight: bold;
	}
	
	div.mainAllContent a{
		text-decoration: none;
	}
	
	li.mainAllCommu:hover{
		background-color: #ffffcc;
		font-weight: bold;
	}
	
	div.menuSort span{
		border: solid 0px red;
		display: inline-block;
		width: 65px;
		margin-left:5px;
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
			
			
			$("img#menuAllMouseover").hide();
			
			$("div#allForEvent").hover(function(){
				$("img#menuAllMouseout").hide();
				$("img#menuAllMouseover").show();
			},function(){
				$("img#menuAllMouseout").show();
				$("img#menuAllMouseover").hide();
			}) // end of hover event--------------------
				
			
			// 나의 장바구니 이동 클릭이벤트
			$("button#wishlist").click(function(){
				location.href="<%=ctxPath%>/member/myCart.cc";
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
		
			<div class="menuEachContainer" id="allForEvent" style="position:absolute; top: 50px; left: 260px;">
	  		 	<img src="<%= ctxPath%>/images/homeMain/menuAllMouseout.png" width="120" height="80" id="menuAllMouseout"/>
		  		<img src="<%= ctxPath%>/images/homeMain/menuAllMouseover.png" width="120" height="80" id="menuAllMouseover"/>
		  		<div class="menuSort" id="mainAll">
		  			<div class="mainAllContent" style="margin-left:40px;">
		  				<ul>
		  					<li class="mainAllTitle">하드케이스</li>
		  					<li class="mainAllCom">삼성</li>
		  					<c:forEach var="modelSH" items="${modelListSH}">
		  						<a href="<%=ctxPath%>/product/productList.cc?mnum=1000&cnum=1&modelName=${modelSH}">
		  							<li class="mdname">&nbsp;${modelSH}</li>
		  						</a>
		  					</c:forEach>
		  					<a href="<%=ctxPath%>/product/productList.cc?mnum=1000&cnum=1">
		  						<li class="mdname">&nbsp;전체보기</li>
		  					</a>
		  					<li class="mainAllCom">애플</li>
		  					<c:forEach var="modelAH" items="${modelListAH}">
		  						<a href="<%=ctxPath%>/product/productList.cc?mnum=2000&cnum=1&modelName=${modelAH}">
		  							<li class="mdname">&nbsp;${modelAH}</li>
		  						</a>
		  					</c:forEach>
		  					<a href="<%=ctxPath%>/product/productList.cc?mnum=2000&cnum=1">
		  						<li class="mdname">&nbsp;전체보기</li>
		  					</a>
		  					<li class="mainAllCom">엘지</li>
		  					<c:forEach var="modelLH" items="${modelListLH}">
		  						<a href="<%=ctxPath%>/product/productList.cc?mnum=3000&cnum=1&modelName=${modelLH}">
		  							<li class="mdname">&nbsp;${modelLH}</li>
		  						</a>
		  					</c:forEach>
		  					<a href="<%=ctxPath%>/product/productList.cc?mnum=3000&cnum=1">
		  						<li class="mdname">&nbsp;전체보기</li>
		  					</a>
		  				</ul>
		  			</div>
		  			<div class="mainAllContent">
		  				<ul>
		  					<li class="mainAllTitle">젤리케이스</li>
		  					<li class="mainAllCom">삼성</li>
		  					<c:forEach var="modelSJ" items="${modelListSJ}">
		  						<a href="<%=ctxPath%>/product/productList.cc?mnum=1000&cnum=2&modelName=${modelSJ}">
		  							<li class="mdname">&nbsp;${modelSJ}</li>
		  						</a>
		  					</c:forEach>
		  					<a href="<%=ctxPath%>/product/productList.cc?mnum=1000&cnum=2">
		  						<li class="mdname">&nbsp;전체보기</li>
		  					</a>
		  					<li class="mainAllCom">애플</li>
		  					<c:forEach var="modelAJ" items="${modelListAJ}">
		  						<a href="<%=ctxPath%>/product/productList.cc?mnum=2000&cnum=2&modelName=${modelAJ}">
		  							<li class="mdname">&nbsp;${modelAJ}</li>
		  						</a>
		  					</c:forEach>
		  					<a href="<%=ctxPath%>/product/productList.cc?mnum=2000&cnum=2">
		  						<li class="mdname">&nbsp;전체보기</li>
		  					</a>
		  					<li class="mainAllCom">엘지</li>
		  					<c:forEach var="modelLJ" items="${modelListLJ}">
		  						<a href="<%=ctxPath%>/product/productList.cc?mnum=3000&cnum=2&modelName=${modelLJ}">
		  							<li class="mdname">&nbsp;${modelLJ}</li>
		  						</a>
		  					</c:forEach>
		  					<a href="<%=ctxPath%>/product/productList.cc?mnum=3000&cnum=2">
		  						<li class="mdname">&nbsp;전체보기</li>
		  					</a>
		  				</ul>
		  			</div>
		  			<div class="mainAllContent">
		  				<ul>
		  					<li class="mainAllTitle">범퍼케이스</li>
		  					<li class="mainAllCom">삼성</li>
		  					<c:forEach var="modelSB" items="${modelListSB}">
		  						<a href="<%=ctxPath%>/product/productList.cc?mnum=1000&cnum=3&modelName=${modelSB}">
		  							<li class="mdname">&nbsp;${modelSB}</li>
		  						</a>
		  					</c:forEach>
		  					<a href="<%=ctxPath%>/product/productList.cc?mnum=1000&cnum=3">
		  						<li class="mdname">&nbsp;전체보기</li>
		  					</a>
		  					<li class="mainAllCom">애플</li>
		  					<c:forEach var="modelAB" items="${modelListAB}">
		  						<a href="<%=ctxPath%>/product/productList.cc?mnum=2000&cnum=3&modelName=${modelAB}">
		  							<li class="mdname">&nbsp;${modelAB}</li>
		  						</a>
		  					</c:forEach>
		  					<a href="<%=ctxPath%>/product/productList.cc?mnum=2000&cnum=3">
		  						<li class="mdname">&nbsp;전체보기</li>
		  					</a>
		  					<li class="mainAllCom">엘지</li>
		  					<c:forEach var="modelLB" items="${modelListLB}">
		  						<a href="<%=ctxPath%>/product/productList.cc?mnum=3000&cnum=3&modelName=${modelLB}">
		  							<li class="mdname">&nbsp;${modelLB}</li>
		  						</a>
		  					</c:forEach>
		  					<a href="<%=ctxPath%>/product/productList.cc?mnum=3000&cnum=3">
		  						<li class="mdname">&nbsp;전체보기</li>
		  					</a>
		  				</ul>
		  			</div>
		  			<div class="mainAllContent">
		  				<ul>
		  					<li class="mainAllTitle">악세사리</li>
		  					<li class="mainAllCom">에어팟케이스</li>
		  					<li class="mainAllCom">버즈케이스</li>
		  					<li class="mainAllCom">그립톡</li>
		  				</ul>
		  			</div>
		  			<div class="mainAllContent" style="border: none;">
		  				<ul>
		  					<li class="mainAllTitle">커뮤니티</li>
		  					<a href="<%=ctxPath%>/board/faqList.cc">
		  						<li class="mainAllCom mainAllCommu">F&nbsp;A&nbsp;Q</li>
		  					</a>
		  					<a href="<%=ctxPath%>/board/qnaList.cc">
		  						<li class="mainAllCom mainAllCommu">Q&nbsp;&&nbsp;A</li>
		  					</a>
		  					<li class="mainAllCom mainAllCommu">이벤트</li>
		  					<li class="mainAllCom mainAllCommu">공지사항</li>
		  					<li class="mainAllCom mainAllCommu">
		  						<a href="<%=ctxPath%>/board/reviewList.cc">고객리뷰</a>
		  					</li>
		  					
		  				</ul>
		  			</div>
		  		</div>
	  		</div>
	  		
	  		<div class="menuEachContainer" style="position:absolute; top: 50px; left: 410px;">
	  		 	<button type="button" class="menuEach case" id="hardCase" value="1">하드케이스</button>
		  		<div class="menuSort">
		  			<a href="<%= ctxPath%>/product/productList.cc?mnum=1000&cnum=1" class="dropMenu"><span>삼성</span>${paraMap.hardSamCnt}개</a>
		  			<a href="<%= ctxPath%>/product/productList.cc?mnum=2000&cnum=1" class="dropMenu"><span>애플</span>${paraMap.hardAppCnt}개</a>
		  			<a href="<%= ctxPath%>/product/productList.cc?mnum=3000&cnum=1" class="dropMenu"><span>LG</span>${paraMap.hardLgCnt}개</a>
		  		</div>
	  		</div>
	  		
	  		<div class="menuEachContainer" style="position:absolute; top: 50px; left: 560px;">
		  		<button type="button" class="menuEach case" id="jellyCase" value="2">젤리케이스</button>
		  		<div class="menuSort">
		  			<a href="<%= ctxPath%>/product/productList.cc?mnum=1000&cnum=2" class="dropMenu"><span>삼성</span>${paraMap.jellySamCnt}개</a>
		  			<a href="<%= ctxPath%>/product/productList.cc?mnum=2000&cnum=2" class="dropMenu"><span>애플</span>${paraMap.jellyAppCnt}개</a>
		  			<a href="<%= ctxPath%>/product/productList.cc?mnum=3000&cnum=2" class="dropMenu"><span>LG</span>${paraMap.jellyLgCnt}개</a>
		  		</div>
	  		</div>
	  		
	  		<div class="menuEachContainer" style="position:absolute; top: 50px; left: 710px;">
	  		 	<button type="button" class="menuEach case" id="bumperCase" value="3">범퍼케이스</button>
		  		<div class="menuSort">
		  			<a href="<%= ctxPath%>/product/productList.cc?mnum=1000&cnum=3" class="dropMenu"><span>삼성</span>${paraMap.bumpSamCnt}개</a>
		  			<a href="<%= ctxPath%>/product/productList.cc?mnum=2000&cnum=3" class="dropMenu"><span>애플</span>${paraMap.bumpAppCnt}개</a>
		  			<a href="<%= ctxPath%>/product/productList.cc?mnum=3000&cnum=3" class="dropMenu"><span>LG</span>${paraMap.bumpLgCnt}개</a>
		  		</div>
	  		</div>
	  		
	  		<div class="menuEachContainer" style="position:absolute; top: 50px; left: 860px;">
	  		 	<button type="button" class="menuEach">악세사리</button>
		  		<div class="menuSort">
		  			<a href="" class="dropMenu">에어팟케이스&nbsp;&nbsp;&nbsp;수량</a>
		  			<a href="" class="dropMenu">버즈케이스&nbsp;&nbsp;&nbsp;수량</a>
		  			<a href="" class="dropMenu">그립톡&nbsp;&nbsp;&nbsp;&nbsp;수량</a>
		  		</div>
	  		</div>
	  		
	  		<div class="menuEachContainer" style="position:absolute; top: 50px; left: 1010px;">
	  		 	<button type="button" class="menuEach" id="commu">커뮤니티</button>
		  		<div class="menuSort">
		  			<a href="<%=ctxPath%>/board/faqList.cc" class="dropMenu">FAQ</a>
		  			<a href="<%=ctxPath%>/board/qnaList.cc" class="dropMenu">Q&A</a>
		  			<a href="<%=ctxPath%>/board/eventList.cc" class="dropMenu">이벤트</a>
		  			<a href="<%=ctxPath%>/board/noticeList.cc" class="dropMenu">공지사항</a>
		  			<a href="<%=ctxPath%>/board/reviewList.cc" class="dropMenu">고객리뷰</a>
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
				<button class="loginSection" id="myPage" onclick="myProfile('${(sessionScope.loginuser).userid}');">
					마이페이지
				</button>
			</div>
			
		</div>	
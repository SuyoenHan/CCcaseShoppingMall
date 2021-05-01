<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	div#mypage{
		margin:120px 0px 0px 200px;
		background-color: #E0E0E0;
		font-size:20pt;
		 /* border: solid 1px blue; */
	}
	span#grade{
		display: inline-block;
	 	background-color:#5E5E5E;
	  	width: 80px;
	   	height:30px;
	    font-size:15pt;
	    text-align: center; 
	    border-radius: 5px; 
	    margin:20px;
	}
</style>


<div id="mypage">
		<span id=grade>
		<c:choose><c:when test="${sessionScope.loginuser.fk_grade eq 0}">브라운</c:when>
		<c:when test="${sessionScope.loginuser.fk_grade eq 1}">실버</c:when>
		<c:otherwise>골드</c:otherwise>
		</c:choose></span>${sessionScope.loginuser.name} 님의 마이페이지
	</div>

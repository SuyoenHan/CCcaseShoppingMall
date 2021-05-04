<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath= request.getContextPath();
%>

<style type="text/css">

	div#cartTitle{
		border: solid 0px red;
		height: 90px;
		font-size: 25pt;
		padding-left: 100px;
	}

	div.eachWishList{
		margin-bottom:30px;
		margin-left: 100px;
		width: 1150;
		background-color: #d1d7d1; 
		height: 20px;
	}
	
	div#continueShopping{
		border: solid 0px red;
		width: 160px;
		height: 40px;
		font-size: 13pt;
		text-align: center;
		padding-top: 8px;
		background-color: #a0aca0;
		font-weight: bold;
		margin: 0px 0px 100px 1090px;		
	}
	
	div#continueShopping:hover{
		background-color: #ecffb3;
	}
	
	div#searchImg{
		border: solid 0px red;
		height: 250px;
		padding-top: 80px;
	}
	
	div#emptyComment{
		border: solid 0px red;
		font-weight: bold;
		height: 100px;	
		margin-top: -30px;
	}
	
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		// 쇼핑계속하기 버튼 클릭 이벤트
	 	$("div#continueShopping").click(function(){
	 		location.href="javascript:history.back()";
	 	}); // end of $("span#continueShopping").click(function(){---------------------
		
		
	}); // end of $(document).ready(function(){-------------------

</script>


<jsp:include page="../header.jsp" />
<div id="contents" style="clear:both; margin-top:50px; width:100%;">

	
	<div id="cartTitle"><span style="color:blue;">${name}</span>님의&nbsp;장바구니</div>
	
	<div class="eachWishList"></div>
	<div id="searchImg" align="center"><img src="<%=ctxPath%>/images/member/search.png" width="130px" height="100px"/></div>
	<div id="emptyComment" align="center">&nbsp;&nbsp;장바구니가 비어 있습니다.</div>
	<div class="eachWishList"></div>
	
	<div id="continueShopping">쇼핑계속하기</div> 
	
</div>
<jsp:include page="../footer.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath= request.getContextPath();
%>

<style type="text/css">

	div#title{
		font-size: 20pt;
		height: 50px;
		border-bottom: solid 2px #a8aba6;
		margin-top: 30px;
	}

	div.eachInterestP{
		margin:30px 0px;
		width: 100%;
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
		margin: 0px 0px 100px 930px;		
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
<jsp:include page="../mypageleftSide.jsp" />
<jsp:include page="myPageHeader.jsp" />
<div id="contents" style="border: solid 0px red; margin:20px 0px 0px 20px; width:80%;">
	
	<div id="title">관심상품 조회</div>
	<div class="eachInterestP"></div>
	<div id="searchImg" align="center"><img src="<%=ctxPath%>/images/member/search.png" width="130px" height="100px"/></div>
	<div id="emptyComment" align="center">&nbsp;&nbsp;관심상품 페이지가 비어 있습니다.</div>
	<div class="eachInterestP"></div>
	
	<div id="continueShopping">쇼핑계속하기</div> 
	
</div>
<jsp:include page="../footer.jsp" />
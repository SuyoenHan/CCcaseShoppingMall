<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath= request.getContextPath();
%>

<style type="text/css">

	div.comLeftSection{
		border-top: solid 1px #b3b3b3;
		border-bottom: solid 1px #b3b3b3;
		background-color: #f2f2f2;
		text-align: center;
		height: 30px;
		margin-bottom: 7px;
	}

	div.comLeftSection:hover{
		background-color: #33ccff;
		color: black; 
	}
	
	a.comNav{
		display: block;
		font-size: 12pt;
		text-decoration: none;
		padding-top: 5px;
	}

	

</style> 
 

 
 
<div id="leftSide">
	<div id="leftContainer">
		
		<div class="comLeftSection" id="faq">
			<a href="<%=ctxPath%>/board/faqList.cc" class="comNav">FAQ</a>
		</div>
		
		<div class="comLeftSection" id="q&a">
			<a href="<%=ctxPath%>/board/qnaList.cc" class="comNav">Q&A</a>
		</div>
		
		<div class="comLeftSection" id="event">
			<a href="" class="comNav">이벤트</a>
		</div>
		
		<div class="comLeftSection" id="notice">
			<a href="<%=ctxPath%>/board/noticeList.cc" class="comNav">공지사항</a>
		</div>
		
		<div class="comLeftSection" id="review">
			<a href="<%=ctxPath%>/board/reviewList.cc" class="comNav">고객리뷰</a>
		</div>
		
	</div>	
</div>
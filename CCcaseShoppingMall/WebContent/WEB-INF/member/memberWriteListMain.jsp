<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

    
<%
	String ctxPath = request.getContextPath();
%>

 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 
<style>

	 
 div#content{
   		margin-left: 17%;
   		margin-top: 5%;
   		width:	80%;
   }	
   tr.qnaInfo:hover {
        background-color: #e6ffe6;
        cursor: pointer;
   }  
   tr#menu{
   		font-weight: bold;
   		font-size: 18px;
   		background-color: gray;
   		height: 40px;
   		 text-align: center;
   	}
   th{
   		border: none; 
   		text-align: center;
   }
   td{
   		width: 10%;
   		height: 35px;
   		text-align: center;
   }
   
    
</style>
  

<script type="text/javascript">

	$(document).ready(function(){
	
		func_height();//footer.jsp에 있음!
		$("input#main").prop("checked",true);
		
		if("${requestScope.sizePerPage}" !=""){
			$("select#sizePerPage").val("${requestScope.sizePerPage}");
			
		}
		$("tr.qnaInfo").click(function(){
		var qnano = $(this).children(".qnano").text();
	
		location.href ="<%= request.getContextPath()%>/board/qnaDetail.cc?qnano="+qnano+"&goBackURL=${requestScope.goBackURL}";
		});// end of $("tr.qnaInfo").click

		
	});// end of $(document).ready(function(){})--------------
	
	function qna(userid){
		$("input#main").prop("checked",false);
		$("input#review").prop("checked", false);
		location.href="<%= request.getContextPath()%>/member/memberWriteListQnA.cc?userid="+userid;
		
	}	
	function review(userid){
		$("input#qna").prop("checked", false);
		$("input#review").prop("checked", true);
		location.href="<%= request.getContextPath()%>/member/memberWriteListReview.cc?userid="+userid;
		
	}
	function main(userid){
		$("input#review").prop("checked", false);
		$("input#qna").prop("checked", false);
		location.href="<%= request.getContextPath()%>/member/memberWriteListMain.cc?userid="+userid;
	}

</script>

<link rel="stylesheet" href="<%=ctxPath%>/css/style.css" />
<jsp:include page="../../WEB-INF/header.jsp" />
<jsp:include page="../../WEB-INF/mypageleftSide.jsp" />


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>



<div id="content" >
	<h3>게시물 관리</h3>
	<hr>
	<h4>게시물 분류</h4>
	<input type="radio" name="main"  id="main" style="margin-left:20px;" OnClick="main('${(sessionScope.loginuser).userid}');">전체
	<input type="radio" name="qna"  id="qna" style="margin-left:20px;" OnClick="qna('${(sessionScope.loginuser).userid}');">Q&A
	    <input type="radio" name="review" id="review" style="margin-left:20px;" OnClick="review('${(sessionScope.loginuser).userid}');">리뷰
	    <table id="qnaTbl" class="table table-bordered" style="margin-top: 20px;">
	        <thead>
	           <tr id="menu">	 
	              <th>No.</th>
	              <th>분류</th>
	              <th>제목</th>
	              <th>작성자</th>
	              <th>등록일자</th>
	              <th>조회수</th>
	           </tr>
	        </thead>

	    	<tbody>
		    	<c:forEach var="qvo" items="${requestScope.qnaList}">
	    			<tr class="qnaInfo">
	    				<td class="qnano">${qvo.qnano}</td>
	    				<td>Q&A</td>
	    				<td>${qvo.qtitle}</td>
	    				<td>${qvo.fk_userid}</td>
	    				<td>${qvo.qregisterdate}</td>
	    				<td class="qviewcount">${qvo.qviewcount}</td>
	    			</tr>
	    		</c:forEach>
	    		<c:forEach var="rvo" items="${requestScope.revList}">
	    			<tr class="reviewInfo">
	    				<td class="qnano">${rvo.reviewno}</td>
	    				<td>상품리뷰</td>
	    				<td>${rvo.rvtitle}</td>
	    				<td>${rvo.fk_userid}</td>
	    				<td>${rvo.rregisterdate}</td>
	    				<td class="qviewcount">${rvo.rviewcount}</td>
	    			</tr>
	    			</c:forEach>
	    	</tbody>
	    </table>
	    
	    <div style="width:30%; margin: 0 auto;">
	    	${requestScope.pageBar}
	    </div>
	    
	    <div>
	    	<h3>작성가능한 리뷰</h3>
	    	<hr>
	    	<table id="qnaTbl" class="table table-bordered" style="margin-top: 20px;">
	    		 <thead>
		           <tr id="menu">	 
		              <th>상품정보</th>
		              <th>주문일자</th>
		              <th>제품번호</th>
		           </tr>
	        </thead>
	    		</table>
	    
	    
	    </div>
	    
	    
	    
</div>

<jsp:include page="../footer.jsp" />




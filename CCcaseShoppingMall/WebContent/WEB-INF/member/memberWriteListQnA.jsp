<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

    
<%
	String ctxPath = request.getContextPath();
%>

 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 <link rel="stylesheet" href="<%=ctxPath%>/css/style.css" />
<style>

	 
  div#content{
   		margin-left: 17%;
   		margin-top: 5%;
   		width:	80%;
   }	
   
   table#qnaTbl {
   		border-left: none;
   		border-right: none;
   }
   table#review{
   		display:inline-block;
   		border: solid 1px red;
   
   }
   tr.qnaInfo:hover {
        background-color: #ecf2f9;
        cursor: pointer;
        transition: 2s;
   }  
   
   tr#menu{
   		font-weight: bold;
   		font-size: 18px;
   		background: #6D919C;
   		text-align: center;
   		color: white;
   		height: 40px;
   }
   

   
   td{
   		width: 10%;
   		height: 35px;
   		text-align: center;
   }
   
   div#pageBar{
   		width:30%; 
   		margin: 0 auto; 
   		font-size: 20px;
   }
     
    div#qna{
		background-color: #6D919C;
		color: white;
	}
 
   div#qna:hover{
     	background-color:#CCF2F4; 
     }
     thead#reviewhead {
   
		 border-bottom: solid 1px gray;

	}
     
</style>
  

<script type="text/javascript">

	$(document).ready(function(){
	
	func_height();//footer.jsp에 있음!
	$("input#qna").prop("checked",true);
	
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
		function revieWirte(odetailno){
			
			location.href="<%= request.getContextPath()%>/board/reviewWrite.cc?odetailno="+odetailno;
			
			
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
	    	</tbody>
	    </table>
  	<div style="width:30%; margin: 0 auto;">
	    	${requestScope.pageBar}
	    </div>
	    
	    <div id="reviewDiv">
	    	<h3>작성가능한 리뷰</h3>
	    	<hr>
	    	<table id="reviewTbl">
	    		 <thead id="reviewhead" >
		           <tr id="menu">	 
		              <th colspan=2><span style="display:inline-block; padding-left: 200px; font-weight: bold; font-size: 13pt;">상품정보</span></th> 
		              <th ><span style="display:inline-block; padding-left: 50px; font-weight: bold; font-size: 13pt;">주문일자</span></th>

		              <th colspan=2 ><span style="display:inline-block; padding-left: 50px; font-weight: bold; font-size: 13pt;">제품번호</span></th>
		              
		           </tr>
	        </thead>
	       
	        <tbody  align=center>
	       
	       <c:forEach var="byreview" items="${requestScope.byreview}">
	    			
	    			<tr>
	    			 
	    				<td><span style="display:inline-block; padding-top: 20px;"><img src="<%= ctxPath%>/images/${byreview.pvo.pimage1}" width="150" height="150" style=" border-radius: 2em;"/> </span>
	    				</td>
	    				<td>

	    				<span style="display:inline-block; font-weight: bold; font-size: 13pt;">${byreview.pvo.productname}</span> <br> 
	    				
	    				<span style="font-size: 10pt;">${byreview.pvo.modelname}</span>
	    				</td>
	    				<td>${byreview.orderdate}</td>
	    				<td>${byreview.pdvo.pnum}</td>
	    				<td colspan=2><button style ="color:white; border:none; border-radius: 5px;background: #6D919C; width: 200px; height: 35px;"onclick="revieWirte('${byreview.odvo.odetailno}');"> 상품 리뷰 작성하기</button></td>
	    			</tr>
	    		</c:forEach>	
		    	
	    	</tbody>
	    		</table>
	    
	    <hr>
	    </div>
	    
	    
	    
</div>

<jsp:include page="../footer.jsp" />




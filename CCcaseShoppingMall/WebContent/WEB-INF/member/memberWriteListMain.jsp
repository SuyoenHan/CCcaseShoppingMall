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
   }
   th{
   		border: none;
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
		
		if("${requestScope.sizePerPage}" !=""){
			$("select#sizePerPage").val("${requestScope.sizePerPage}");
			
		}
		$("tr.qnaInfo").click(function(){
		var qnano = $(this).children(".qnano").text();
	
		location.href ="<%= request.getContextPath()%>/board/qnaDetail.cc?qnano="+qnano+"&goBackURL=${requestScope.goBackURL}";
		});// end of $("tr.qnaInfo").click


		
		
	});// end of $(document).ready(function(){})--------------

</script>

<link rel="stylesheet" href="<%=ctxPath%>/css/style.css" />
<jsp:include page="../../WEB-INF/header.jsp" />
<jsp:include page="../../WEB-INF/mypageleftSide.jsp" />


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>



<div id="content" >
	<h2 style="margin: 20px;">내가쓴 글</h2>
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
	    
</div>

<jsp:include page="../footer.jsp" />




<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>QnA 관리</title>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
 <link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css" />
<style type="text/css">

   div#content{
   		margin-left: 20%;
   		margin-top: 5%;
   		width:	80%;
   }	
   
   td{
   		height: 30px;
   }
   
   td.title{
   		width: 20%;
   }
  
  button {
  		transition-duration: 0.4s;
  }

  button:hover {
  		color: red;
  }

  </style>
  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="https://kit.fontawesome.com/16816a49c3.js" crossorigin="anonymous"></script>
  <script type="text/javascript">

    var goBackURL = "";

	$(document).ready(function(){

		// 목록으로
		goBackURL = "${requestScope.goBackURL}";
		goBackURL = goBackURL.replace(/ /gi, "&");
	

	});// end of $(document).ready(function(){})------------------------
	
	// Function Declaration
	function goQnaList() {
		location.href = "/CCcaseShoppingMall/"+goBackURL;
	}// function goQnaList()----------------------------------------------------
	
	function replyDelete(){
		
		var cmtno_val = $("#cmtno").val();
	    if(confirm("정말로 삭제하시겠습니까?")==true){
          	location.href="adminQnaRepDel.cc?cmtno="+cmtno_val+"";
      }
	}
	
  </script>
	<jsp:include page="../adminheader.jsp" /> 
	<jsp:include page="../leftSide.jsp"/>
</head>
<body> 
	<div id="content" >
	
	<h2 style="margin: 20px;">QnA</h2>
	    
	    <!-- QNA 원글 부분 시작-->
	    <form name="qnaDetailForm">
	    <table style="width: 700px; border-color: lightgray;">

	        <tr>
	            <td class="title">제목</td>
	            <td>${requestScope.qvo.qtitle}</td>        
	        </tr>
	        <tr>
	            <td class="title">작성자</td>
	            <td>${requestScope.qvo.fk_userid}</td>
	        </tr>
	         <tr>
	            <td class="title">등록일</td>
	            <td>${requestScope.qvo.qregisterdate}</td>
	        </tr>
			<tr>
	            <td class="title">이메일</td>
	            <td>${requestScope.qvo.email}</td>
	        </tr>
	        <tr>
	            <td class="title">제품아이디</td>
	            <td>${requestScope.qvo.fk_productid}</td>
	        </tr>     
	        <tr>
	        	<td id="title">공개여부</td>
	        	<td>
	        		<c:choose>
	        			<c:when test="${requestScope.qvo.qstatus eq '0'}">전체공개</c:when>
	        			<c:when test="${requestScope.qvo.qstatus eq '1'}">비공개</c:when>
	        		</c:choose>
	        	</td>
	       	</tr>
	
	        <tr>
	            <td id="title">
	               글내용
	            </td>           
	            <td>${requestScope.qvo.qcontent}</td>        
	        </tr>	        
		</table>
		</form>
		<!-- QNA 원글 부분 끝-->
		
		<div style="display:inline-block;">
		<c:if test="${sessionScope.adminUser.adminid !=null }">
			  <div>
			  		<button type="button" onclick="goQnaList()" style="margin: 30px 0 30px 0;  background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px; ">목록</button>
			  </div>
		</c:if>	
	
		<!-- 답글이 있으면 답글 보여주고, 없으면 답글 버튼 보여주기 -->
		<!-- 답글이 없을 때, 답글 작성 부분 시작 -->
		<c:if test="${empty  requestScope.cmtList}">
	    <div>
	    	<p style="font-size: 15px; color: red; font-weight: bold;">현재 등록된 답글이 없습니다. 답글을 등록해주세요.</p>
		    <a data-toggle="collapse" href="#collapse1"><button type="button" style="background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px;">답글</button></a>		 
		</div>
		</c:if>
		<div id="collapse1" class="panel-collapse collapse">
    	 <div class="panel-body">		
    	 <form method="post" action="adminQnaReply.cc" name="qnaReplyForm" id="qnaReply">    	 	
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">답글쓰기</th>
					</tr>
					<tr>
			            <th>작성자 : <input type="text" name="fk_adminid" value="${sessionScope.adminUser.adminid}" readonly></th>								        
			        </tr>
			        <tr>
						<td><input name="fk_qnano" id="fk_qnano" type="hidden" value="${requestScope.qvo.qnano}"></td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><textarea class="form-control" placeholder="답변 내용" name="cmtcontent" id="cmtcontent" cols="72" rows="15" ></textarea></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" value="등록" id="qnaReply" style="background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px;">				
			</form>
			<!-- 답글 작성 부분 끝 -->
		</div>
	 </div>
	</div>
	
    
	<!-- 답글 보여주기 시작 -->
	<c:if test="${not empty  requestScope.cmtList}">
	  <div>	
  		<form name="qnaReplyDetailForm">
  			<table id="repContent" style="width: 700px; border: 10px; border-color: blue;">
  			<c:forEach var="qcvo" items="${requestScope.cmtList }"> 
  				<tr>
		            <td>등록일</td>
		            <td><input type="text" value="${qcvo.cmtregisterday}" readonly></td>
		            <td><input type="hidden" value="${qcvo.cmtno}" name="cmtno" id="cmtno"></td>
		        </tr>
		        <tr>
		            <td>글내용</td>           
		            <td><textarea readonly>${qcvo.cmtcontent}</textarea></td>
		            <td>
		 	<%-- 	<i class="fas fa-edit fa-2x" onclick="replyEdit()"></i>    --%> 
						<i class="fas fa-trash-alt fa-2x" onclick="replyDelete()" ></i>
		            </td>        
		        </tr>
		        </c:forEach>					        	
  			</table>

  		</form>
  		</div>
  	</c:if>
  	<!--  답글 보여주기 끝 -->
	  		
	</div>
</body>
</html>
 <jsp:include page="../footer.jsp" />
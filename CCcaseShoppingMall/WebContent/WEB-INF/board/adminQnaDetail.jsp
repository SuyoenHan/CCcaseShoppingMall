<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>QnA 관리</title>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
   
  </style>
  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
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
	
	function goReply(){
		
	}// function goReply()------------------------------------------------------	

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
	        	<td>${requestScope.qvo.qstatus}</td>
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
				  		<button type="button" onclick="goQnaList()" style="margin-top: 50px; background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px; ">목록</button>
				  </div>
				  <!-- 답글이 있으면 답글 보여주고, 없으면 답글 버튼 보여주기 -->
				  <!-- 답글 보여주기 시작 -->
				  <div>	
				  		<form name="qnaReplyDetailForm">
				  			<table style="width: 700px; border-color: lightgray;">
				  		        <tr>
						            <td class="title">작성자</td>
						            <td>${requestScope.qvo.fk_adminid}</td>
						        </tr>
				  				 <tr>
						            <td class="title">등록일</td>
						            <td>${requestScope.qvo.cmtregisterday}</td>
						        </tr>
						        <tr>
						            <td id="title">
						               글내용
						            </td>           
						            <td>${requestScope.qvo.cmtcontent}</td>        
						        </tr>						        	
				  			</table>
				  		</form>
				  		<!--  답글 보여주기 끝 -->
				  		<!-- 답글이 없을 때, 답글 작성 부분 시작 -->
				    	<a data-toggle="collapse" href="#collapse1"><button type="button" style="margin-top: 50px; background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px;">답글</button></a>
				  </div>
				
				  <div id="collapse1" class="panel-collapse collapse">
				    	 <div class="panel-body">		    	 	
							<form method="post" action="adminQnaReply.cc" name="qnaReplyForm">
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
											<td><textarea class="form-control" placeholder="답변 내용" name="cmtcontent" cols="72" rows="15" ></textarea></td>
										</tr>
									</tbody>
								</table>
								<input type="submit" value="등록" id="qnaReply" style="background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px;">						
							</form>
							<!-- 답글 작성 부분 끝 -->
						</div>
				  </div>
			</c:if>
		
		</div>
	</div>
</body>
</html>
 <jsp:include page="../footer.jsp" />
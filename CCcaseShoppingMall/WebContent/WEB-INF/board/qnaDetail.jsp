<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<jsp:include page="../header.jsp" /> 
<jsp:include page="../communityLeftSide.jsp"/>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" />

<style type="text/css">

   div#content{
   		margin-left: 20%;
   		margin-top: 10%;
   		width:	100%;
   }	
   
   .maincnt > thead > td,
   .maincnt > tbody > td{
   		height: 40px;
   		padding: 5px;
   }
   
   .maincnt > td.title{
   		width: 30%;
   }
   
   #maintitle{
   		margin-bottom: 10%;
   }
   
	.prev_next {
		margin: 5% 0 5% 0;
	    width: 80%;
	    border-top: 1px solid lightgray;
	    border-collapse: collapse;
	}
	
  .prev_next >  thead > tr > th, 
  .prev_next >  tbody > tr > td {
	    border-bottom: 1px solid lightgray;
	    padding: 10px;
	    text-align: center;
  }
  
  .title{
  		display: inline-block;
  		font-weight: 600;
  		font-size: 15px;
  		width: 100px;
  }
  
  </style>

<script type="text/javascript">

    var goBackURL = "";

	$(document).ready(function(){

		goBackURL = "${requestScope.goBackURL}";
		goBackURL = goBackURL.replace(/ /gi, "&");
				
	});// end of $(document).ready(function(){})------------------------
	
	// Function Declaration
	function goQnaList() {
		location.href = "/CCcaseShoppingMall/board/qnaList.cc";
	}// function goQnaList()----------------------------------------------------
	
	function goEdit(){
		var cmt_val = $("#cmt").val();
		
		if(cmt_val == null){
			location.href= "qnaEdit.cc?qnano=${requestScope.qvo.qnano}";
		}
		else{
			alert("답글이 있는 QNA 글은 수정 불가능합니다. 새로 작성해주세요.");
			location.href = "/CCcaseShoppingMall/"+goBackURL;
		}
	}// end of function goEdit()------------------------------------------------
	
	function goDelete(){
        if(confirm("정말로 삭제하시겠습니까?")==true){
            	location.href="qnaDelete.cc?qnano=${requestScope.qvo.qnano}";
        }
	}// end of function goDelete()---------------------------------------------
	
	function goPrev(){
		location.href= "qnaDetail.cc?qnano=${requestScope.pqna.qnano}";
	}// end of function goPev()-------------------------------------------------
	
	function goNext(){
		location.href= "qnaDetail.cc?qnano=${requestScope.nqna.qnano}";
	}// end of function goNext()------------------------------------------------

</script>

<div id="content" >
<h2 style="padding: 20px 0 20px 0; font-size: 30px; font-weight: bolder; color: #6D919C;">QnA</h2>
    
    <form name="qnaDetailForm">
    <div class="maincnt" style="width: 80%; border:1px solid lightgray; border-left: none; border-right: none;">
 		<header style="margin-bottom: 5%; ">
        	<div style="background-color: rgba(0,0,0,0.1);  color: #6D919C; font-size:25px; font-weight: 600; padding: 3% 0 3% 0; text-align: center;">
            	${requestScope.qvo.qtitle}       
        	</div>
        	<div style="text-align: right; background-color: #D8E4E4; padding: 1% 0 1% 0; border-bottom-left-radius: 20px; border-bottom-right-radius: 20px;">
	            <span class="title" style="font-weight: 600;">작성자 : ${requestScope.qvo.fk_userid}</span>&nbsp;&nbsp;
	            <span style="color:gray;">${requestScope.qvo.qregisterdate}</span>&nbsp;&nbsp;
	        </div>
 		</header>
        <main style="padding-left: 3%;">
	        <div>
	            <span class="title">제품아이디</span>
	            <span>${requestScope.qvo.fk_productid}</span>
	        </div>     
	        <div>
	        	<span class="title">공개여부</span>
	        	<span>
	        		<c:choose>
	        			<c:when test="${requestScope.qvo.qstatus eq '0'}">전체공개</c:when>
	        			<c:when test="${requestScope.qvo.qstatus eq '1'}">비공개</c:when>
	        		</c:choose>
	        	</span>
	       	</div>
			<br><br><br><br>         
	        <div style="background-color: white; width: 700px; height: 300px;">${requestScope.qvo.qcontent}</div>        
	        
        </main>
	</div>
	</form>
  	
	<div style="display:inline-block;">
		<button type="button" onclick="goQnaList()" style="margin-top: 50px; background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px; margin-right: 60%;">목록</button>
	</div>
	<div style="display:inline-block;">
		<c:if test="${sessionScope.adminUser.adminid !=null }">
				<button type="button" onclick="goReply()" style="margin-top: 50px; background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px;">답글</button>
		</c:if>
		<c:if test="${sessionScope.loginuser.userid !=null }">
			<c:if test="${sessionScope.loginuser.userid == requestScope.qvo.fk_userid}">
				<button type="button" onclick="goEdit()" style="margin-top: 50px; background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px;">수정</button>
				<button type="button" onclick="goDelete();" style="margin-top: 50px; background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px;">삭제</button>
			</c:if>
		</c:if>
	</div>
	
	<!-- 답글 보여주기 시작 -->
	<c:if test="${not empty  requestScope.cmtList}">
	  <div style="margin-top: 30px;">	
  		<form name="qnaReplyDetailForm">
  			<table id="repContent" style="width: 700px; border: 10px; border-color: blue;">
  			<c:forEach var="qcvo" items="${requestScope.cmtList }"> 
  				<tr>
		            <td>등록일</td>
		            <td><input type="text" value="${qcvo.cmtregisterday}" readonly></td>
		        </tr>
		        <tr>
		            <td>글내용</td>           
		            <td><textarea id="cmt" readonly>${qcvo.cmtcontent}</textarea></td>        
		        </tr>
		        </c:forEach>									        	
  			</table>
  		</form>
  		</div>
  	</c:if>
  	<!--  답글 보여주기 끝 -->
  	
  	<!-- 이전글, 다음글 조회 -->
	<div>
		<table class="prev_next">
			<thead style="background-color: #6D919C;">
				<tr>
					<th>구분</th>
					<th>글번호</th>
					<th>글제목</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="font-weight: bold;">이전글</td>
					<c:choose>
						<c:when test="${requestScope.pqna.qnano eq null}">
							<td colspan="2" style="color: red; border: medium;"> 이전 글이 없습니다. </td>
						</c:when>
						<c:when test="${requestScope.pqna.qnano ne null}">
							<td>${requestScope.pqna.qnano}</td>
							<td onclick="goPrev()" style="cursor: pointer;">${requestScope.pqna.qtitle}</td>
						</c:when>
					</c:choose>
				</tr>
				<tr>
					<td style="font-weight: bold;">다음글</td>
					<c:choose>
						<c:when test="${requestScope.nqna.qnano eq null}">
							<td colspan="2" style="color: red; border-bottom: 1px solid lightgray; padding: 10px; text-align: center;">
								 다음 글이 없습니다. 
							</td>
						</c:when>
						<c:when test="${requestScope.nqna.qnano ne null}">
							<td>${requestScope.nqna.qnano}</td>
							<td onclick="goNext()" style="cursor: pointer;">${requestScope.nqna.qtitle}</td>
						</c:when>
					</c:choose>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- 이전글, 다음글 끝 -->
	
</div>



 <jsp:include page="../footer.jsp" />
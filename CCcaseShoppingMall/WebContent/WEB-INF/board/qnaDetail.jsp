<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../header.jsp" /> 
<jsp:include page="../communityLeftSide.jsp"/>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" />

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

<script type="text/javascript">

    var goBackURL = "";

	$(document).ready(function(){

		goBackURL = "${requestScope.goBackURL}";
		goBackURL = goBackURL.replace(/ /gi, "&");
				
	});// end of $(document).ready(function(){})------------------------
	
	// Function Declaration
	function goQnaList() {
		location.href = "/CCcaseShoppingMall/"+goBackURL;
	}// function goQnaList()----------------------------------------------------
	
	function goEdit(){
		location.href= "qnaEdit.cc?qnano=${requestScope.qvo.qnano}";
	}
	
	function goDelete(){
	        if(confirm("정말로 삭제하시겠습니까?")==true){
	            location.href="qnaDelete.cc?qnano=${requestScope.qvo.qnano}";
	        }
	}

</script>

<div id="content" >
<h2 style="margin: 20px;">QnA</h2>
    
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

	<div style="display:inline-block;">
		<button style="margin-top: 50px;" type="button" onclick="goQnaList()" style="background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px; margin-right: 60%;">목록</button>
	</div>
	<div style="display:inline-block;">
		<c:if test="${sessionScope.adminUser.adminid !=null }">
				<button style="margin-top: 50px;" type="button" onclick="goReply()" style="background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px;">답글</button>
		</c:if>
		<c:if test="${sessionScope.loginuser.userid !=null }">
			<c:if test="${sessionScope.loginuser.userid == requestScope.qvo.fk_userid}">
				<button style="margin-top: 50px;" type="button" onclick="goEdit()" style="background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px;">수정</button>
				<button style="margin-top: 50px;" type="button" onclick="goDelete();" style="background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px;">삭제</button>
			</c:if>
		</c:if>
	</div>
</div>

 <jsp:include page="../footer.jsp" />
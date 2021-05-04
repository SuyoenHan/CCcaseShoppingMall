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
	function goEventList() {
		location.href = "/CCcaseShoppingMall/"+goBackURL;
	}// function goEventList()----------------------------------------------------
	
	function goEdit(){
			location.href= "eventEdit.cc?eventno=${requestScope.evo.eventno}";
	}
	
	function goDelete(){
        if(confirm("정말로 삭제하시겠습니까?")==true){
            location.href="eventDelete.cc?eventno=${requestScope.evo.eventno}";
        }
	}

</script>

<div id="content" >
<h2 style="margin: 20px;">EVENT</h2>
    
    <form name="eventDetailForm">
    <table style="width: 700px; border-color: lightgray;">

        <tr>
            <td class="title">제목</td>
            <td>${requestScope.evo.title}</td>        
        </tr>
        <tr>
            <td class="title">작성자</td>
            <td>${requestScope.evo.fk_adminid}</td>
        </tr>
        <tr>
            <td class="title">시작일</td>
            <td>${requestScope.evo.startdate}</td>
        </tr>
        <tr>
            <td class="title">종료일</td>
            <td>${requestScope.evo.enddate}</td>
        </tr>
        <tr>
            <td class="title">등록일</td>
            <td>${requestScope.evo.registerdate}</td>
        </tr>
        <tr>
            <td id="title">
               글내용
            </td>           
            <td>${requestScope.evo.content}</td>        
        </tr>
        
	</table>
	</form>
	
  	
	<div style="display:inline-block;">
		<button type="button" onclick="goEventList()" style="margin-top: 50px; background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px; margin-right: 60%;">목록</button>
	</div>
	<div style="display:inline-block;">
		<c:if test="${sessionScope.adminUser.adminid !=null }">
			<button type="button" onclick="goEdit()" style="margin-top: 50px; background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px;">수정</button>
			<button type="button" onclick="goDelete()" style="margin-top: 50px; background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px;">삭제</button>
		</c:if>
	</div>
	
</div>


 <jsp:include page="../footer.jsp" />
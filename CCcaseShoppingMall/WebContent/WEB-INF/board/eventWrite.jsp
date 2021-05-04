<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    

<%
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<title>Event 등록하기</title>
<jsp:include page="../adminheader.jsp" />
<jsp:include page="../adminleftSide.jsp"/>

<link rel="stylesheet" href="<%=ctxPath%>/css/style.css" />

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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 <script type="text/javascript">
	
	 $(document).ready(function(){		
		 
		 document.getElementById("registerdate").valueAsDate = new Date();// 입력일 현재 날짜로 설정

	 });
 
	 // Function declaration

	function on_load(){
		document.eventWriteForm.title.focus();
	}
	
</script>
</head>

<body onload="fn_onload()">
<div id="content" >
<h2 style="margin: 20px;">QnA</h2>
    
    <form action="eventWriteEnd.cc" method="post" name="eventWriteForm">
    <table style="width: 700px; border-color: lightgray;">

        <tr>
            <td class="title">제목</td>
            <td>
                <input name="title" id="title" type="text" size="70" maxlength="50" value=""/>
            </td>        
        </tr>
        <tr>
            <td class="title">작성자</td>
            <td><input type="text" id="fk_adminid" name="fk_adminid" size="70" value="${sessionScope.adminUser.adminid}" readonly></td>
        </tr>
		<tr>
            <td class="title">이벤트 시작일</td>
            <td><input type="date" size="70" id="startdate" name="startdate" ></td>
         </tr>
         <tr>
            <td class="title">이벤트 종료일</td>
            <td><input type="date" size="70" id="enddate" name="enddate" ></td>
        </tr>
        <tr>
            <td class="title">등록일</td>
            <td><input type="date" id="registerdate" name="registerdate" size="70"  value="currentDate" readonly></td>
        </tr>
        <tr>
            <td id="title">
               이벤트 내용
            </td>
            <td>
                <textarea name="content" id="content" cols="72" rows="15"></textarea>            
            </td>        
        </tr>

        <tr align="center" valign="middle">
            <td colspan="5">
                <input type="reset" value="작성취소" >
                <input type="submit" value="등록" >
                <input type="button" value="목록" onClick="location.href='<%=ctxPath%>/board/eventList.cc'" >            
            </td>
        </tr>
    </table>    
    </form>
</div>
</body>
</html>

<jsp:include page="../../WEB-INF/footer.jsp" />
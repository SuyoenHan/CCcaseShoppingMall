<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="board.model.EventVO" %>    
<%@ page import="board.model.EventDAO" %>

<%
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Event 수정하기</title>
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
		 

	 });
	 
 <% 
 String eventno=request.getParameter("eventno");
 EventVO evo = new EventDAO().eventDetail(eventno); 
 
 session.setAttribute("eventno", eventno);
 eventno = (String)session.getAttribute("eventno");
  %>
 
</script>
</head>

<body>
<div id="content" >
<h2 style="margin: 20px;">QnA</h2>
    
    <form action="eventEditEnd.cc" method="post" name="eventEditForm">
    <table style="width: 700px; border-color: lightgray;">

        <tr>
            <td class="title">제목</td>
            <td>			
                <input name="title" id="title" type="text" size="70" maxlength="100" value="<%= evo.getTitle() %>"/>
            </td>
            <td>
            	<input name ="eventno" id="eventno" type="hidden" value="<%=evo.getEventno() %>" />
            </td>        
        </tr>
		<tr>
            <td class="title">작성자</td>
            <td><input type="text" id="fk_userid" name="fk_userid" size="70" value="<%= evo.getFk_adminid() %>" readonly></td>
        </tr>
         <tr>
            <td class="title">등록일</td>
            <td><input type="text" id="registerdate" name="registerdate" size="70" value="<%= evo.getRegisterdate() %>" readonly></td>
        </tr>
         <tr>
            <td class="title">시작일</td>
            <td><input type="text" id="startdate" name="startdate" size="70" value="<%= evo.getStartdate() %>" readonly></td>
        </tr>
         <tr>
            <td class="title">종료일</td>
            <td><input type="text" id="enddate" name="enddate" size="70" value="<%= evo.getEnddate() %>" ></td>
        </tr>

        <tr>
            <td id="title">
               글내용
            </td>
            <td>
                <textarea name="content" id="content" cols="72" rows="15" ><%= evo.getContent()  %></textarea>            
            </td>        
        </tr>

        <tr align="center" valign="middle">
            <td colspan="5">
                <input type="reset" value="작성취소" style="margin-top: 20px; background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px; " >
                <input type="submit" value="등록" style="margin-top: 20px; background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px; ">
                <input type="button" value="목록" onClick="location.href='<%=ctxPath%>/board/eventList.cc'" style="margin-top: 20px; background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px; ">            
            </td>
        </tr>
    </table>    
    </form>
</div>
</body>
</html>

<jsp:include page="../../WEB-INF/footer.jsp" />
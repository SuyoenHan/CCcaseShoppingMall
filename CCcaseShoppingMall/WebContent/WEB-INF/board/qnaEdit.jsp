<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="board.model.QnaVO" %>    
<%@ page import="board.model.QnaDAO" %>

<%
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 수정하기</title>
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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 <script type="text/javascript">
	
	 $(document).ready(function(){		
		 

	 });
	 
 <% 
 String qnano=request.getParameter("qnano");
 QnaVO qvo = new QnaDAO().qnaDetail(qnano); 
 
 session.setAttribute("qnano", qnano);
 qnano = (String)session.getAttribute("qnano");
  %>
 
</script>
</head>

<body>
<div id="content" >
<h2 style="margin: 20px;">QnA</h2>
    
    <form action="qnaEditEnd.cc" method="post" name="qnaEditForm">
    <table style="width: 700px; border-color: lightgray;">

        <tr>
            <td class="title">제목</td>
            <td>			
                <input name="qtitle" id="qtitle" type="text" size="70" maxlength="100" value="<%= qvo.getQtitle() %>"/>
            </td>
            <td>
            	<input name ="qnano" id="qnano" type="hidden" value="<%=qvo.getQnano() %>" />
            </td>        
        </tr>
		<tr>
            <td class="title">작성자</td>
            <td><input type="text" id="fk_userid" name="fk_userid" size="70" value="<%= qvo.getFk_userid() %>" readonly></td>
        </tr>
         <tr>
            <td class="title">등록일</td>
            <td><input type="text" id="qregisterdate" name="qregisterdate" size="70" value="<%= qvo.getQregisterdate() %>" readonly></td>
        </tr>
		<tr>
            <td class="title">이메일</td>
            <td><input type="text" id="email" name="email" size="70" value="<%= qvo.getEmail() %>" readonly></td>
        </tr>
        <tr>
            <td class="title">제품아이디</td>
            <td><input  id="fk_productid" name="fk_productid" type="text" size="70" maxlength="100" value="<%= qvo.getFk_productid() %>"/></td>
        </tr>
        
        <tr>
        	<td id="title">공개여부</td>
        	<td><input type="text" id="qtatus" name="qstatus" size="70" value="<%= qvo.getQstatus() %>" readonly></td>
       	</tr>

        <tr>
            <td id="title">
               글내용
            </td>
            <td>
                <textarea name="qcontent" id="qcontent" cols="72" rows="15" ><%= qvo.getQcontent()  %></textarea>            
            </td>        
        </tr>

        <tr align="center" valign="middle">
            <td colspan="5">
                <input type="reset" value="작성취소" style="margin-top: 20px; background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px; " >
                <input type="submit" value="등록" style="margin-top: 20px; background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px; ">
                <input type="button" value="목록" onClick="location.href='<%=request.getContextPath()%>/board/qnaList.cc'" style="margin-top: 20px; background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px; ">            
            </td>
        </tr>
    </table>    
    </form>
</div>
</body>
</html>

<jsp:include page="../../WEB-INF/footer.jsp" />
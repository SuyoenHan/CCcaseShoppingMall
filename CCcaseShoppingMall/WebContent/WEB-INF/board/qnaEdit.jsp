<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>

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
		 
		 $("#qnaPwd").hide();// 비공개글일 때만 글비번 보여주기
		 
	 });
 
	 // Function declaration
	 
	 // 비공개 글만 비밀번호칸 공개하기
	 function setDisplay(){
	    if($("input:radio[id=qstatus2]").is(":checked")){
	        $("#qnaPwd").show();
	    }
	   else{
	        $("#qnaPwd").hide();
	    }
	}// end of function setDisplay()--------------------------------------

</script>
</head>

<body>
<div id="content" >
<h2 style="margin: 20px;">QnA</h2>
    
    <form action="qnaEditEnd.jsp" method="post" name="qnaEditForm">
    <table style="width: 700px; border-color: lightgray;">

        <tr>
            <td class="title">제목</td>
            <td>
                <input name="qtitle" id="qtitle" type="text" size="70" maxlength="100" value="${requestScope.qvo.qtitle}"/>
            </td>        
        </tr>
		<tr>
            <td class="title">작성자</td>
            <td><input type="text" id="fk_userid" name="fk_userid" size="70" value="${requestScope.qvo.fk_userid}" readonly></td>
        </tr>
         <tr>
            <td class="title">등록일</td>
            <td><input type="text" id="qregisterdate" name="qregisterdate" size="70" value="${requestScope.qvo.qregisterdate}" readonly></td>
        </tr>
		<tr>
            <td class="title">이메일</td>
            <td><input type="text" id="email" name="email" size="70" value="${requestScope.qvo.email}" readonly></td>
        </tr>
        <tr>
            <td class="title">제품아이디</td>
            <td><input  id="fk_productid" name="fk_productid" type="text" size="70" maxlength="100" value="${requestScope.qvo.fk_productid}"/></td>
        </tr>
        
        <tr>
        	<td id="title">공개여부</td>
        	<td><input type="text" id="qtatus" name="qstatus" size="70" value="${requestScope.qvo.qstatus}" readonly></td>
       	</tr>

        <tr>
            <td id="title">
               글내용
            </td>
            <td>
                <textarea name="qcontent" id="qcontent" cols="65" rows="15" >${requestScope.qvo.qcontent}</textarea>            
            </td>        
        </tr>

        <tr align="center" valign="middle">
            <td colspan="5">
                <input type="reset" value="작성취소" >
                <input type="submit" value="등록" >
                <input type="button" value="목록" onClick="location.href='<%=request.getContextPath()%>/board/qnaList.cc'" >            
            </td>
        </tr>
    </table>    
    </form>
</div>
</body>
</html>

<jsp:include page="../../WEB-INF/footer.jsp" />
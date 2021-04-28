<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp" />
<jsp:include page="../leftSide.jsp"/>

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
		 
		 document.getElementById("qregisterdate").valueAsDate = new Date();// 입력일 현재 날짜로 설정

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
<div id="content" >
<h2 style="margin: 20px;">QnA</h2>
    
    <form action="qnaWriteEnd.cc" method="post" name="qnaWriteForm">
    <table style="width: 700px; border-color: lightgray;">

        <tr>
            <td class="title">제목</td>
            <td>
                <input name="qna_title" id="qtitle" type="text" size="70" maxlength="100" value=""/>
            </td>        
        </tr>
        <tr>
            <td class="title">작성자</td>
            <td><input type="text" id="fk_userid" size="70" value="${sessionScope.loginuser.userid}" readonly></td>
        </tr>
         <tr>
            <td class="title">등록일</td>
            <td><input type="date" id="qregisterdate" size="70"  value="currentDate" readonly></td>
        </tr>
		<tr>
            <td class="title">이메일</td>
            <td><input type="text" size="70" id="email" value="${sessionScope.loginuser.email}" readonly></td>
        </tr>
        <tr>
            <td class="title">제품아이디</td>
            <td><input name="qna_productid"  id="fk_productid" type="text" size="70" maxlength="100" value=""/></td>
        </tr>
        
        <tr>
        	<td id="title">공개여부</td>
        	<td>
        		<input type="radio" id="qstatus1" name="qstatus" value="0" checked="checked">
 				<label for="public">공개</label>&nbsp;&nbsp;
 				<input type="radio" id="qstatus2" name="qstatus" value="1" onclick="setDisplay()">
 				<label for="private">비공개</label>
 				<div id="qnaPwd">비밀번호&nbsp;&nbsp;<input type="password" id="qnapwd" maxlength="10"></div>
        	</td>
       	</tr>

        <tr>
            <td id="title">
               글내용
            </td>
            
            <td>
                <textarea name="qna_content" id="qcontent" cols="65" rows="15"></textarea>            
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

<jsp:include page="../../WEB-INF/footer.jsp" />
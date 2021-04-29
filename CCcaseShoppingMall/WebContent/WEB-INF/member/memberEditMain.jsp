<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%
	String ctxPath = request.getContextPath();
    //     /MyMVC
%>    

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<jsp:include page="../../WEB-INF/header.jsp" />
<jsp:include page="../../WEB-INF/leftSide.jsp" />

<style>
	div#MemberEdithome{
		margin-top: 150px;
		margin-left: 200px;
		padding-left: 30px;
		/* border: solid 1px red; */
		
	}
	form{
		padding-left: 50px;
		/* border: solid 1px red; */
	}
	
   table#tblMemberEditMain {
          width: 40%;
         font-size: 12pt;
          /* 선을 숨기는 것 */
         border: hidden;
           /*  border: solid 1px red; */

   }  
   
   table#tblMemberEditMain #th {
  		 /* border: solid 1px red; */
         height: 40px;
         text-align: center;
         background-color: silver;
         font-size: 14pt;
   }
   
   table#tblMemberEditMain td {
      /* 	border: solid 1px blue; */
      	width: 10px;
         line-height: 20px;
         padding-top: 8px;
         padding-bottom: 8px;
      
   }
   
   
   
</style> 


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		
		$("button#btnpwdCheck").click(function(){
			var frm = document.editMainFrm;
			frm.action = "<%= ctxPath%>/member/passwdCheck.cc";
			frm.method = "POST";
			frm.submit();
		});
	});


</script>


<div id="MemberEditMain">
	<div id="MemberEdithome">
		<h2>회원정보확인</h2>
		<h4><span style="color:navy; font-weight: bold;">${sessionScope.loginuser.name}</span> 님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인 합니다.</h4>
		<hr>
		<div id="myprofileInfo">
  <form name="editMainFrm">
		<table id="tblMemberEditMain">
         <tr>
            <td style="width: 50px; font-weight: bold; text-align: left;">아이디&nbsp;</td>
            <td style="width: 50px; text-align: left;">
             <input type="hidden" name="userid" value="${sessionScope.loginuser.userid}"/>  ${sessionScope.loginuser.userid}
            </td>
         </tr>
         <tr>
            <td style="width: 50px; font-weight: bold; text-align:left;">비밀번호&nbsp;</td>
            <td style="width: 50px; text-align: left;">
           <input type="password" name="pwd" id="pwd" placeholder="●●●●" required />
            </td>
         </tr>
            <tr>
            <td colspan="2">
               <button type="button" id="btnpwdCheck" style="background-color:#5B5B5B; margin-left: 50%; margin-top: 4%; width: 60px; height: 30px;"><span style=" color: white; font-color:white; font-size: 10pt;">확인</span></button>
            	 <button type="button" id="back" style="margin-left: 3%; margin-top: 4%; width: 60px; height: 30px;" onClick="javascript:history.back();"><span style=" font-size: 10pt;">취소</span></button>
            </td>
         </tr>
         </table>
		</form>
	     </div>
	</div>


<jsp:include page="../../WEB-INF/footer.jsp" />
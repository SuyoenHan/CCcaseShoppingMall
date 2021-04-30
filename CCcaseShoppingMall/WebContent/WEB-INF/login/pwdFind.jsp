<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%
	String ctxPath = request.getContextPath();
    //     /MyMVC
%>    
<link rel="stylesheet" href="<%= ctxPath %>/css/login.css" /> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../../WEB-INF/header.jsp" />
<script type="text/javascript">

	$(document).ready(function(){
		
		// == 찾기 ==
		$("button#btnFind").click(function(){
			
			var useridVal = $("input#userid").val().trim();
			var nameVal = $("input#name").val().trim();
			var emailVal = $("input#email").val().trim();
			
			// 아이디 및 이메일에 대한 정규표현식을 사용한 유효성 검사는 생략하겠습니다.
			if( useridVal != "" && emailVal != ""&&nameVal != "" ) {
				var frm = document.pwdFindFrm;
				frm.action = "<%= ctxPath%>/login/pwdFind.cc";
				frm.method = "POST";
				frm.submit();
			}
			else {
				alert("정보를 모두 입력하세요!!");
				return;
			}
			
		});// end of $("button#btnFind").click(function(){})-----------------------------
		
		
		var method = "${requestScope.method}";
		
		if(method == "POST") {
			$("input#userid").val("${requestScope.userid}");
			$("input#name").val("${requestScope.name}");
			$("input#email").val("${requestScope.email}");
			$("div#div_findResult").show();
			
			if(${requestScope.sendMailSuccess == true}) {
				$("div#div_btnFind").hide();
			}
		}
		
		if(${requestScope.isUserExist == false}){
			alert("입력하신 정보로 가입된 회원은 존재하지 않습니다.가입한 아이디, 이름, 이메일을 제대로 입력했는지 다시 한 번 확인해주세요.");
			$("input#userid").val("");
			$("input#name").val("");
			$("input#email").val("");
			$("div#div_btnFind").show();
		}
		
		// == 인증하기 ==
		$("button#btnConfirmCode").click(function(){
			
			var frm = document.verifyCertificationFrm;
			
		    frm.userid.value = $("input#userid").val();
			frm.userCertificationCode.value = $("input#input_confirmCode").val();
			
			frm.action = "<%= ctxPath%>/login/verifyCertification.cc";
			frm.method = "POST";
			frm.submit();
		});	
		
		
	});// end of $(document).ready(function(){})---------------------------

</script>

<div id="contents">
	<div id="loginContents">
	
		<form name="pwdFindFrm">
	 		<div class="idSearchForm">
				<ul>
					<li style="text-align: center; font-size: 30px; font-weight: bold; margin-left:40px;">비밀번호 찾기<br><br></li>
					<li>	
						<label class="title">아이디</label>
						<input type="text" class="findinput" placeholder="아이디를 입력해주세요" id="userid" name="userid" maxlength="20">
					</li>
					<li>	
						<label class="title">이름</label>
						<input type="text" class="findinput" placeholder="이름을 입력해주세요" id="name"name="name" maxlength="20">
					</li>
					<li>
						<label class="title">이메일</label>
					  	<input type="email" class="findinput" placeholder="가입하신 이메일을 입력해주세요" id="email" name="email" maxlength="20">
					</li>
				</ul>
		<div id="div_findResult" align="center">

   	   <c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == true}">  
   	   	  <span style="font-size: 12pt; margin-left:2%; text-align: center;	margin-bottom:2%;">인증코드가 <span style="font-weight:bold; color :navy;">${requestScope.email}</span>로 발송되었습니다.</span><br><br>
   	      <span style="font-size: 14pt; font-weight:bold; margin:3% 2% 1% 0%; ">인증코드</span>
   	      <input type="text" name="input_confirmCode" id="input_confirmCode" style="height: 25px; "required />
   	      <br><br>
   	      <button type="button" id="btnConfirmCode" class="emailCon">인증하기</button>
   	   </c:if>
   	   
   	   <c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == false}">  
   	   	  <span style="color: red;">메일발송이 실패했습니다.</span>
   	   </c:if>
   	      
   </div>
          
   <div id="div_btnFind" align="center" style="margin-top:50px;">
   	  <button type="button" class="pwdSearchSubmit" id="btnFind">이메일 인증</button>
   </div>
	  		</div>
		</form>
				
	</div>
</div>
<form name="verifyCertificationFrm">
    <input type="hidden" name="userid" /> 
	<input type="hidden" name="userCertificationCode" />
</form>

<jsp:include page="../../WEB-INF/footer.jsp" />
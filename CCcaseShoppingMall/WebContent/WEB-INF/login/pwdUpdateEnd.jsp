<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%
	String ctxPath = request.getContextPath();
    //     /MyMVC
%>    
<link rel="stylesheet" href="<%= ctxPath %>/css/login.css" /> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<jsp:include page="../../WEB-INF/header.jsp" />
<script type="text/javascript">

	$(document).ready(function(){

		$("input#pwd2").keyup(function(event){
			if(event.keyCode == 13) {
				gopwdUpdate(); 
			}	
		});
		$("button#btnUpdate").click(function(){
			
			var pwd = $("input#pwd").val();
			var pwd2 = $("input#pwd2").val();
			
			// var regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
			// 또는
			var regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
			// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
			
			var bool = regExp.test(pwd);
			
			if(!bool) {
				alert("암호는 8글자 이상 15글자 이하에 영문자,숫자,특수기호가 혼합되어야만 합니다.");
				$("input#pwd").val("");
				$("input#pwd2").val("");
				return;   // 종료
			}
			else if(bool && pwd != pwd2) {
				alert("암호가 일치하지 않습니다.");
				$("input#pwd").val("");
				$("input#pwd2").val("");
				return;   // 종료
			}
			else {
				gopwdUpdate();
			}
		});
			
		function gopwdUpdate() {
			
			var frm = document.pwdUpdateEndFrm;
		 	frm.action = "<%= ctxPath%>/login/pwdUpdateEnd.cc";
		 	frm.method = "POST";
		 	frm.submit();
		 	
		
		}// end of function
		
		var method = "${requestScope.method}";
		
		if(method == "POST") {
			if(${requestScope.n == 1}) {
				alert("비밀번호 변경 되었습니다.");
				location.href="<%= ctxPath%>/home.cc";
			}
		}
		
		
	});// end of $(document).ready(function(){})--------------------------

</script>

<div id="contents">
	<div id="loginContents">
	
		<form name="pwdUpdateEndFrm"">
	 		<div class="idSearchForm">
				<ul>
					<li style="text-align: center; font-size: 30px; font-weight: bold; margin-left:7%;margin-top:3%;">암호 변경<br><br></li>
					<li>	
						<label class="title">새 암호</label>
						<input type="password" class="findinput" placeholder="새 암호를 입력해주세요" id="pwd" name="pwd" maxlength="20" placeholder="PASSWORD" required>
					</li>
					<br>
					<li>	
						<label class="title">새 암호 확인</label>
						<input type="password" class="findinput" placeholder="새 암호를 다시 한번 입력해주세요 " id="pwd2" maxlength="20" placeholder="PASSWORD" required>
					</li>
					
				</ul>
					<br><br>
					
					<input type="hidden" name="userid" value="${requestScope.userid}" />

			   <div id="div_btnUpdate" align="center">
			   	  <button type="button" class="pwdSearchSubmit" id="btnUpdate">암호변경하기</button>
			   </div> 

		   
	  		</div>
		</form>
				
	</div>
</div>

<jsp:include page="../../WEB-INF/footer.jsp" />
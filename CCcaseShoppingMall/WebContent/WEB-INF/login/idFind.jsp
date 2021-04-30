<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
    //     /MyMVC
%>    
    
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%= ctxPath %>/css/login.css" /> 

<jsp:include page="../../WEB-INF/header.jsp" />

<script type="text/javascript">

	$(document).ready(function(){
		
 		$("button#btnFind").click(function(){
			var frm = document.idFindFrm;
			frm.action = "<%= request.getContextPath()%>/login/idFind.cc";
			frm.method = "post";
			frm.submit();
		
		}); 
 
		
	});// end of $(document).ready(function(){})----------------------------------

	
	
</script>

 
 
<div id="contents">
	<div id="loginContents">	
		<form name="idFindFrm">
	    	<div class="idSearchForm">
	 	 		<ul>
		 	 		<li style="margin-top:5%;margin-left:6%; text-align: center; font-size: 30px; font-weight: bold;">아이디 찾기<br><br></li>
					<li>		
						<label class="title">이름</label>
						<input type="text" class="findinput" placeholder="이름을 입력해주세요" name="name" id="name"maxlength="20">
					</li>	
					<li>
						<label class="title">이메일</label>
						<input type="email" class="findinput" placeholder="가입하신 이메일을 입력해주세요" name="email" id="email" maxlength="20">
					</li>

   
				</ul>
				<button type="button" id="btnFind" class="idSearchSubmit">확인</button>
				<div><br><a href="<%= request.getContextPath()%>/login/pwdFind.cc">비밀번호 찾기</a></div>
			</div>
		</form>
		</div>
	<div>
</div>


<jsp:include page="../../WEB-INF/footer.jsp" />








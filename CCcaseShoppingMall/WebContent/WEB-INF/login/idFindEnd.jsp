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

<jsp:include page="../../WEB-INF/header.jsp" />

<style>
	div.loginView{
		text-align:center;
		border: solid 0px red;
		margin: 0 auto;
		margin-left: 400px;
		padding-top: 50px;
		height: 600px;
		width: 600px;
	}
	
	button.loginSubmit {
		background-color: #666;
		color: white;
		padding: 14px 20px;
		margin: 12px 0;
		border: none;
		cursor: pointer;
		height:60px;
		width:80%;
	}
	
	input.form-control{
		height:50px;
		width: 80%;
		margin-top: 10px;
		margin-left:60px;
	}
	
	button.memberRegister{
		background-color: #666;
		color: white;
		padding: 14px 20px;
		margin: 8px 0;
		border: none;
		cursor: pointer;
		width:80%;
	}

	div.idSearchForm{
		background-color: #f2f2f2;
		text-align:center;
		border: solid 0px red; 
		margin: 0 auto;
		margin-left: 400px;
		margin-top: 20px;
		padding-top: 50px;
		height: 500px;
		width: 600px;
	}
	
	button#idFindlogin{
		background-color: #666;
		margin:20px 90px;
		color: white;
		border: none;
		cursor: pointer;
		height:50px;
		width:30%;
		font-size: 18pt;
	}
	div#idfindEnd{
	
		margin:30px 0px 50px 0px;
		text-align:center;
		font-size: 20pt;
	
	}

</style>
<script type="text/javascript">

	$(document).ready(function(){
	
			$("button#idFindlogin").click(function(){
				location.href="<%= ctxPath%>/login/loginform.cc";
			});

	}); // $(documnet).ready(function(){--------------------------------
	
</script>
<div id="contents">
	<div id="idFindContents">	
		<form name="idFindFrm">
	    	<div class="idSearchForm">
	 	 		
		 	 		<span style="margin-top:7%;margin-left:2%; text-align: center; font-size: 30px; font-weight: bold;">아이디 찾기<br><br></span>
					<div id="idfindEnd">
					회원님의 아이디는 <span style="color:navy; font-size: 23pt; font-weight: bold;">${userid}</span> 입니다.
					</div>
				<button type="button" id="idFindlogin" class="idSearchSubmit">로그인</button>
				
				<div><br><a href="<%= request.getContextPath()%>/login/pwdFind.cc">비밀번호 찾기</a></div>
			</div>
		</form>
		</div>
	<div>
</div>


<jsp:include page="../../WEB-INF/footer.jsp" />








<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
    
<link rel="stylesheet" href="<%= ctxPath%>/css/admin.css" /> 

<jsp:include page="../adminheader.jsp" /> 

<style>
	
	
	div#contents{
		width: 400px;
		margin-top: 50px;
		margin-left: 600px;
		border:solid 0px red;
	}
	
	button#adminLogin{
		margin-left: 170px;
	}
	
	img#loginimg{
		margin-left: 100px;
	} 

</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		// 로그인 버튼 클릭했을때
		$("button#adminLogin").click(function(){ 
			
			goLogin();
			
		});
		
		// 비밀번호 입력칸에서 엔터를 쳤을때
		$("input#adminPwd").keyup(function(event){
			
			if(event.keyCode==13){
				goLogin();
			}

		});
		
		
		
		
		
		// Function Declaration
		function goLogin(){
			
			var adminId = $("input#adminId").val().trim();
			var adminPwd = $("input#adminPwd").val().trim();
			
			if(adminId == ""){
				alert("아이디를 입력해주세요");
				$("input#adminId").val("");
		 		$("input#adminId").focus();
		 		return;
			}
			
			if(adminPwd == "" ){
		 		alert("암호를 입력해주세요");
		 		$("input#adminPwd").val("");
		 		$("input#adminPwd").focus();
		 		return; 
		 	}
			
			var frm = document.loginFrm;
			frm.action = "<%= ctxPath%>/admin/loginresult.cc";
			frm.method = "POST"
			frm.submit();
			
			
			
		}// end of function goLogin(){
		
		
		
		
	});// end of $(document).ready(function(){

</script>



<div id="contents"> 
	<div id="loginContents">
		<div class="loginView" > 
			<div id="loginlogo">
				<img id="loginimg" src="<%= ctxPath%>/images/homeMain/logo.png" alt="로고이미지" width="200" height="80" />
			</div>
			
		    <form method="post" name="loginFrm">
			    <h3 style="text-align: center;"></h3>
			    <div class="form-group">
					<input type="text" id="adminId" class="form-control" placeholder="adminId" name="adminId" maxlength="20">
					<br>
			    	<input type="password" id="adminPwd" class="form-control" placeholder="●●●●" name="adminPwd" maxlength="20">
				</div>
				<br>
					
			    <button type="button" id="adminLogin" class="loginSubmit">로그인</button>

			</form>
		</div>
	</div>
</div>

<jsp:include page="../footer.jsp" />
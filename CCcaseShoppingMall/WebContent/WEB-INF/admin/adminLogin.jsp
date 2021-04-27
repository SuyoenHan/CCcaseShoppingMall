<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
    
<link rel="stylesheet" href="<%= ctxPath%>/css/admin.css" /> 

<jsp:include page="../adminheader.jsp" /> 

<script type="text/javascript">

	$(document).ready(function(){
		
		// 로그인 버튼 클릭했을때
		$("button#adminLogin").click(function(){ 
			
			goLogin();
			
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
				<img src="<%= ctxPath%>/images/homeMain/logo.png" alt="로고이미지" width="250" height="100" />
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
	String ctxPath = request.getContextPath();
%>

<link rel="stylesheet" href="<%= ctxPath %>/css/login.css" /> 

<jsp:include page="../../WEB-INF/header.jsp" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">

	$(document).ready(function(){

		$("button#btnSubmit").click(function(){
			goLogin(); // 로그인 시도한다.
		});
		
		$("input#loginPwd").keyup(function(event){
			if(event.keyCode == 13) {  // 암호입력란에 엔터를 했을 경우 
				goLogin(); // 로그인 시도한다.
			}	
		});
		$("button#register").click(function(){
			location.href="<%= ctxPath %>/member/memberRegister.cc";
		});
		$("button#idFind").click(function(){
			location.href="<%= request.getContextPath()%>/login/idFind.cc";
		});
		$("button#pwdFind").click(function(){
			location.href="<%= request.getContextPath()%>/login/pwdFind.cc";
		});
	});// end of $(document).ready()--------------------------------------

	
	// === 로그인 처리 함수 === //
	function goLogin() {
		 //alert("로그인 시도함");
		 var loginUserid = $("input#loginUserid").val().trim();
		var loginPwd = $("input#loginPwd").val().trim();
		
		if(loginUserid == "") {
			alert("아이디를 입력하세요!!");
			$("input#loginUserid").val("");
			$("input#loginUserid").focus();
			return;  // goLogin() 함수 종료
		}
		
		if(loginPwd == "") {
			alert("암호를 입력하세요!!");
			$("input#loginPwd").val("");
			$("input#loginPwd").focus();
			return;  // goLogin() 함수 종료
		}
		
		var frm = document.loginFrm;
		frm.action = "<%= request.getContextPath()%>/login/login.cc";
	    frm.method = "post";
		frm.submit();
		
	}// end of function goLogin()-----------------------------------------
	

</script>
<div id="contents"> 
	<div id="loginContents">
		<div class="loginView"> 
			<div id="loginlogo">
				<img src="<%= ctxPath%>/images/homeMain/logo.png" alt="로고이미지" width="250" height="100" />
			</div>
		    <form name="loginFrm">
			    <h3 style="text-align: center;"></h3>
			    <div class="form-group">
					<input type="text" id="loginUserid" class="form-control" placeholder="Username" name="userid" maxlength="20">
					<br>
			    	<input type="password" id="loginPwd"  class="form-control" placeholder="●●●●" name="pwd" maxlength="20">
				</div>
				<br>
					
			    <button type="button" id="btnSubmit" class="loginSubmit">로그인</button>
			   
			    <hr style="border: solid 1px #f2f2f2;">
			  
				<button type="button" id="register" class="memberRegister">회원가입 </button>
				 
				<br>
				<div id="search">
					<button type="button" class="idSearch"id="idFind" >아이디찾기</button>
					<button type="button" class="pwdSearch" id="pwdFind">비밀번호 찾기</button>
				</div>
			</form>
		</div>
	</div>
</div>

<jsp:include page="../../WEB-INF/footer.jsp" />
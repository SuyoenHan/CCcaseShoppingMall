<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
	String ctxPath = request.getContextPath();
%>
    
<link rel="stylesheet" href="../../css/login.css" /> 

<jsp:include page="../../WEB-INF/header.jsp" />

<div id="contents"> 
	<div id="loginContents">
		<div class="loginView"> 
			<div id="loginlogo">
				<img src="<%= ctxPath%>/images/homeMain/logo.png" alt="로고이미지" width="250" height="100" />
			</div>
			
		    <form method="post">
			    <h3 style="text-align: center;"></h3>
			    <div class="form-group">
					<input type="text" class="form-control" placeholder="Username" name="userID" maxlength="20">
					<br>
			    	<input type="password" class="form-control" placeholder="●●●●" name="userPassword" maxlength="20">
				</div>
				<br>
					
			    <button type="submit" class="loginSubmit">로그인</button>
			   
			    <hr style="border: solid 1px #f2f2f2;">
			  
				<button type="button" class="memberRegister">회원가입 </button>
				 
				<br>
				<div id="search">
					<button type="button" class="idSearch">아이디찾기</button>
					<button type="button" class="pwdSearch">비밀번호 찾기</button>
				</div>
			</form>
		</div>
	</div>
</div>

<jsp:include page="../../WEB-INF/footer.jsp" />
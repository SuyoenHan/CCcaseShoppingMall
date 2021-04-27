<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>
    
<link rel="stylesheet" href="<%= ctxPath%>css/admin.css" /> 

<jsp:include page="../adminheader.jsp" /> 

<div id="contents"> 
	<div id="loginContents">
		<div class="loginView" > 
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
					
			    <button type="button" id="adminlogin" class="loginSubmit">로그인</button>

			</form>
		</div>
	</div>
</div>

<jsp:include page="../footer.jsp" />
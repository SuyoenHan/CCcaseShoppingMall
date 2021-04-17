<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="../css/login.css" /> 

<jsp:include page="../header.jsp" />

<div id="loginContents">

	   <form method="post" action="idfind.jsp">
	
	    
		
	    <div class="idSarchForm">
	 	 <ul>
	 	 <span style="text-align: center; font-size: 30px; font-weight: bold;">아이디 찾기</span>
			<br><br>
			<li>	
				
				<label class="title">이름</label>
				<input type="text" class="findinput" placeholder="이름을 입력해주세요" name="userName" maxlength="20">
			</li>
			
			<li>
				<label class="title">이메일</label>
				  <input type="email" class="findinput" placeholder="가입하신 이메일을 입력해주세요" name="useremail" maxlength="20">
			</li>
		

	   <button type="submit" class="idSearchSubmit">확인</button>
	 
			</ul>
			<a href="pwdSearch.jsp">비밀번호 찾기</a>
			</form>
		 
	</div>
</div>




<jsp:include page="../footer.jsp" />
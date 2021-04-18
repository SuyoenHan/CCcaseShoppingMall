<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="../../css/login.css" /> 

<jsp:include page="../header.jsp" />

<div id="contents">
	<div id="loginContents">
	
		<form method="post">
	 		<div class="idSearchForm">
				<ul>
					<li style="text-align: center; font-size: 30px; font-weight: bold;">&nbsp;&nbsp;&nbsp;&nbsp;비밀번호 찾기<br><br></li>
					<li>	
						<label class="title">아이디</label>
						<input type="text" class="findinput" placeholder="아이디를 입력해주세요" name="userID" maxlength="20">
					</li>
					<li>	
						<label class="title">이름</label>
						<input type="text" class="findinput" placeholder="이름을 입력해주세요" name="userName" maxlength="20">
					</li>
					<li>
						<label class="title">이메일</label>
					  	<input type="email" class="findinput" placeholder="가입하신 이메일을 입력해주세요" name="useremail" maxlength="20">
					</li>
				</ul>
		  		<button type="submit" class="idSearchSubmit">확인</button>
	  		</div>
		</form>
				
	</div>
</div>

<jsp:include page="../footer.jsp" />
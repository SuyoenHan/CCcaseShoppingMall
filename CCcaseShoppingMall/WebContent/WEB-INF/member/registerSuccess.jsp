<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath= request.getContextPath();
%>       
    
<link rel="stylesheet" href="<%= ctxPath%>/css/register.css" />
   
<jsp:include page="../../WEB-INF/header.jsp" />

<script type="text/javascript">

	function() {
		var frm = document.loginFrm; 
		frm.action = "<%= ctxPath%>/login/login.cc";
		frm.method = "post";
		frm.submit();
		
	}// end of window.onload = function() {}----------------------

</script>--
<div id="contents"> 
	<div id="registerSuccessContainer"> 
		<div>   
			<img src="<%= ctxPath%>/images/member/check.png" alt="체크이미지" width="50" height="50"/>
		</div>
		<div>
			<span style="font-weight: bold; font-size: 17pt;">회원 가입을 축하드립니다!</span>
		</div>
		<div style="background-color: #f2f2f2; height: 190px;">
			<table id="registerSuccessTable">
				<tr>
					<td colspan="3"><br>저희 쇼핑몰을 이용해주셔서 감사합니다.<br><br></td>
				</tr>
				<tr>
					<td rowspan="3" id="tdImg">
						<img src="<%= ctxPath%>/images/member/profile.png" alt="프로필이미지" width="70" height="70" />
					</td>
					<td class="column">아이디</td>
					<td>${userid}</td>
				</tr>
				<tr>
					<td class="column">이름</td>
					<td>${name}</td>
				</tr>
				<tr>
					<td class="column">이메일</td>
					<td>${email}</td>
				</tr>
			</table>
		</div>
		<div>
			<button type="button"  onclick="location.href='/home.cc' >홈으로</button>
				<form name="loginFrm">
		<input type="hidden" name="userid" value="${requestScope.userid}" />
		<input type="hidden" name="pwd"    value="${requestScope.pwd}" />
	</form>
		</div>
	</div>
</div>
<jsp:include page="../../WEB-INF/footer.jsp" />
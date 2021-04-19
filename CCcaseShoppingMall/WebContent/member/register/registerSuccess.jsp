<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath= request.getContextPath();
%>       
    
<link rel="stylesheet" href="../../css/register.css" />
   
<jsp:include page="../../header.jsp" />

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
					<td>hongkd</td>
				</tr>
				<tr>
					<td class="column">이름</td>
					<td>홍길동</td>
				</tr>
				<tr>
					<td class="column">이메일</td>
					<td>hongkd@gmail.com</td>
				</tr>
			</table>
		</div>
		<div>
			<button type="button">홈으로</button>
		</div>
	</div>
</div>

<jsp:include page="../../footer.jsp" />
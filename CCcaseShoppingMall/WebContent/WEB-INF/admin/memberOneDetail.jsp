<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%String ctxPath = request.getContextPath();%>

<jsp:include page="../adminheader.jsp" />

<style type="text/css">

</style>


<script type="text/javascript">
		
		var goBackURL = "";
		
		$(document).ready(function(){
			
			$("div#smsResult").hide();
			
			$("button#btnSend").click(function(){
			     var reservedate = $("input#reservedate").val();
		         reservedate = reservedate.split("-").join("");
		         
		         var reservetime = $("input#reservetime").val();
		         reservetime = reservetime.split(":").join("");
		         
		         var datetime = reservedate+reservetime;
		         
		         var dataObj;
		         
		         if(reservedate == "" || reservetime == "" ) {
			            dataObj = {"mobile":"${requestScope.mvo.mobile}",
			                       "smsContent": $("textarea#smsContent").val()};
			         }
			     else {
			            dataObj = {"mobile":"${requestScope.mvo.mobile}",
			                       "smsContent": $("textarea#smsContent").val(),
			                       "datetime":datetime};
			         }
		         
		         $.ajax({
						url:"<%= ctxPath%>/admin/smsSend.up",
						type:"POST",
						data:dataObj,
						dataType:"json",
						success:function(json){
							if(json.success_count == 1) {
								$("div#smsResult").html("문자전송이 성공되었습니다");
							}
							
							else if(json.error_count == 1) {
								$("div#smsResult").html("문자전송이 실패되었습니다.");
							}
							
							$("div#smsResult").show();
							$("textarea#smsContent").val("");
						},
						error: function(request, status, error){
				               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				        }
		         });		
		
			});      
		       
				goBackURL = "${requestScope.goBackURL}"
		 		goBackURL = goBackURL.replace(/ /gi, "&");
	});
			
		function goMemberList() {
			location.href="<%= ctxPath%>/"+goBackURL;
		}
			
			
</script>

<c:if test="${empty requestScope.mvo}">
	존재하지 않는 회원입니다.<br>
</c:if>

<c:if test="${not empty requestScope.mvo}">
	<h3>${requestScope.mvo.name}님의 상세정보</h3>
	<c:set var="mobile" value="${requestScope.mvo.mobile }"/>
	
	<div id="mvoInfo">
		<ol>
			<li><span class="myli">아이디 : </span>${mvo.userid}</li>
			<li><span class="myli">회원명 : </span>${mvo.name}</li>
			<li><span class="myli">이메일 : </span>${mvo.email}</li>
			<li><span class="myli">휴대폰 : </span>${fn:substring(mobile,0,3)}-${fn:substring(mobile,3,7)}-${fn:substring(mobile,7,11)}</li>
			<li><span class="myli">우편번호 : </span>${mvo.postcode}</li>
			<li><span class="myli">주소 : </span>${mvo.address}&nbsp;${mvo.detailaddress}&nbsp;${mvo.extraaddress}</li>
			<li><span class="myli">총포인트 : </span>${mvo.totalpoint + '점'}</li>
			<li><span class="myli">가입일자 : </span>${mvo.registerday}</li>
			<li><span class="myli">탈퇴유무 : </span>
					<c:choose>
						<c:when test="${mvo.status eq '1'}">
							사용가능(가입중)
						</c:when>
						<c:otherwise>
							사용불능(탈퇴)
						</c:otherwise>
					</c:choose>	
				</li>
			<li><span class="myli">휴면유무 : </span>
					<c:choose>
						<c:when test="${mvo.idle eq '0'}">
							활동계정
						</c:when>
						<c:otherwise>
							휴면계정
						</c:otherwise>
					</c:choose>	
			</li>
			<li><span class="myli">등급 : </span>
					<c:choose>
						<c:when test="${mvo.fk_grade eq '0'}">
							BROWN
						</c:when>
						<c:when test="${mvo.fk_grade eq '1'}">
							SILVER
						</c:when>
						<c:otherwise>
							GOLD
						</c:otherwise>
					</c:choose>	
			</li>
		</ol>
	</div>

	<%-- ==== 휴대폰 SMS(문자) 보내기 ==== --%>
   <div id="sms" align="left">
        <span id="smsTitle">&gt;&gt;휴대폰 SMS(문자) 보내기 내용 입력란&lt;&lt;</span>
        <div style="margin: 10px 0 20px 0">
           발송예약일&nbsp;<input type="date" id="reservedate" />&nbsp;<input type="time" id="reservetime" />
        </div>
        <textarea rows="4" cols="40" id="smsContent"></textarea>
        <button id="btnSend">전송</button>
        <div id="smsResult"></div>
   </div>
	
</c:if>

	<div>
		<button style="margin-top: 50px;" type="button" onclick="goMemberList()">회원목록</button>
	   	&nbsp;&nbsp;
	</div>

<jsp:include page="../footer.jsp" />
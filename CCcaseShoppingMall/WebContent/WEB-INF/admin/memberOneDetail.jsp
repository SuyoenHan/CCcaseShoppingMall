<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%String ctxPath = request.getContextPath();%>

<jsp:include page="../adminheader.jsp" />



<style type="text/css">
	
	h4#infoIntro {
		font-weight: bold;
		text-align: center;
	}	
	
	span.myli {
		cursor: default;
		display: inline-block;
		width: 80px;
	}

	li {
		list-style:  none;
		line-height: 30px;
	}
	
	div#mvoInfo {
		padding: 20px 0px 30px 500px;
	}
	
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

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
								$("div#smsResult").html("??????????????? ?????????????????????");
							}
							
							else if(json.error_count == 1) {
								$("div#smsResult").html("??????????????? ?????????????????????.");
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
	???????????? ?????? ???????????????.<br>
</c:if>

<c:if test="${not empty requestScope.mvo}">
	<h4 id="infoIntro">${requestScope.mvo.name}?????? ????????????</h4>
	<c:set var="mobile" value="${requestScope.mvo.mobile }"/>
	
	<div id="mvoInfo">
		<ol>
			<li><span class="myli">????????? : </span>&nbsp;${mvo.userid}</li> 
			<li><span class="myli">????????? : </span>&nbsp;${mvo.name}</li>
			<li><span class="myli">????????? : </span>&nbsp;${mvo.email}</li>
			<li><span class="myli">????????? : </span>&nbsp;${fn:substring(mobile,0,3)}-${fn:substring(mobile,3,7)}-${fn:substring(mobile,7,11)}</li>
			<li><span class="myli">???????????? : </span>&nbsp;${mvo.postcode}</li>
			<li><span class="myli">?????? : </span>&nbsp;${mvo.address}&nbsp;${mvo.detailaddress}&nbsp;${mvo.extraaddress}</li>
			<li><span class="myli">???????????? : </span>&nbsp;${mvo.totalpoint}???</li>
			<li><span class="myli">???????????? : </span>&nbsp;${mvo.registerday}</li>
			<li><span class="myli">???????????? : </span>
					<c:choose>
						<c:when test="${mvo.status eq '1'}">????????????(?????????)</c:when>
						<c:otherwise>????????????(??????)</c:otherwise>
					</c:choose>	
				</li>
			<li><span class="myli">???????????? : </span>
					<c:choose>
						<c:when test="${mvo.idle eq '0'}">????????????</c:when>
						<c:otherwise>????????????</c:otherwise>
					</c:choose>	
			</li>
			<li><span class="myli">?????? : </span>
					<c:choose>
						<c:when test="${mvo.fk_grade eq '0'}">BROWN</c:when>
						<c:when test="${mvo.fk_grade eq '1'}">SILVER</c:when>
						<c:otherwise>GOLD</c:otherwise>
					</c:choose>	
			</li>
		</ol>
	</div>

	<%-- ==== ????????? SMS(??????) ????????? ==== --%>
   <div id="sms" align="center">
        <span id="smsTitle">&gt;&gt;????????? SMS(??????) ????????? ?????? ?????????&lt;&lt;</span>
        <div style="margin: 10px 0 20px 0">
           ???????????????&nbsp;<input type="date" id="reservedate" />&nbsp;<input type="time" id="reservetime" />
        </div>
        <textarea rows="4" cols="40" id="smsContent"></textarea><br>
        <button id="btnSend" class="btn btn-info" >??????</button>
        <div id="smsResult"></div>
   </div>
	
</c:if>

	<div id="btnMbrList" align="right">
		<button class="btn btn-primary" style="margin-top: 50px; margin-bottom: 20px;" type="button" onclick="goMemberList()">????????????</button>
	</div>
	
<jsp:include page="../footer.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<jsp:include page="../../WEB-INF/header.jsp" />
<jsp:include page="../../WEB-INF/leftSide.jsp" />

<style type="text/css">
	div#mypage{
		margin:120px 0px 0px 200px;
		background-color: #E0E0E0;
		font-size:20pt;
   		height:80px;
		/* border: solid 1px blue; */
	}
	div#myprofile{
		margin:0px 0px 10px 200px;
		/* border: solid 1px red; */
		padding-left: 100px;
		
	}
	span#grade{
		display: inline-block;
	 	background-color:#5E5E5E;
	  	width: 80px;
	   	height:30px;
	    font-size:15pt;
	    text-align: center; 
	    border-radius: 5px; 
	    margin:20px;
	}
	div#myprofileInfo{
	
	 font-size:15pt;
	}


</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	function memberEdit(userid) {

		// 로그아웃을 처리해주는 페이지로 이동
		location.href="<%= request.getContextPath()%>/member/memberEdit.cc?userid="+userid;
		
	}

</script>


<div id="mypage">
		<span id=grade>
		<c:choose><c:when test="${sessionScope.loginuser.fk_grade eq 0}">브라운</c:when>
		<c:when test="${sessionScope.loginuser.fk_grade eq 1}">실버</c:when>
		<c:otherwise>골드</c:otherwise>
		</c:choose></span>${sessionScope.loginuser.name} 님의 마이페이지
	</div>
	<div id="myprofile">
		<h2>내 프로필</h2>
		<div id="myprofileInfo">
	 			<div>
	           	아이디 : ${sessionScope.loginuser.userid}
	            </div>
	            
	            <div>
	       		이메일 : ${sessionScope.loginuser.email}
	    		 </div>
	    		 <br>
	    		<span style="font-size:13pt;cursor: pointer;"><img id="memberEdit" src="../images/member/link.png" style="vertical-align: middle;" onclick="memberEdit('${(sessionScope.loginuser).userid}');"/> 내 정보수정</span>
	     </div>
	</div>


<jsp:include page="../../WEB-INF/footer.jsp" />
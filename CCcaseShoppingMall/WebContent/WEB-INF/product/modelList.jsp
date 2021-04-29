<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath= request.getContextPath();
%>

<style type="text/css">

	div.comMenu{
		border: solid 1px blue;
		float: left;
		width: 300px;
	}

	ul.modelList{
		border: solid 1px red;
	}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		func_height();
		
		
		
		
		
		
	}); // end of $(document).ready(function(){----------------------


</script>

<jsp:include page="../header.jsp" />
<jsp:include page="../leftSide.jsp" />


<div id="contents" style="margin-left:60px;">
	
	<div id="cname">${cname}</div>
	
	<div class="comMenu" id="modelSam">
		<label>삼성</label>
		<ul class="modelList">
		<c:forEach var="modelSam" items="${modelSam}">
			<li>${modelSam}</li>
		</c:forEach>
		</ul>
	</div>
	
	<div class="comMenu" id="modelApp">
		<label>애플</label>
		<ul class="modelList">
		<c:forEach var="modelApp" items="${modelApp}">
			<li>${modelApp}</li>
		</c:forEach>
		</ul>
	</div>
	
	<div class="comMenu" id="modelLg">
		<label>엘지</label>
		<ul class="modelList">
		<c:forEach var="modelLg" items="${modelLg}">
			<li>${modelLg}</li>
		</c:forEach>
		</ul>
	</div>
	<div>
		
	</div>
</div> 


















<jsp:include page="../footer.jsp" />
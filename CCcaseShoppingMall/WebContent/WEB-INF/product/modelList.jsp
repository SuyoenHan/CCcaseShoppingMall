<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath= request.getContextPath();
%>

<style type="text/css">

	div.comMenu{
		border-right: solid 2px #caceca;
		float: left;
		width: 300px;
		margin-top: 40px;
		height: 250px;
		margin-left: 50px;
	}

	div.menuModel{
		margin-left:50px;
	}
	
	div#cname{
		background-color: #94b0b8;
		color: #fff;
		margin-top:50px;
		font-size: 20pt;
		font-weight: bold;
		width: 220px;
		border-radius: 5%;
		text-align: center;
		height: 60px;
		padding-top: 15px;
	}
	
	div#ImgBox{
		clear: both;
		border: solid 0px red; 
		padding-top: 50px;
		padding-left: 50px;
	}
	
	div.cp {
		background-color: #f0f4f5;
		border-radius: 10%;
		width: 230px;
		height: 40px;
		text-align: center;
		padding-top: 7px;
		font-weight: bold;
	}
	
	table.modeltable{
		margin-top: 20px;
		width:230px;
	}
	
	table.modeltable tr{
		height: 40px;
	}
	
	table.modeltable tr:hover{
		background-color: #e1e8ea;
		font-weight: bold;
		cursor: pointer;
		font-weight: bold;
	}
	
	td.modelTr{
		width: 170px;
	}
	
	table.modeltable a:visited{
		text-decoration: none;
		color: #3e423f;
	}
	
	table.modeltable a:link{
		text-decoration: none;
		color: #3e423f;
	}

	table.modeltable a:hover{
		text-decoration: none;
	}
	
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		func_height();
		
		$("button.case").each(function(index,item){
			
			if($(item).val()== "${cnum}"){
				$(item).css('background-color','#a6aba7');	
			}	
		}); // end of $("button.case").each(function(){----------
		
		
		if("${cnum}"=="2"){
			$("div#ImgBox").html('<img src="<%=ctxPath%>/images/homeMain/homeMain4.png" id="menuClickImg" width="950px" height="300px;" />')
		}
			
		if("${cnum}"=="3"){
			$("div#ImgBox").html('<img src="<%=ctxPath%>/images/homeMain/homeMain.jpg" id="menuClickImg" width="950px" height="300px;" />')
		}	
		
		
	}); // end of $(document).ready(function(){----------------------


</script>

<jsp:include page="../header.jsp" />


<div id="contents" style="background-color: #fff; border: solid 2px #e1e1db; margin: 0px 0px 80px 250px;">
	
	<div class="menuModel" id="cname">${cname}</div>
	
	<div class="comMenu menuModel" id="modelSam">
		<div class="cp" style="font-size:13pt;">삼&nbsp;&nbsp;&nbsp;성</div>
		<table class="modeltable">
			<c:forEach var="cntSam" items="${cntSamList}">
				<tr>
					<td class="modelTr">
						<a href="<%=ctxPath%>/product/productList.cc?mnum=1000&cnum=${cnum}&modelName=${cntSam.modelName}">&nbsp;&nbsp;${cntSam.modelName}</a>
					</td>
					<td>(${cntSam.cnt})</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="2" class=>
					<a href="<%=ctxPath%>/product/productList.cc?mnum=1000&cnum=${cnum}">&nbsp;&nbsp;전체보기</a>
				</td>
			</tr>
		</table>		
	</div>
	
	<div class="comMenu" id="modelSam">
		<div class="cp" style="font-size:13pt;">애&nbsp;&nbsp;&nbsp;플</div>
		<table class="modeltable">
			<c:forEach var="cntApp" items="${cntAppList}">
				<tr>
					<td class="modelTr">
						<a href="<%=ctxPath%>/product/productList.cc?mnum=2000&cnum=${cnum}&modelName=${cntApp.modelName}">&nbsp;&nbsp;${cntApp.modelName}</a>
					</td>
					<td>(${cntApp.cnt})</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="2">
					<a href="<%=ctxPath%>/product/productList.cc?mnum=2000&cnum=${cnum}">&nbsp;&nbsp;전체보기</a>
				</td>
			</tr>
		</table>		
	</div>

	
	<div class="comMenu" id="modelSam" style="border:none;">
		<div class="cp" style="font-size:13pt;">엘&nbsp;&nbsp;&nbsp;지</div>
		<table class="modeltable">
			<c:forEach var="cntLg" items="${cntLgList}">
				<tr>
					<td class="modelTr">
						<a href="<%=ctxPath%>/product/productList.cc?mnum=3000&cnum=${cnum}&modelName=${cntLg.modelName}">&nbsp;&nbsp;${cntLg.modelName}</a>
					</td>
					<td>(${cntLg.cnt})</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="2">
					<a href="<%=ctxPath%>/product/productList.cc?mnum=3000&cnum=${cnum}">&nbsp;&nbsp;전체보기</a>
				</td>
			</tr>
		</table>		
	</div>
	
	<div id="ImgBox" style="margin-bottom: 50px;">
		<img src="<%=ctxPath%>/images/homeMain/homeMain3.jpg" id="menuClickImg" width="950px" height="300px;" />
	</div>
</div> 


<jsp:include page="../footer.jsp" />
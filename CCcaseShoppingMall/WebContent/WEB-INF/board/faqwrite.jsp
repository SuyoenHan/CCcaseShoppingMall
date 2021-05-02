<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String ctxPath = request.getContextPath();
%>
    
<link rel="stylesheet" href="<%=ctxPath%>/css/admin.css" />
<jsp:include page="../adminheader.jsp" />
<jsp:include page="../leftSide.jsp" />


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style>

	textarea {
	 	 width:100%;
	 	 height:400px;
	 	 background-color: #e6e6e6;
	 	 overflow: visible;
	 	 border: none;
	 	 
	 	/*  display: none;  */
	 }

	div#contents ,table{
		color: #333;
		width:80%;
		margin-left:20px;
		border-left: none;
		
	}

	
	 td {
		border-bottom:solid 1px gray;
		border-top:solid 1px gray;
		border-collapse: collapse;
		line-height: 30px;
		
	}
	
	button.button{
	 width:80px;
	 height:50px;
	 margin:20px 0px 10px 20px;
	}
	
	.error{
	color:red;
	display: none; 
	}
	
	input#fcontent{
	width:100%;
	line-height:300px;
	background-color: #e6e6e6;
	/* border: none; */
	}
	
</style>


<script type="text/javascript">


	$(document).ready(function(){
		func_height();//footer.jsp에 있음!
		
		
		
		//1. 목록버튼 클릭  => faqList 메인목록으로 돌아간다.
		$("button.faqList").click(function(){
			//alert("목록클릭!");
			location.href="<%=ctxPath%>/board/faqList.cc";
			
		});
		
		//2. 등록버튼을 눌렀을때 
		$("button.faqInsert").click(function(){
			
			//==글제목과 글내용 있는지  검사한다 ==
			var bFlagRequiredInfo = false;
			
			$(".requiredInfo").each(function(index, item){
				var data = $(item).val().trim();
				if(data == "") {
					bFlagRequiredInfo = true;
					alert("제목과 글내용은 필수입력사항 입니다.");
					$("input#ftitle").focus();
					return false; // break 라는 뜻이다.
				}
				
			});
			//==유효성 검사 끝 ==
			
			
			// 글제목 글내용 있을경우 FaqList에 POST방식으로 등록해준다.
			if(!bFlagRequiredInfo) { 
				var frm = document.faqwrite;
				frm.action = "<%= ctxPath%>/board/faqwrite.cc";
				frm.method = "POST";
				frm.submit();
			}
			
		});//end of $("button.faqInsert").click(function(){})-------------------
		
	
		//3. 취소버튼 클릭  => alert창 faqList 메인목록으로 돌아간다.
		$("button.faqCancel").click(function(){
			alert("FAQ 작성을 취소하셨습니다.");
			location.href="<%=ctxPath%>/board/faqList.cc";
			
		});
		
		
		
		
	}); //end of $(document).ready(function(){})-------------------------

</script>


<div id="contents">



<h2 style="margin-left:20px;"> FAQ 글 작성하기 </h2>
	<form name ="faqwrite">
	<table>
		<tr>
			<td>제목</td>
			<td>
				<input type="text" id="ftitle" class="requiredInfo" name="ftitle" />
				
			</td>
		</tr>
		
		<tr>
			<td>작성자(default)</td>
			<td><input type="text" id="adminid" name="adminid" value="${avo.adminid}" readonly="readonly" /></td>
		</tr>
		
		<tr>
			<td>등록일(default)</td>
			<td><input type="text" id="fregisterdate" name="fregisterdate" value="" /></td>
		</tr>
		
		<tr>
			<td colspan="2" id="text">
				<label for="story">글쓰기</label>
				<textarea id="fcontent" name="fcontent" class="requiredInfo" >
				
				</textarea>
				
		     </td>
		</tr>
	</table>
	
	<button type="button" class="button faqList" name="faqList" style="align:left;">목록</button>
	<button type="button" class="button faqInsert" name="faqInsert" style="align:right;">등록</button>
	<button type="button" class="button faqCancel" name="faqCancel" style="align:right; ">취소</button>
</form>

</div>





<jsp:include page="../footer.jsp" />    
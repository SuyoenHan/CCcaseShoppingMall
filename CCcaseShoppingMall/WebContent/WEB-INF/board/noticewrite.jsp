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
	 	 background-color: #ecf2f9;
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

	
	 td.td {
		border-bottom:solid 1px gray;
		border-top:solid 1px gray;
		border-collapse: collapse;
		line-height: 30px;
		
	}
	
	button.button{
		 width:80px;
		 height:40px;
		 margin-left: 35px ;
		 margin-top: 30px;
		 border:solid 1px #98B7C1;
	     background-color: #98B7C1;
	}
	
	.button:hover{
		background-color: #98B7C1;
		color: white;
    	
	}
	
	.error{
	color:red;
	display: none; 
	}
	
	input#ncontent{
	width:100%;
	line-height:300px;
	background-color: #e6e6e6;
	/* border: none; */
	}
	
</style>


<script type="text/javascript">


	$(document).ready(function(){
		func_height();//footer.jsp에 있음!
		
		
		
		//1. 목록버튼 클릭  => noticeList 메인목록으로 돌아간다.
		$("button.noticeList").click(function(){
			//alert("목록클릭!");
			location.href="<%=ctxPath%>/board/noticeList.cc";
			
		});
		
		//2. 등록버튼을 눌렀을때 
		$("button.noticeInsert").click(function(){
			
			//==글제목과 글내용 있는지  검사한다 ==
			var bFlagRequiredInfo = false;
			
			$(".requiredInfo").each(function(index, item){
				var data = $(item).val().trim();
				if(data == "") {
					bFlagRequiredInfo = true;
					alert("제목과 글내용은 필수입력사항 입니다.");
					$("input#ntitle").focus();
					return false; // break 라는 뜻이다.
				}
				
			});
			//==유효성 검사 끝 ==
			
			
			// 글제목 글내용 있을경우noticeList에 POST방식으로 등록해준다.
			if(!bFlagRequiredInfo) { 
				var frm = document.noticewrite;
				frm.action = "<%= ctxPath%>/board/noticewrite.cc";
				frm.method = "POST";
				frm.submit();
			}
			
		});//end of $("button.noticeInsert").click(function(){})-------------------
		
	
		//3. 취소버튼 클릭  => alert창 faqList 메인목록으로 돌아간다.
		$("button.noticeCancel").click(function(){
			alert("공지사항 작성을 취소하셨습니다.");
			location.href="<%=ctxPath%>/board/noticeList.cc";
			
		});
		
		
	}); //end of $(document).ready(function(){})-------------------------

</script>


<div id="contents">



<h2 style="margin-left:20px;"> 공지사항 글 작성하기 </h2>
	<form name ="noticewrite">
	<table>
		<tr>
			<td>제목</td>
			<td>
				<input type="text" id="ntitle" class="requiredInfo" name="ntitle" />
				
			</td>
		</tr>
		
		<tr>
			<td>작성자(default)</td>
			<td><input type="text" id="adminid" name="adminid" value="${avo.adminid}" readonly="readonly" /></td>
		</tr>
		
		<tr>
			<td>등록일(default)</td>
			<td><input type="text" id="nregisterdate" name="nregisterdate" value="현재날짜자동입력" readonly="readonly"/></td>
		</tr>
		
		<tr>
			<td colspan="2" id="text">
				<label for="story">글쓰기</label>
				<textarea id="ncontent" name="ncontent" class="requiredInfo" >
				
				</textarea>
				
		     </td>
		</tr>
	</table>
	
	<button type="button" class="button noticeList" name="noticeList" style="align:left;">목록</button>
	<button type="button" class="button noticeInsert" name="noticeInsert" style="align:right;">등록</button>
	<button type="button" class="button noticeCancel" name="noticeCancel" style="align:right; ">취소</button>
</form>

</div>





<jsp:include page="../footer.jsp" />    
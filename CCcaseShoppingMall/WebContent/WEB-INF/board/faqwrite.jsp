<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String ctxPath = request.getContextPath();
%>
    
<link rel="stylesheet" href="<%=ctxPath%>/css/style.css" />
<jsp:include page="../header.jsp" />
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
		
		
		
		$("button.faqInsert").click(function(){
			//등록 버튼을 눌렀을때
			
			//글제목과 글내용 있는지 유효성 검사해줌.
			var bFlagRequiredInfo = false;
			
			$(".requiredInfo").each(function(index, item){
				var data = $(item).val().trim();
				if(data == "") {
					bFlagRequiredInfo = true;
					alert("제목과 글내용을 입력하셔야 합니다.");
					return false; // break 라는 뜻이다.
				}
			});
			
			
			if(!bFlagRequiredInfo) { // 글제목 글내용 있을경우 List에 등록해준다.
				var frm = document.faqwrite;
				frm.action = "<%= ctxPath%>/board/faqList.cc";
				frm.method = "post";
				frm.submit();
			}
			
		});//end of $("button.faqInsert").click(function(){})-------------------
		
<<<<<<< HEAD

=======
<<<<<<< HEAD
>>>>>>> branch 'main' of https://github.com/SuyoenHan/CCcaseShoppingMall.git
		
		
		
	}); //end of $(document).ready(function(){})-------------------------
<<<<<<< HEAD


=======

=======
	});

>>>>>>> refs/heads/main
>>>>>>> branch 'main' of https://github.com/SuyoenHan/CCcaseShoppingMall.git
</script>


<div id="contents">



<h2 style="margin-left:20px;"> FAQ 글 작성하기 </h2>
	<form name ="faqwrite">
	<table>
		<tr>
			<td>제목</td>
			<td>
				<input type="text" id="ftitle" class="requiredInfo" name="ftitle" />
				<span class="error">제목은 필수입력 사항입니다.</span>
			</td>
		</tr>
		
		<tr>
			<td>작성자(default)</td>
			<c:set var="adminid" value="${sessionScope.adminUser.userId}" />
			<td><input type="text" id="adminid" name="adminid" value="${adminid}"/></td>
		</tr>
		
		<tr>
			<td>등록일(default)</td>
			<td><input type="text" id="fregisterdate" name="fregisterdate" /></td>
		</tr>
		
		<tr>
			<td colspan="2" id="text">
				<label for="story">글쓰기</label>
				<textarea id="fcontent" name="fcontent" class="requiredInfo" rows="10" cols="10">
				
				</textarea>
				
		     </td>
		</tr>
	</table>
	</form>
	<button type="button" class="button faqList" name="faqList" style="align:left;">목록</button>
	<button type="button" class="button faqInsert" name="faqInsert" style="align:right;">등록</button>
	<button type="button" class="button faqCancel" name="faqCancel" style="align:right;">취소</button>


</div>





<jsp:include page="../footer.jsp" />    
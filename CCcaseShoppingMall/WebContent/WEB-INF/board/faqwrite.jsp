<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>
    
<link rel="stylesheet" href="<%=ctxPath%>/css/style.css" />
<jsp:include page="../header.jsp" />
<jsp:include page="../leftSide.jsp" />


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style>

tr.faqDetail {
	 	 overflow: visible;
	 	 border:solid 1px red;
	 	/*  display: none;  */
	 }

	div#contents ,table{
		color: #333;
		width:80%;
		
	}

	
	table , tr ,td{
		border:solid 1px gray;
		border-collapse: none;
	}
	
	button.button{
	 width:80px;
	 height:50px;
	}
	
	
	
	.error{
	color:red;
	display: none; 
	}
	
	input#faqtext{
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
			
			var bFlagRequiredInfo = false;
			
			$(".requiredInfo").each(function(index, item){
				var data = $(item).val().trim();
				if(data == "") {
					bFlagRequiredInfo = true;
					alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
					return false; // break 라는 뜻이다.
				}
			});
			
			if(!b_flagIdDuplicateClick){
				//가입하기 버튼을 클릭시 "아이디중복확인" 을 클릭하지 않았을 경우.
				alert("아이디중복확인을 클릭하여 아이디 중복검사를 하세요!!");
				return; //종료 submit되어지면 안되니까.
			}
			else{
				//가입하기 버튼을 클릭시 "아이디중복확인" 을 클릭했을 경우.
			}
			
			
			if(!bFlagRequiredInfo) {
				var frm = document.registerFrm;
				frm.action = "memberRegister.up";
				frm.method = "post";
				frm.submit();
			}
			var frm = document.registerFrm;
			frm.action = "memberRegister.up";
			frm.method = "post";
			frm.submit();
			
			
		});
		
	});

</script>


<div id="contents">
<h2> FAQ 글 작성하기 </h2>
	<table>
		<tr>
			<td>제목</td>
			<td>
				<input type="text" id="faqboardName" class="requiredInfo" name="faqboardName" />
				<span class="error">제목은 필수입력 사항입니다.</span>
			</td>
		<tr>
		<tr>
			<td>작성자(default)</td>
			<td ><input type="text" id="faqwriter" name="faqwriter" /></td>
		<tr>
		<tr>
			<td>등록일(default)</td>
			<td><input type="text" id="faqwriteday" name="faqwriteday" /></td>
		<tr>
		<tr>
			<td colspan="2" id="text">
				<span>글내용</span>
				<div id="faqtext">
					<input type="text" id="faqtext"name="faqtext" class="requiredInfo" />
				</div>
				<span class="error">글내용은 필수입력 사항입니다.</span>
		     </td>
		<tr>
	</table>
	
	<button type="button" class="button faqList" name="faqList" style="align:left;">목록</button>
	<button type="button" class="button faqInsert" name="faqInsert" style="align:right;">등록</button>
	<button type="button" class="button faqCancel" name="faqCancel" style="align:right;">취소</button>


</div>





<jsp:include page="../footer.jsp" />    
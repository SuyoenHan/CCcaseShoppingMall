<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    

<% String ctxPath = request.getContextPath(); %>
 
<!DOCTYPE html>
<html>
<head>
<title>:::FAQ글수정:::</title>
<meta charset="utf-8">


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
		width:90%;
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
		
		
		$("button.faqEditEnd").click(function(){
			
			
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
					alert("수정완료");
					var frm = document.faqEdit;
					frm.action = "<%= ctxPath%>/board/faqEdit.cc?faqno="+${fvo.faqno};
					frm.method = "POST";
					frm.submit();
				}
				
			});
		
		
		
		
		//3. 취소버튼 클릭  => alert창 faqList 메인목록으로 돌아간다.
		$("button.faqCancel").click(function(){
			alert("FAQ 글 수정이 취소되었습니다.");
			window.close();
			return;
		});
		
		
	});	//end of $(document).ready(function(){---------------------




</script>




</head>

<body>

<div id="contents">



<h2 style="margin-left:20px;"> FAQ 글 수정하기 </h2>
	<form name ="faqEdit">
	<table>
		<tr>
			<td>제목</td>
			<td>
				<input type="text" id="ftitle" class="requiredInfo" name="ftitle" value="${fvo.ftitle}"/>
				
			</td>
		</tr>
		
		<tr>
			<td>작성자(default)</td>
			<td><input type="text" id="adminid" name="adminid" value="${avo.adminid}" readonly="readonly" /></td>
		</tr>
		
		<tr>
			<td>수정일(default)</td>
			<td><input type="text" id="fupdatedate" name="fupdatedate" value="현재날짜자동입력" readonly="readonly"/></td>
		</tr>
		
		<tr>
			<td colspan="2" id="text">
				<label for="story">글쓰기</label>
				<textarea id="fcontent" name="fcontent" class="requiredInfo"  >
				 ${fvo.fcontent}
				</textarea>
				
		     </td>
		</tr>
	</table>
	
	<button type="button" class="button faqEditEnd" name="faqInsert" style="align:right;">수정</button>
	<button type="button" class="button faqCancel" name="faqCancel" style="align:right; ">취소</button>
</form>

</div>


</body>
</html> 





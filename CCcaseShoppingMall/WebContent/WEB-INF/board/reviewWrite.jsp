<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />
<jsp:include page="../communityLeftSide.jsp"/>


<style type="text/css">

	#rcontainer {
		float: right;
		width: 84%;
	}

	div#title{
		background-color: #ccc;
		height:60px;
		padding:15px;
		margin:20px auto;
		text-align: left;
		font-size: 20pt;
		float: left; 
		width:84%;
	}
	
	tr {
		height: 50px;
	}
	
	div#btns {
		margin: 30px 0 50px 0;
		float:right;
	}
	
	.button {
		border: none; 
		color:white; 
		box-shadow: 3px 3px 3px #ccc;
		font-size: 15pt;
		padding: 8px 12px	;
	}
</style>

<script type="text/javascript">

		$(document).ready(function(){
			
			$("input#spinnerImgQty").spinner({
				spin:function(event, ui){
					if(ui.value > 3){
						$(this).spinner("value",3);
						return false;
					} 
					else if(ui.value < 0) {
						$(this).spinner("value",0);
						return false;
					}
				}
			})// end of end of $("input#spinnerImgQty").spinner()-----------------
			
			// #### 스피너의 이벤트는 click 도 아니고 change 도 아니고 "spinstop" 이다. #### //
			$("input#spinnerImgQty").bind("spinstop", function(){
				var html = "";
				var cnt = $(this).val();
				
				for(var i=0; i<parseInt(cnt); i++) {
			    	html += "<br>";
			    	html += "<input type='file' name='attach"+i+"' class='btn btn-default' />";
			    }// end of for-----------------------
			    
				$("div#divfileattach").html(html);
			      
			    $("input#attachCount").val(cnt);
			});
			
			
			// 1. 등록 버튼 클릭시 
			$("button.revInsert").click(function(){
				
				var bFlagRequiredInfo = false;
				
				$(".rqdInfo").each(function(index, item){
					var val = $(item).val().trim();
					
					if(val == "") {
						bFlagRequiredInfo = true;
						alert("제목과 글내용은 필수입력사항 입니다.");
						$("input#rtitle").focus();
						return false;
					}
				});
				
				// 글제목 글내용 있을경우 reviewList에 POST방식으로 등록해준다.
				if(!bFlagRequiredInfo) {
					var frm = document.reviewRegFrm;
					frm.action="<%=ctxPath%>/board/reviewList.cc";
					frm.method="GET";
					frm.submit();
				}
			});// end of $("button.revInsert").click(function(){})--------------------------
			
		}); // end of $(document).ready(function(){})-------------------------------------------

		function regCancel() {
			if(confirm("현재 페이지를 종료하시겠습니까? 입력하신 내용은 저장되지 않습니다.")){
				location.href="<%=ctxPath%>/member/memberWriteListMain.cc?userid=${sessionScope.loginuser.userid}";
			}
		}
		
		// Function Declaration 
		function myConfirm() {
			
			
		}
	
</script>

<div id="title"> 
	커뮤니티
</div>

<div id="rcontainer">
<h3>고객리뷰</h3>

<form name="reviewRegFrm">
	
	<table id="tblReviewRegister">
		<tbody>
			<tr>
				<td>제목</td>
				<td>
					<input type="text" id="rtitle" class="rqdInfo" name="rtitle"/>
			</tr>
			<tr>
				<td>작성자</td>
				<td>
					${sessionScope.loginuser.userid}
				</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td>
					${sessionScope.loginuser.email}
				</td>
			</tr>
			<tr>
				<td>리뷰제품명</td>
				<td>
					<%-- ${requestScope.pdvo.pname}&nbsp;${requestScope.pdvo.pcolor} --%>
				</td>
			</tr>
			<tr>
				<td>제품만족도</td>
				<td>
					<select id="ratingType" name="ratingType">
						<option value="choose">별점을 선택하세요.</option>
						<option value="1">★☆☆☆☆</option>
						<option value="2">★★☆☆☆</option>
						<option value="3">★★★☆☆</option>
						<option value="4">★★★★☆</option>
						<option value="5">★★★★★</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>글쓰기</td>
				<td>
				<textarea id="rcontent" name="rcontent" class="rqdInfo" rows="10" cols="100" placeholder="내용을 입력하세요.">
				</textarea>
				</td>
			</tr>
			
			<%-- ==== 첨부파일 타입 추가하기 ==== --%>
			<tr>
				<td class="revImgName">첨부파일(선택)</td>
				<td>
					<label for="spinnerImgQty">파일갯수 : </label>
					<input id="spinnerImgQty" value="0" style="width:30px; height:20px;">
					<div id="divfileattach"></div>
					<input type="hidden" name="attachCount" id="attachCount" />
				</td>
			</tr>
		</tbody>
	</table>
	
</form>

	<div id="btns">
		<button type="button" class="button revInsert" style="background-color:#6d919c;">등록</button>&nbsp;
		<button type="button" class="button" onclick="regCancel()" style="background-color:#c5d7dd;" >취소</button>
	</div>

</div>

<jsp:include page="../footer.jsp" />
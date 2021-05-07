<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />
<jsp:include page="../communityLeftSide.jsp"/>


<style type="text/css">

div#title{
	/* 	border:solid 1px gray; */
		background-color: #ccc;
		width:100%;
		height:60px;
		padding:15px;
		margin:20px auto;
		text-align: left;
		font-size: 20pt;
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
					else iif(ui.value < 0) {
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
			
			// 1. 목록 버튼 클릭시
			$("button.revList").click(function(){
					myConfirm();
			});
			
			// 2. 등록 버튼 클릭시 
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
			
			// 3. 취소 버튼 클릭시
			$("button.regCancel").click(function(){
				alert("리뷰 작성을 취소하셨습니다.");
				location.href="<%=ctxPath%>/board/reviewList.cc";
			});
			
		}); // end of $(document).ready(function(){})-------------------------------------------

		// Function Declaration 
		function myConfirm() {
			if(confirm("현재 페이지를 종료하시겠습니까? 입력하신 내용은 저장되지 않습니다.")){
				location.href="<%=ctxPath%>/board/reviewList.cc";
			}
			
		}
	
</script>

<div id="title"> 
	커뮤니티
</div>

<div id="container">
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
					<select>
						<c:forEach var="pname" items="${requestScope.rvo.fk_pname}">
							<option value="${fk_pname}">${fk_pname}</option>
						</c:forEach>
					</select>
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
				<td colspan="2" id="revcontent">
				<label for="rcontent">글쓰기</label>
				<textarea id="rcontent" name="rcontent" class="rqdInfo" rows="10" cols="60" placeholder="내용을 입력하세요.">
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
	
	<button type="button" class="button revList" style="align:left;">목록</button>
	<button type="button" class="button revInsert" style="align:right;">등록</button>&nbsp;
	<button type="button" class="button regCancel" style="align:right;">취소</button>
</form>

</div>

<jsp:include page="../footer.jsp" />
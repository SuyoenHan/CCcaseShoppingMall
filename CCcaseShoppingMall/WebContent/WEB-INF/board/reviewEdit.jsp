<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="board.model.ReviewVO" %>
<%@ page import="board.model.ReviewDAO" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../header.jsp" />
<jsp:include page="../communityLeftSide.jsp"/>

<style>

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
	
	tr > td {
		padding-right: 30px;
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
	
	#divfileattach {
		padding-top: 20px;
	}
	
	div#review{
		background-color: #6D919C;
		color: white;
	}
 
   div#review:hover{
     	background-color:#CCF2F4; 
     }
	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
	});// end of $(document).ready(function(){})----------------------------------

	function editCancel() {
		if(confirm("현재 페이지를 종료하시겠습니까? 입력하신 내용은 저장되지 않습니다.")){
			var referrer = document.referrer;
			location.href= referrer;
		}
	}
	
	function editComplete() {
		var flag = false;
		$(".rqdInfo").each(function(index, item){
			var val = $(item).val().trim();
			
			if(val == "") {
				flag = true;
				alert("제목과 글내용은 필수입력사항 입니다.");
				$("input#rtitle").focus();
				return false;
			}
		});
		
		if(!flag) {
			var frm = document.reviewRegFrm;
			frm.submit();
		}
			
	}
	
</script>

<div id="title"> 
	커뮤니티
</div>

<div id="rcontainer">
<h3>고객리뷰</h3>

<form name="reviewRegFrm" action="<%=ctxPath%>/board/reviewEdit.cc"
          method="post"
          enctype="multipart/form-data">
	
	<table id="tblReviewRegister" >
		<tbody>
			<tr>
				<td>제목</td>
				<td>
					<input type="hidden" name="reviewno" value="${rvo.reviewno}" />
					<input type="text" id="rvtitle" class="rqdInfo" name="rvtitle" value="${requestScope.rvo.rvtitle}"/>
				</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>
					<input type="text" name="fk_userid" value="${sessionScope.loginuser.userid}" readOnly />
				</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td>
					<input type="text" name="email" value="${sessionScope.loginuser.email}" readOnly />
				</td>
			</tr>
			<tr>
				<td>리뷰제품명</td>
				<td>
				   <input type="text" name="productname" value="${productInfo.productname}&nbsp;${productInfo.pcolor}" readOnly />
				</td>
			</tr>
			<tr>
				<td>제품만족도</td>
				<td>
					<select id="ratingType" name="satisfaction" class="rqdInfo">
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
				<td>등록일</td>
				<td>
					${requestScope.rvo.rregisterdate}
				</td>
			</tr>
			<tr>
				<td>글쓰기</td>
				<td>
				<textarea id="rcontent" name="rvcontent" class="rqdInfo" rows="10" cols="100" placeholder="내용을 입력하세요."></textarea>
				</td>
			</tr>
			
			<%-- ==== 첨부파일 타입 추가하기 ==== --%>
			<tr>
				<td class="revImgName">첨부파일(선택)</td>
				<td>
					<div id="divfileattach"><input type="file" id="img1" name="reviewimage1" /></div><br>
					<div id="divfileattach"><input type="file" id="img2" name="reviewimage2" /></div><br>
					<div id="divfileattach"><input type="file" id="img3" name="reviewimage3" /></div><br>
				</td>
			</tr>
		</tbody>
	</table>
	
	<div id="btns">
		<button type="button" class="button" onclick="editComplete()" style="align:right; background-color:#6d919c;">수정</button>&nbsp;
		<button type="button" class="button" onclick="editCancel()" style="align:right; background-color:#c5d7dd;">취소</button>
	</div>
	
</form>

</div>
	
<jsp:include page="../footer.jsp" />	
	
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
	
</style>


<script type="text/javascript">

		$(document).ready(function(){
						
		}); // end of $(document).ready(function(){})-------------------------------------------

		function regCancel() {
			if(confirm("현재 페이지를 종료하시겠습니까? 입력하신 내용은 저장되지 않습니다.")){
				var referrer = document.referrer;
				location.href= referrer;
			}
		}
		
		function revInsert() {
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
			
			// 글제목 글내용 있을경우 reviewList에 POST방식으로 등록해준다.
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

<form name="reviewRegFrm" action="<%= request.getContextPath()%>/board/reviewWrite.cc"
          method="post"
          enctype="multipart/form-data">
	
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
					${requestScope.pdvo.pname}&nbsp;${requestScope.pdvo.pcolor}
				</td>
			</tr>
			<tr>
				<td>제품만족도</td>
				<td>
					<select id="ratingType" name="ratingType" class="rqdInfo">
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
				<textarea id="rcontent" name="rcontent" class="rqdInfo" rows="10" cols="100" placeholder="내용을 입력하세요."></textarea>
				</td>
			</tr>
			
			<tr>
				<td class="revImgName">첨부파일(선택)</td>
				<td>
					<div id="divfileattach"><input type="file" id="img1" /></div><br>
					<div id="divfileattach"><input type="file" id="img2" /></div><br>
					<div id="divfileattach"><input type="file" id="img3" /></div><br>
				</td>
			</tr>
		</tbody>
	</table>
	
	<div id="btns">
		<button type="button" class="button" onclick="revInsert()" style="background-color:#6d919c;">등록</button>&nbsp;
		<button type="button" class="button" onclick="regCancel()" style="background-color:#c5d7dd;" >취소</button>
	</div>
	
</form>

</div>

<jsp:include page="../footer.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../adminheader.jsp" />

<style type="text/css">

  tr.memberInfo:hover {
        background-color: #e6e6ff;
        cursor: pointer;
   }

	td {
		text-align: center;
	}
	
	span#pagination {
		background-color:#ff751a;
		color:white;
		margin-right:3px;
		width:15px;
		margin: 0 3px;
		font-weight: bold;
	}
	
	a {
		font:bold;
		color: #000;
		text-align:center;
		text-decoration:none;
		font-weight: bold;
	}
	
</style>

<script type="text/javascript">

		$(document).ready(function(){
			
			if("${fn:trim(requestScope.searchWord)}" != "") {
				$("select#searchType").val("${requestScope.searchType}");
				$("input#searchWord").val("${requestScope.searchWord}");
			}
			
			$("select#sizePerPage").bind("change", function(){
				goSearch();
			});
			
			if( "${requestScope.sizePerPage}" != "" ) {
				$("select#sizePerPage").val("${requestScope.sizePerPage}");
			}
			
			$("input#searchWord").bind("keyup",function(){
				if(event.keyCode == 13) {
					goSearch();
				}
			});
			
			// 특정 회원을 클릭하면 그 회원의 상세정보를 보여주도록 한다.
			$("tr.memberInfo").click(function(){
				// console.log($(this).html());
				var userid = $(this).children(".userid").text();
				// alert(userid);
				location.href="<%=ctxPath%>/admin/memberOneDetail.cc?userid="+userid +"&goBackURL=${requestScope.goBackURL}";   
			});
			
		}); // end of $(document).ready(function(){}) -----------------------------------------------------

		function goSearch() {
			
			var frm = document.memberFrm;
			frm.action = "memberList.cc";
			frm.method = "GET";		// 생략 가능. 디폴트가 get이기 때문에
			frm.submit();
		} // end of function goSearch() {}-------------------------------------------
		
</script>

<h2 style="margin:20px;">회원목록</h2>

<form name="memberFrm">

	<select id="searchType" name="searchType" style="margin-left:400px;">
		<option value="choose">선택</option>	<%-- 첫화면/선택 안했을시 기본으로 보여지는 텍스트 --%>
		<option value="name">회원명</option>
		<option value="userid">아이디</option>
		<option value="email">이메일</option>
	</select>
	<input type="text" id="searchWord" name="searchWord" />
	<input type="text" style="display: none;">
	<button type="button" onclick="goSearch();" style="margin-right: 30px;">검색</button>
	
	<select id="sizePerPage" name="sizePerPage">
		<option value="10">10</option>
		<option value="5">5</option>
		<option value="3">3</option>
	</select>

</form>

<table id="memberTbl" class="table" style="align: center; width:80%; margin-top:20px;">
	<thead>
		<tr>
			<th>아이디</th>
			<th>회원명</th>
			<th>이메일</th>
			<th>등급</th>
		</tr>
	</thead>

 	<tbody>
		<c:forEach var ="mvo" items="${requestScope.memberList }">
			<tr class="memberInfo">
				<td class="userid">${mvo.userid}</td>
				<td>${mvo.name}</td>
				<td>${mvo.email}</td>
				<td>
					<c:choose>
						<c:when test="${mvo.fk_grade eq '1'}">
							SILVER
						</c:when>
						<c:when test="${mvo.fk_grade eq '2'}">
							GOLD
						</c:when>
						<c:otherwise>
							BROWN
						</c:otherwise>
					</c:choose>				
				</td>
			</tr>	
		</c:forEach>
	</tbody> 
</table>

	<div style="text-align:center; padding: 20px 0;">
			${requestScope.pageBar}
	</div>

<jsp:include page="../footer.jsp" />
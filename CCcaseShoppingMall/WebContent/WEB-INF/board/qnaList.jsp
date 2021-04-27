<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp" />
<jsp:include page="../leftSide.jsp"/>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" />

<style type="text/css">

   div#content{
   	/*	clear:both;  */
   		width: 70%;
   }
	
   tr.qnaInfo:hover {
        background-color: #e6ffe6;
        cursor: pointer;
   }
   
   td{
   		width: 50px;
   		height: 30px;
   		text-align: center;
   }
   
</style>

<script type="text/javascript">

	$(document).ready(function(){		
		
		if("${fn:trim(requestScope.searchWord)}" != "" ){
			$("select#searchType").val("${requestScope.searchType}");
			$("input#searchWord").val("${requestScope.searchWord}");
		}		

		//  검색어에 엔터 치면 검색
		$("input#searchWord").bind("keyup", function(event){
			if(event.keyCode == 13){
				goSearch();
			}
		});
		
		// 특정 제목을 클릭하면 그 글의 상세정보를 보여주도록 한다.
		$("tr.qnaInfo").click(function(){
			// console.log($(this).html());
			var qtitle = $(this).children(".qtitle").text();
			location.href="<%= ctxPath%>/board/qnaDetail.cc?fk_userid="+fk_userid+"&goBackURL=${requestScope.goBackURL}";
		});
	});// end of $(document).ready(function(){})-------------------------------------------------------------------
	
	// Function declaration
	function goSearch(){
		var frm = document.qnaFrm;
		frm.action = "qnaList.cc";
 		frm.method = "GET";
		frm.submit();
		
	}// end of function goSearch()---------------------------------------
	
	function goWrite(){
		var frm = document.qnaFrm;
		frm.action = "qnaRegister.cc";
 		frm.method = "GET";
		frm.submit();
	}// end of goWrite()-----------------------------------------------------
	
</script>

<div id="content" >
	<h2 style="margin: 20px;">QnA</h2>
	   
	    <table id="qnaTbl" class="table table-bordered" style="margin-top: 20px;">
	        <thead>
	           <tr>	 
	              <th>No.</th>
	              <th>제목</th>
	              <th>작성자</th>
	              <th>등록일자</th>
	              <th>조회수</th>
	           </tr>
	        </thead>

	    	<tbody>
	    		<c:forEach var="qvo" items="${requestScope.qnaList}">
	    			<tr class="qnaInfo">
	    				<td>${qvo.qnano}</td>
	    				<td class="qtitle">${qvo.qtitle}</td>
	    				<td>${qvo.fk_userid}</td>
	    				<td>${qvo.qregisterdate}</td>
	    				<td>${qvo.qviewcount}</td>
	    			</tr>
	    		</c:forEach>
	    	</tbody>
	    </table>

	<form name="qnaFrm">
	 	    
	      <select id="searchType" name="searchType">
		      <option value="qtitle">제목</option>
		      <option value="fk_userid">작성자</option>
	      </select>
	      <input type="text"  id="searchWord"  name="searchWord" />
	      
	 
	      <input type="text"  style="display: none;">
	      <button type="button"  onclick="goSearch();" style="margin-left: 20px;">검색</button>
	      
	      <button type="button"  onclick="goWrite();" style="right: 10%;">글쓰기</button>

    </form>
	    
	    <div style="justify-content: center;">
	    	${requestScope.pageBar}
	    </div>
	    
</div>
 <jsp:include page="../footer.jsp" />
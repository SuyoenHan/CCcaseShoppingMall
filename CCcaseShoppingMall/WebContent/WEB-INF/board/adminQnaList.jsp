<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../adminheader.jsp" />
<jsp:include page="../leftSide.jsp"/>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css" />

<style type="text/css">

   div#content{
   		margin-left: 17%;
   		margin-top: 5%;
   		width:	80%;
   }	
   
   table#qnaTbl {
   		border-left: none;
   		border-right: none;
   }
   
   tr.qnaInfo:hover {
        background-color: #e6ffe6;
        cursor: pointer;
   }  
   
   tr#menu{
   		font-weight: bold;
   		font-size: 18px;
   		background-color: #6D919C;
   		text-align: center;
   		color: white;
   		height: 40px;
   }
   
   th{
   		border: none;
   }
   
   td{
   		width: 10%;
   		height: 35px;
   		text-align: center;
   }
   
   	div#pageBar{
   		width:30%; 
   		margin: 0 auto; 
   		font-size: 20px;
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
	//		console.log($(this).html());
			var qtitle = $(this).children(".qtitle").text();
	//		alert(qtitle);
			var qnano = $(this).children(".qnano").text();
			location.href="<%= ctxPath%>/board/adminQnaDetail.cc?qtitle="+qtitle+"&qnano="+qnano+"&goBackURL=${requestScope.goBackURL}";
		});
	});// end of $(document).ready(function(){})-------------------------------------------------------------------
	
	// Function declaration
	function goSearch(){
		var frm = document.qnaFrm;
		frm.action = "qnaList.cc";
 		frm.method = "GET";
		frm.submit();
		
	}// end of function goSearch()---------------------------------------
	
</script>

<div id="content" >
	<h2 style="margin: 20px;">QnA</h2>
	   
	    <table id="qnaTbl" class="table table-bordered" style="margin-top: 20px;">
	        <thead>
	           <tr id="menu">	 
	              <th style="width:3%;">No.</th>
	              <th style="width:20%;">제목</th>
	              <th style="width:10%;">작성자</th>
	              <th>등록일자</th>
	              <th style="width:3%;">조회수</th>
	           </tr>
	        </thead>

	    	<tbody>
	    		<c:forEach var="qvo" items="${requestScope.qnaList}">
	    			<tr class="qnaInfo">
	    				<td class="qnano" style="width:3%;">${qvo.qnano}</td>
	    				<td class="qtitle" style="width:20%;">${qvo.qtitle}</td>
	    				<td style="width:10%;">${qvo.fk_userid}</td>
	    				<td>${qvo.qregisterdate}</td>
	    				<td class="qviewcount" style="width:3%;">${qvo.qviewcount}</td>
	    			</tr>
	    		</c:forEach>
	    	</tbody>
	    </table>
	   
			
	<form name="qnaFrm" style="margin-top: 5%;">
	      <select id="searchType" name="searchType">
		      <option value="qtitle">제목</option>
		      <option value="fk_userid">작성자</option>
	      </select>
	      
	      <input type="text"  id="searchWord"  name="searchWord" />
	      <input type="text"  style="display: none;">
	      <button type="button"  onclick="goSearch();" style="margin-left: 20px;">검색</button>
	      
    </form>
	    
	    <div style="width:30%; margin: 0 auto;">
	    	${requestScope.pageBar}
	    </div>
	    
</div>
 <jsp:include page="../footer.jsp" />
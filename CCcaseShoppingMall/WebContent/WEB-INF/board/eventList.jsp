<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp" />
<jsp:include page="../communityLeftSide.jsp"/>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" />

<style type="text/css">

   div#content{
   		margin-left: 17%;
   		margin-top: 5%;
   		width:	80%;
   }	
   
   tr.eventInfo:hover {
        background-color: #ecf2f9;
        cursor: pointer;
        transition: 2s;
   }  
   
   tr#menu{
   		font-weight: bold;
   		font-size: 18px;
   		background: #6D919C;
   		text-align: center;
   		color: white;
   		height: 40px;
   }
   
   th{
   		border: none;
   }
   
   tr#eventInfo > td{
   		width: 10%;
   		height: 35px;
   		text-align: center;
   }
    
   div#pageBar{
   		width:30%; 
   		margin: 0 auto; 
   		font-size: 20px;
   }
     
  	div#event{
		background-color: #6D919C;
		color: white;
	}
 
   div#event:hover{
     	background-color:#CCF2F4; 
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
		
		// 특정 글을 그 글의 상세정보를 보여주도록 한다.
		$("tr.eventInfo").click(function(){

			if("${loginuser}"==""){
				alert("이벤트 내용은 로그인 후 확인 가능합니다.");
				response.sendRedirect("javascript:history.back()");
				return;
			}
			else{
				var eventno = $(this).children(".eventno").text();
				if(eventno=="1"){
					location.href="<%=ctxPath%>/board/gawibawiboEvent.cc?eventno="+eventno+"&goBackURL=${requestScope.goBackURL}"; 
					return;
				}
				else if(eventno=="2"){
					location.href="<%=ctxPath%>/board/cardGameEvent.cc?eventno="+eventno+"&goBackURL=${requestScope.goBackURL}"; 
					return;
				}
			}

		}); 	
	});// end of $(document).ready(function(){})-------------------------------------------------------------------
	
	// Function declaration
	function goSearch(){
		var frm = document.eventFrm;
		frm.action = "eventList.cc";
 		frm.method = "GET";
		frm.submit();
		
	}// end of function goSearch()---------------------------------------
	
	function goWrite(){
		var frm = document.eventFrm;
		frm.action = "eventWrite.cc";
 		frm.method = "GET";
		frm.submit();
	}// end of goWrite()-----------------------------------------------------
	
</script>

<div id="content" >
	<h2 style="margin: 20px;">EVENT</h2>
	   
	    <table id="eventTbl" class="table table-bordered" style="margin-top: 20px;">
	        <thead>
	           <tr id="menu">	 
	              <th style="width:3%;">No.</th>
	              <th style="width:20%;">제목</th>
	              <th>기간</th>
	              <th>등록일</th>
	           </tr>
	        </thead>

	    	<tbody>
	    		<c:forEach var="evo" items="${requestScope.eventList}">
	    			<tr class="eventInfo">
	    				<td class="eventno" style="width:3%;">${evo.eventno}</td>
	    				<td style="width:20%;">${evo.title}</td>
	    				<td>${evo.startdate} - <br> ${evo.enddate}</td>
	    				<td>${evo.registerdate}</td>
	    			</tr>
	    		</c:forEach>
	    	</tbody>
	    </table>
	
	    <div style="width:30%; margin: 0 auto;">
	    	${requestScope.pageBar}
	    </div>
	    
</div>
 <jsp:include page="../footer.jsp" />
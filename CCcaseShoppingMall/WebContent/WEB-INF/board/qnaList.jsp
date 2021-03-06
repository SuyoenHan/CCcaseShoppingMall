<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp" />
<jsp:include page="../communityLeftSide.jsp"/>

<link rel="stylesheet" href="<%=ctxPath%>/css/style.css" />

<style type="text/css">

   div#content{
   		margin-left: 17%;
   		margin-top: 5%;
   		width:	80%;
   		margin-bottom: 20%;
   }	
   
   table#qnaTbl {
   		border-left: none;
   		border-right: none;
   }
   
   tr.qnaInfo:hover {
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
   
   table#qnaTbl > thead > tr > td,
   table#qnaTbl > tbody > tr > td {
   		width: 10%;
   		height: 35px;
   		text-align: center;
   }
   
   div#pageBar{
   		width:30%; 
   		margin: 0 auto; 
   		font-size: 20px;
   }
     
    div#qna{
		background-color: #6D919C;
		color: white;
	}
 
   div#qna:hover{
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
		
		// 특정 제목을 클릭하면 그 글의 상세정보를 보여주도록 한다.
		// 그런데 만약에 비번 걸린 글이면 비번 입력해야 볼 수 있다.
		$("tr.qnaInfo").click(function(){

			var qnano = $(this).children(".qnano").text();
			var qnapwd = $(this).children(".qnapwd").text();
			var qstatus = $(this).children(".qstatus").text();
			var qnaWriter = $(this).children(".qnaWriter").text();
			
			if(qstatus == "1"){ // 클릭한 글이 비공개 글이라면
				if("${sessionScope.loginuser.userid}" == qnaWriter){ // 로그인아이디가 qna 작성자와 같다면
																									// 암호 검사 진행
					var test = 1;
					var pass = prompt('글 암호를 입력하십시오','글 암호를 입력하세요'); // 암호 물어보는 멘트
					
					while (test < 3) {
						if (!pass) {
							location.href ="qnaList.cc";
							break;
						}
						if (pass == qnapwd) { // 암호지정
							alert('확인을 누르면 클릭하신 글로 이동합니다.'); // 암호가 맞았을때 나오는 멘트	 
							location.href ="qnaDetail.cc?qnano="+qnano+"&goBackURL=${requestScope.goBackURL}";
							break;
						}
						test += 1;
						var pass1 = prompt('암호를 확인 하시고 다시 입력하세요!.','암호 확인'); // 암호가 틀렸을때 멘트
					}
					if (pass != qnapwd && test == 3) {// 비밀번호 세번 틀리면 이전페이지로
						location.href ="qnaList.cc";
						return ""; 	
					}  
				}
				else{// 로그인 아이디가 qna 작성자와 다르다면
					alert("비공개글입니다. 작성자 본인 외엔 글 조회가 불가능합니다.");
				}
			}  
			else{// 클릭한 글이 비공개 글이 아니라면 비밀번호 입력 없이 바로 연결
				location.href ="qnaDetail.cc?qnano="+qnano+"&goBackURL=${requestScope.goBackURL}";
			}   

		});// end of $("tr.qnaInfo").click(function(){})-------------------------------------------------------------
			
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
		frm.action = "qnaWrite.cc";
 		frm.method = "GET";
		frm.submit();
	}// end of goWrite()-----------------------------------------------------
	
</script>

<div id="content" >
	<h2 style="margin: 20px;">QnA</h2>
	   
	    <table id="qnaTbl" class="table table-bordered" style="margin-top: 20px;">
	        <thead>
	           <tr id="menu">	 
	              <th style="width:3%;">No.</th>
	              <th style="width:20%;">제목</th>
	              <th style="width:8%;">작성자</th>
	              <th>등록일자</th>
	              <th style="width:5%;">조회수</th>
<%--          <th style="width:5%;">상태</th>		--%>
	           </tr>
	        </thead>

	    	<tbody>
	    		<c:forEach var="qvo" items="${requestScope.qnaList}">
	    			<tr class="qnaInfo">
	    				<td class="qnano" style="width:3%;">${qvo.qnano}</td>
	    				<td style="width:20%;">${qvo.qtitle}</td>
	    				<td class="qnaWriter" style="width:8%;">${qvo.fk_userid}</td>
	    				<td>${qvo.qregisterdate}</td>
	    				<td style="width:5%;">${qvo.qviewcount}</td>
<%--    				<td style="width:5%;">
		    				<c:choose>
			    				<c:when test="${requsetScope.qcvo ne null}">답변완료</c:when>
			    				<c:when test="${requsetScope.qcvo eq null}">미완료</c:when>
		    				</c:choose>
		    			</td>		--%>
	    				<td class="qnapwd" style="display:none;">${qvo.qnapwd}</td>
	    				<td class="qstatus" style="display:none;">${qvo.qstatus}</td>
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
	      <button type="button"  onclick="goSearch();" style="margin-left: 10px; background: #6D919C; border:none; color:white; border-radius: 2px; height: 25px;">검색</button>
	      
	      <c:if test="${not empty sessionScope.loginuser.userid}">
	      	<button type="button"  onclick="goWrite();" style="background: #6D919C; color: white; border:none; width: 100px; height: 40px; margin-left: 62%; border-radius: 5px;">글쓰기</button>
   		  </c:if>
    </form>
	    
	    <div id="pageBar">
	    	${requestScope.pageBar}
	    </div>
	    
</div>

 <jsp:include page="../footer.jsp" />
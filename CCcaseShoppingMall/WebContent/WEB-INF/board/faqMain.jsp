<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<%
	String ctxPath = request.getContextPath();
%>

 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 
<style>

	 tr.faqDetail {
	 	 overflow: visible;
	 	 border:solid 1px red;
	 	  /*  display: none;   */ 
	 }

	div#contents ,table{
		color: #333;
		width:80%;
		
	}

	div#title{
	/* 	border:solid 1px gray; */
		background-color: #ccc;
		width:100%;
		height:60px;
		margin:10px auto;
		padding:15px;
		text-align: left;
		font-size: 20pt;
	}

	
	table , tr {
		border:solid 1px gray;
		border-collapse: none;
		line-height: 30px;
	}
	
	button.button{
	 width:80px;
	 height:40px;
	 margin:10px auto;
	}
	
	thead th {
	
		background-color: #8c8c8c;
	}
	
     /* table#faqDetail {
     	width:100%;
     	
     } */
     
    .cal{
    	font-weight: bold;
    	border: solid 1px gray;
    	line-height: 40px;
    	
    }
    .faqcontent{
    	background-color: #e6e6e6;
    	border: solid 1px gray; 
    	padding: 25px ;
    }
    
    tr.faqSimple{
       background-color: #eee;
	   color: #444;
	   cursor: pointer;
	   padding: 18px;
	   width: 50%;
	   border: none;
	   text-align: left;
	   font-weight:bold;
	   font-size: 15px;
	   transition: 2s;
    }
    tr.faqSimple:hover{
   	 background-color:  #aaa !important;
    }
    
    
    
</style>
  

<script type="text/javascript">

	$(document).ready(function(){
		
		func_height();//footer.jsp에 있음!
		
		
		
		// 관리자로 로그인 되었을때만 보이도록 함.---아직 구현안함!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		$("button.faqwrite").click(function(){
			//버튼(글쓰기)를 클릭하면
			//alert("글쓰기 버튼 클릭");
			location.href="<%=ctxPath%>/board/faqwrite.cc";
			
		});//end of $("button#faqwrite").click(function(){}); ------------------
		
		
		
		
		$("tr.faqDetail").css('display','none'); //안보이도록 한다.
		// 특정 게시물을 클릭하면 내용물이 보여지도록 한다.
		$("tr.faqSimple").click(function(event){
			
			var $faqDetail =$(this).next();
			
			var sDisplay = $faqDetail.css('display');
			//console.log("확인용 sDisplay: "+ sDisplay);
			
			if( sDisplay == "none"){
				
				$("tr.faqDetail").css('display','none'); // 전부 안보이도록 한다.
				$faqDetail.css('display',''); // '' display  block을 사용한다는 말이다. 
			
			}
			else{
  				// display 상태가 보이는 것이라면
  				$faqDetail.css('display','none'); //안보여지도록 한다.
  			}
  			
			
		});
		
		
		
		
		
		
	});// end of $(document).ready(function(){})--------------

</script>

<link rel="stylesheet" href="<%=ctxPath%>/css/style.css" />
<jsp:include page="../header.jsp" />
<jsp:include page="../leftSide.jsp" />


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>



<div id="contents">

	
		<div id="title"> 
				커뮤니티
		</div>
			
		<h2> FAQ </h2>
		<div class="container">	

			<table class="table table-hover">
				<thead>
					<tr>
						<th>NO.</th>
						<th>제목</th>
						<th>등록일자</th>
						<th>조회수</th>
					</tr>
				</thead>
				
				<tbody>
				<c:forEach var="fvo" items="${requestScope.faqList}">
					<tr class="faqSimple">
						<td class="faqno">${fvo.faqno}</td>
						<td>${fvo.ftitle}</td>
						<td>${fvo.fregisterdate}</td>
						<td>${fvo.number}</td>
					</tr>
					<tr class="faqDetail">
						<td colspan="4"> 
							<table id="faqDetail">
								<tr>
									<div class="cal">제목:&nbsp;&nbsp; ${fvo.ftitle}</div>
									
								<tr>
								<tr>
									<div class="cal">작성자: &nbsp;&nbsp;${fvo.fk_adminid}</div>
								<tr>
								<tr>
								   <div class="cal">
									<span >등록일:&nbsp;&nbsp;${fvo.fregisterdate}</span>&nbsp;&nbsp;&nbsp;&nbsp;
									<span >최초등록일:&nbsp;&nbsp;</span> &nbsp;&nbsp;&nbsp;&nbsp;
									<span >최근수정일:&nbsp;&nbsp;${fvo.fupdatedate}</span>
									</div>
								<tr>
								<tr>
									<div class="cal">글내용</div>
									<div class="faqcontent">${fvo.fcontent}</div>
								     
								<tr>
							</table>
						
							<button type="button" class="button faqList" name="faqList" style="align:left;">목록</button>
							<button type="button" class="button faqEdit" name="faqEdit" style="align:right;">수정</button>
							<button type="button" class="button faqDel" name="faqDel" style="align:right;">삭제</button>
						
						</td>
					 </tr>
					</c:forEach>
				</tbody>
			
			</table>
			
			<button type="button" class="button faqwrite"  name="faqwrite" value="글쓰기" style="float:right; " >글쓰기</button>
			<!-- 페이징바 -->
			<div ></div>
	
	</div>
</div>


<jsp:include page="../footer.jsp" />




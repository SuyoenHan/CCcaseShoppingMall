<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<title>CCcase 공지사항 </title>

    
<%
	String ctxPath = request.getContextPath();
%>

 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 
<style>

	 

	div#contents {
		margin-left: 35px ;
    	margin-right: 35px ;
		color: #333;
		width:70%;
		
	}
	
	.container{
		width:100% !important;
		margin-top:20px;
	}

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

	
	table , tr {
		border:solid 1px gray;
		border-collapse: none;
		line-height: 30px;
	}
	
	button.button{
	 width:80px;
	 height:40px;
	 margin-left: 35px ;
    
	}
	
	.button:hover{
		background-color: #666699;
		color: white;
		margin-top: 35px ;
    	
    	
	}
	
	thead th {
	
		background-color: #8c8c8c;
	}
	
     
    .cal{
    	font-weight: bold;
    	font-size:16px;
    	border: solid 1px gray;
    	margin-left: 35px ;
    	margin-right: 35px ;
    	line-height: 40px;
    	
    }
    .faqcontent{
    	background-color: #e6e6e6;
    	border: solid 1px gray; 
    	margin-left: 35px ;
    	margin-right: 35px ;
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
    
    #contents > div.container > table > tbody > tr.faqDetail {
    	 
    	background-color: white;
    }
    
    
</style>
  

<script type="text/javascript">

	$(document).ready(function(){
		
		var fnum =document.getElementsByName("fnum");
		
		func_height();//footer.jsp에 있음!
		
		
		if("${noticeno}"!="x"){
			
			$("tr.faqDetail").each(function(index,item){
				
				if($(item).prop("id")=="${noticeno}"){
					$(item).css('display','');
				}
				else{
					$(item).css('display','none');
				}
				
			}); // end of each-------------------------
		}
		else{
		
			$("tr.faqDetail").css('display','none'); //안보이도록 한다.
		}
		
		
		$("tr.faqSimple").click(function(event){
			
			if($(this).next().css('display')=="none"){
				location.href="<%=ctxPath%>/board/noticeList.cc?currentShowPageNo=${currentShowPageNo}&sizePerPage=${sizePerPage}&noticeno="+$(this).next().prop("id");			
			}
			else{
				$(this).next().css('display','none');
			}
			
		});
		
		
		$("button.faqList").click(function(){
			//목록버튼 클릭했을 때
			//alert("목록클릭!");
			location.href="<%=ctxPath%>/board/noticeList.cc";
			
		});
		
		$("button.noticeWrite").click(function(){
			//버튼(글쓰기)를 클릭하면
			//alert("글쓰기 버튼 클릭");
			location.href="<%=ctxPath%>/board/noticewrite.cc";
			
		});//end of $("button#noticeWrite").click(function(){}); ------------------
		
		
		
	});// end of $(document).ready(function(){})--------------

</script>

<link rel="stylesheet" href="<%=ctxPath%>/css/style.css" />
<jsp:include page="../header.jsp" />
<jsp:include page="../communityLeftSide.jsp" />


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>



<div id="contents">

	
		<div id="title"> 
				커뮤니티
		</div>
			
		<h2> 공지사항 </h2>
		<div class="container">	
		  <form name="faqFrm">
			<table class="table table-hover">
				<thead>
					<tr style="width:80%;">
						<th>NO.</th>
						<th>제목</th>
						<th>작성자</th>
						<th>등록일자</th>
						<th>조회수</th>
					</tr>
				</thead>
				
				<tbody>
				<c:forEach var="nvo" items="${requestScope.noticeList}">
						<input type="hidden" name="sizePerPage" id="sizePerPage" value="7" />
						<input type="text" style="display: none;"><%-- form으로 보낼 대상인 input태그가 1개뿐이라서 해줌 --%>
					<tr class="faqSimple">
						<td class="noticeno" name="noticeno" id="noticeno">${nvo.noticeno}</td>
						<td name="ntitle" id="ntitle">${nvo.ntitle}</td>
						<td name="fk_adminid" id="fk_adminid">${nvo.fk_adminid}</td>
						<td name="nregisterdate" id="nregisterdate">${nvo.nregisterdate}</td>
						<td name="nviewcount" id="nviewcount">${nvo.nviewcount}</td>
					</tr>
					
					<tr class="faqDetail" id="${nvo.noticeno}">
						<td colspan="4"> 
							<table id="faqDetail">
								<tr>
									<div class="cal" style="margin-top: 20px ;">제목:&nbsp;&nbsp; ${nvo.ntitle}</div>
									
								</tr>
								<tr>
									<div class="cal">작성자: &nbsp;&nbsp;${nvo.fk_adminid}</div>
								</tr>
								<tr>
								   <div class="cal">
									<span >등록일:&nbsp;&nbsp;${nvo.nregisterdate}</span>&nbsp;&nbsp;&nbsp;&nbsp;
									<span >최초등록일:&nbsp;&nbsp;</span> &nbsp;&nbsp;&nbsp;&nbsp;
									<span >최근수정일:&nbsp;&nbsp;${nvo.nupdatedate}</span>
									</div>
								</tr>
								<tr>
									<div class="cal">글내용</div>
									<div class="faqcontent">${nvo.ncontent}</div>
								     
								</tr>
							</table>
						
							<button type="button" class="button faqList" name="faqList" style="align:left; margin: 15px 0 20px 35;">목록</button>
						
						</td>
					 </tr>
					</c:forEach>
				</tbody>
			
			   </table>
			</form>
			
			
			<!-- 관리자로 로그인이 되어졌을때만 글쓰기 버튼이 보인다. -->
			<c:if test="${not empty requestScope.avo}">
			<button type="button" class="noticeWrite"  id="noticeWrite" name="noticeWrite" value="글쓰기" style="float:right; " >글쓰기</button>
			</c:if>
			<!-- 페이징바 -->
			<div style="text-align:center; font-size:17px;">${requestScope.pageBar}</div>
	
	</div>
</div>


<jsp:include page="../footer.jsp" />



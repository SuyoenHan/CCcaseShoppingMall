<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<title>CCcase FAQ페이지 </title>
    
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
		background-color: #98B7C1;
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
	 border:solid 1px #98B7C1;
     background-color: #98B7C1;
    
	}
	
	.button:hover{
		background-color: #98B7C1;
		color: white;
    	
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
   	 background-color:  #ecf2f9 !important;
    }
    
    #contents > div.container > table > tbody > tr.faqDetail {
    	 
    	background-color: white;
    }
    
    div#faq{
		background-color: #6D919C;
	}
     div#faq:hover{
     	background-color:#CCF2F4; 
     }
   
   
</style>
  

<script type="text/javascript">

	$(document).ready(function(){
		
		func_height();//footer.jsp에 있음!
		
		if("${faqno}"!="x"){

			$("tr.faqDetail").each(function(index,item){
				
				if($(item).prop("id")=="${faqno}"){
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
		
		
		//클릭시 조회수 증가
		$("tr.faqSimple").click(function(event){
			
			if($(this).next().css('display')=="none"){
			   
			   var $viewCount = $(this).find("#fnum");
			   var faqno = $(this).next().prop("id");
				$.ajax({
		    		  url:"<%= ctxPath%>/board/updateViewCount.cc",
		    		  type:"post",
		    		  data:{"faqno": faqno},
		    		  dataType:"json",
		    		  success:function(json){ // {"n":1}   {"n":0}
		                      // 조회수 등록 성공 되어지면
		                      var j = json.viewCount;
		                      // console.log(j);
		    		          $viewCount.text(j); 
		                      
		    			//	$(this).find("td#fnum").text(json.viewCount);
		    			
		    		  },
		    		  error: function(request, status, error){
		  	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  	       	  }
		    		
				});
				  $(this).next().css('display','');
			}
			else{
				
				$(this).next().css('display','none');
				
				
			}
			
		
		});
		
		
		//목록버튼 클릭했을 때
		$("button.faqList").click(function(){
			
			//alert("목록클릭!");
			location.href="<%=ctxPath%>/board/faqList.cc";
			
		});
		 
	
			
		
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
			
		<h2> FAQ </h2>
		<div class="container">	
		  <form name="faqFrm">
			<table class="table table-hover">
				<thead>
					<tr id="tr1" style="width:80%;">
						<th>NO.</th>
						<th>제목</th>
						<th>등록일자</th>
						<th>조회수</th>
					</tr>
				</thead>
				
				<tbody>
				<c:forEach var="fvo" items="${requestScope.faqList}">
						<input type="hidden" name="sizePerPage" id="sizePerPage" value="7" />
						<input type="text" style="display: none;"><%-- form으로 보낼 대상인 input태그가 1개뿐이라서 해줌 --%>
					<tr class="faqSimple">
						<td class="faqno" name="faqno" id="faqno">${fvo.faqno}</td>
						<td name="ftitle" id="ftitle">${fvo.ftitle}</td>
						<td name="fregisterdate" id="fregisterdate">${fvo.fregisterdate}</td>
						<td name="fnum" id="fnum">${fvo.number}</td>
					</tr>
					
					<tr class="faqDetail" id="${fvo.faqno}">
						<td colspan="4"> 
							<table id="faqDetail">
								<tr>
									<div class="cal" style="margin-top: 20px ;">제목:&nbsp;&nbsp; <span>${fvo.ftitle}</span></div>
									
								</tr>
								<tr>
									<div class="cal" id="writer" name="writer">작성자: &nbsp;&nbsp;<span id="writer" name="writer">${fvo.fk_adminid}</span></div>
								</tr>
								<tr>
								   <div class="cal">
									<span >등록일:&nbsp;&nbsp;<span>${fvo.fregisterdate}</span></span>&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<span >최근수정일:&nbsp;&nbsp;<span>${fvo.fupdatedate}</span></span>
									</div>
								</tr>
								<tr>
									<div class="cal">글내용</div>
									<div class="faqcontent">${fvo.fcontent}</div>
								     
								</tr>
							</table>
						
							<button type="button" class="button faqList" name="faqList" style="align:left; margin: 15px 0 20px 35;">목록</button>
							
							
						</td>
					 </tr>
					</c:forEach>
				</tbody>
			
			   </table>
			</form>
			
			
			
			<!-- 페이징바 -->
			<div style="text-align:center; font-size:17px;">${requestScope.pageBar}</div>
	
	</div>
</div>


<jsp:include page="../footer.jsp" />




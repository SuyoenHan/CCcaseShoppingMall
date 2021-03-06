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
		height: 1000px;
		overflow: visible;
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
	 td{
    	height: 35px;
   		
    }
     
    
    .noticecontent{
    	background-color: #e6e6e6;
    	border: solid 1px gray; 
    	margin-left: 35px ;
    	margin-right: 35px ;
    	padding: 25px ;
    }
    
    tr.noticeSimple{
     
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
    tr.noticeSimple:hover{
   		 background-color: #ecf2f9 !important;
    }
    
 
    div#notice{
		background-color: #6D919C ;
	}
    div#notice:hover{
    	background-color:#CCF2F4; 
    }
    
    
    tr#tr1{
     	background-color: #6D919C !important;
     	font-weight: bold;
   		font-size: 18px;
   		text-align: center;
   		color: white;
   		height: 40px;
     	
     }
   
   	table.noticeDetail{
   		border-bottom: solid 1px #6D919C;
   	}
    
    
</style>
  

<script type="text/javascript">

	$(document).ready(function(){
		
		
		func_height();//footer.jsp에 있음!
		
		
		if("${noticeno}"!="x"){
			
			$("tr.noticeDetail").each(function(index,item){
				
				if($(item).prop("id")=="${noticeno}"){
					$(item).css('display','');
				}
				else{
					$(item).css('display','none');
				}
				
			}); // end of each-------------------------
		}
		else{
		
			$("tr.noticeDetail").css('display','none'); //안보이도록 한다.
		}
		
		

		//클릭시 조회수 증가
		$("tr.noticeSimple").click(function(event){
			
			if($(this).next().css('display')=="none"){
				
				   var $viewCount = $(this).find("#nviewcount");
				   var noticeno = $(this).next().prop("id");
					$.ajax({
			    		  url:"<%= ctxPath%>/board/updateNoticeViewCount.cc",
			    		  type:"post",
			    		  data:{"noticeno": noticeno},
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
		
		
		
		
		// 수정 버튼을 클릭했을때 =>팝업창띄우기 
		 $("button.noticeEdit").click(function(){
			 
			
			// notice글 수정하기 팝업창 띄우기
			var noticeno = $(this).parent().parent().prop("id");
			
			var url = "<%=ctxPath%>/board/noticeEdit.cc?noticeno="+noticeno;
			 
			  	
			  window.open(url, "noticeEdit",
					           "lefe=350p, top=100px,width=700px, height=450px");
				 
	     }); //end of 수정버튼 클릭-----------------
				  
			  
		
		//삭제버튼 클릭했을 때
		$("button.noticeDel").click(function(){
			var noticeno = $(this).parent().parent().prop("id");
			
		    var bool =  confirm(noticeno +"번 글을 정말로 삭제 하시겠습니까?")
				   
		    if(bool){ // 확인을 눌렀을때
			
				$.ajax({
					url:"<%=ctxPath%>/board/noticeDelete.cc",
					type:"POST",
					data:{"noticeno":noticeno},
					dataType:"json",
					success:function(json){ //웹페이지에 보여질 결과물을 java객체인 json에담아 보여줄 것이다.
						   alert(json.message);   //json 에 담아준 msg를 보여준다.
						  // swal(json.msg);
						   location.href="<%=ctxPath%>/board/noticeList.cc";
				   },
				   error: function(request, status, error){
			            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			       }
					   
				   }); //end of $.ajax({});-------------------------
		       
		       }
		       else{//취소를 눌렀을때
		    	  alert("해당 글 삭제를 취소하셨습니다.");
		      }	
				
			});//end of $("button.noticeDel").click(function(){})---------------------------------
		
			
			
			
	    //글쓰기 버튼을 클릭했을 때
		$("button.noticewrite").click(function(){
			//버튼(글쓰기)를 클릭하면
			//alert("글쓰기 버튼 클릭");
			location.href="<%=ctxPath%>/board/noticewrite.cc";
			
		});//end of $("button#faqwrite").click(function(){}); ------------------
			
		
		
		
	});// end of $(document).ready(function(){})--------------

</script>

<link rel="stylesheet" href="<%=ctxPath%>/css/style.css" />

<jsp:include page="../adminheader.jsp" />
<jsp:include page="../communityLeftSide.jsp" />



<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>



<div id="contents">

	
		<div id="title"> 
				커뮤니티
		</div>
			
		<h2> 공지사항 </h2>
		<div class="container">	
		  <form name="noticeFrm">
			<table class="table table-hover">
				<thead>
					<tr id="tr1"style="width:80%;">
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
					<tr class="noticeSimple">
						<td class="noticeno" name="noticeno" id="noticeno">${nvo.noticeno}</td>
						<td name="ntitle" id="ntitle">${nvo.ntitle}</td>
						<td name="fk_adminid" id="fk_adminid">${nvo.fk_adminid}</td>
						<td name="nregisterdate" id="nregisterdate">${nvo.nregisterdate}</td>
						<td name="nviewcount" id="nviewcount">${nvo.nviewcount}</td>
					</tr>
					
					<tr class="noticeDetail" id="${nvo.noticeno}">
						<td colspan="5"> 
							<table id="noticeDetail">
								<tr>
									<div class="cal" style="margin-top: 20px ;">제목:&nbsp;&nbsp;<span>${nvo.ntitle}</span></div>
									
								</tr>
								<tr>
									<div class="cal">작성자: &nbsp;&nbsp;<span>${nvo.fk_adminid}</span></div>
								</tr>
								<tr>
								   <div class="cal">
									<span >등록일:&nbsp;&nbsp;<span>${nvo.nregisterdate}</span>&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<span >최근수정일:&nbsp;&nbsp;<span>${nvo.nupdatedate}</span>
									</div>
								</tr>
								<tr>
									<div class="cal">글내용</div>
									<div class="noticecontent">${nvo.ncontent}</div>
								     
								</tr>
							</table>
						
							
								<button type="button" class="button noticeList" name="noticeList" style="align:left; margin: 15px 0 20px 35;">목록</button>
							<!-- 관리자로 로그인이 되어졌을때만 버튼이 보인다. -->
							<c:if test="${not empty requestScope.avo}">	
								<button type="button" class="button noticeEdit" name="noticeEdit" style="align:right;">수정</button>
								<button type="button" class="button noticeDel" name="noticeDel" style="align:right;">삭제</button>
							</c:if>	
						</td>
					 </tr>
					</c:forEach>
				</tbody>
			
			   </table>
			</form>
			
			<!-- 관리자로 로그인이 되어졌을때만 글쓰기 버튼이 보인다. -->
			<c:if test="${not empty requestScope.avo}">
			<button type="button" class="noticewrite button"  id="noticewrite" name="noticewrite" value="글쓰기" style="float:right; " >글쓰기</button>
			</c:if>
			
			
			<!-- 페이징바 -->
			<div style="text-align:center; font-size:17px;">${requestScope.pageBar}</div>
	
	</div>
</div>


<jsp:include page="../footer.jsp" />




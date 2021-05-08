<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath =request.getContextPath();
%>
    
<jsp:include page="../header.jsp" /> 
<jsp:include page="../communityLeftSide.jsp"/>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" />

<style type="text/css">
   div#content{
   		margin-left: 20%;
   		margin-top: 5%;
   		width:	80%;
   }	
   
   td{
   		height: 30px;
   }
   
   td.title{
   		width: 20%;
   		font-weight: bold;
   		border-bottom: solid 1px #6D919C; 
   }
   
   div#titletext{
	   width: 100%;
	   text-align: center;
	   padding: 100px;
	   font-size: 20px;
	   border-top: solid 3px #6D919C; 
   
   }
   
   div#text{
	    width: 100%;
	    text-align: center;
	    font-size: 25px;
	    color:red;
	    font-weight: bold;
   }
   
   	.prev_next {
		margin: 5% 0 5% 0;
	    width: 80%;
	    border-top: 1px solid #444444;
	    border-collapse: collapse;
	}
	
  .prev_next >  tbody > tr > td {
	    border-bottom: 1px solid #444444;
	    padding: 10px;
	    text-align: center;
  }
  
  div.font{
  	text-align: center;
  	
  }
  div#pcSel{
  	padding:30px auto;
  }
  
  button.button{
  	  width:100px;
	  height:50px;
	  margin-right: 20px;
	  align: center;
	  background-color: #98B7C1;
  }
  
  button.userSel{
  
	  width:120px;
	  height:140px;
	  font-weight: bold;
	  margin-right:10px;
	  margin-left:20px;
	  font-size: 20px;
	 
  }
   
   .button:hover , .userSel:hover{
		background-color: #98B7C1;
		color: white;
   
   
   
   
   
  </style>
<script type="text/javascript">
    var goBackURL = "";
	$(document).ready(function(){
		goBackURL = "${requestScope.goBackURL}";
		goBackURL = goBackURL.replace(/ /gi, "&");
		
		
		
	if("${sessionScope.loginuser.userid}" != ""){	
		
		 $("button.userSel").bind("click",function(){
			    var userChoice = $(this).val();  //내가 클릭한 곳의 value 1=가위, 2=바위, 3=보
				// alert(userChoice);
			
			    /*== 자바스크립트에서 난수 발생시키기 ==//
	      		  공식 :  Math.floor( Math.random()*(max-min+1) ) + min; 
				*/
				var nRandom = Math.floor( Math.random()*(3-1+1) ) + 1; // nRandom 은 1부터 3까지 중 하나이다.
				
				if(nRandom==1){
					 $("div#pcSel").html("<img src='/CCcaseShoppingMall/images/event/가위.png' style='width:200px; height:200px; margin:0px auto;' /><div class='font' style='font-weight:bold; font-size:20px; '>가위</div>");
				}
				else if(nRandom==2){
					 $("div#pcSel").html("<img src='/CCcaseShoppingMall/images/event/주먹.png' style='width:200px; height:200px; margin:0px auto;' /><div class='font' style='font-weight:bold; font-size:20px;'>바위</div>");
				}
				else if(nRandom==3){
					 $("div#pcSel").html("<img src='/CCcaseShoppingMall/images/event/보.png' style='width:200px; height:200px; margin:0px auto;' /><div class='font' style='font-weight:bold; font-size:20px;'>보</div>");
				}
				// console.log($("div#pcSel").text());
					
			    
			    
				$.ajax({ // 중복참여 방지를 위한 테이블에insert시켜주기
						url:"<%=request.getContextPath()%>/board/gawibawiboEventInsert.cc",
						type:"post",
						data:{"userid":"${sessionScope.loginuser.userid}",
							  "eventno":"${eventno}"},
						dataType:"json",
						success:function(json){
							// 중복테이블에 아이디 존재하는 경우. alert 창, 버튼상태 disable-true줌
							
							if(json.n==1){
								//참여를 하지 않은 회원이라면 
								
					             if( (Number(userChoice) == "1" && nRandom == 3) || ( Number(userChoice) == "2" && nRandom == 1 ) || ( Number(userChoice) == "3" && nRandom == 2 )){
					            	// 이겼을때 해당 userid point update 시켜주기 
					            	console.log("여기");
										$.ajax({ 
											url:"<%=request.getContextPath()%>/board/gawibawibopointUpdate.cc",
											type:"post",
											data:{"userid":"${sessionScope.loginuser.userid}"},
											dataType:"json",
											success:function(json){
												alert(json.msg);
											},
											error: function(request, status, error){
									            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
									        }
										});//end of ajax()-------------------------
									
					             }
					             else if(Number(userChoice) ==  nRandom ){
					            	 alert(" 꽝 !! 비겼습니다 .");
					            	
					             }
					             else if((Number(userChoice) == "1" && nRandom == 2) || ( Number(userChoice) == "2" && nRandom == 3 ) || ( Number(userChoice) == "3" && nRandom == 1 )){
					            	 alert(" 꽝 !! 졌습니다 .");
					            	
					             }
					           
							}
							else{
								//중복회원일경우
								alert(json.msg);
								location.href="<%=ctxPath%>/board/eventList.cc";
								return;
							}
						},
						error: function(request, status, error){
				            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				       }
					
				   });
			 
			 });//end of $("span.buttons").bind("click",function(){} --
			 
	    }	
         else{
    		 alert("회원 로그인 후 이용 가능합니다.");
    		 location.href="<%=ctxPath%>/"+goBackURL;
         }
                  
          
		$("td#nextEvent").click(function(){

			location.href="<%=ctxPath%>/board/cardGameEvent.cc?eventno=2&goBackURL=${requestScope.goBackURL}"; 
		});
	
		
             
				
	});// end of $(document).ready(function(){})------------------------
	
	
	// function doEvent 
	
	
	
	
	
	// Function Declaration
	function goEventList() {
		location.href = "<%=ctxPath%>/"+goBackURL;
	}// function goEventList()----------------------------------------------------
	
	function goEdit(){
			location.href= "eventEdit.cc?eventno=${requestScope.evo.eventno}";
	}// end of function goEdit()---------------------------------------------------
	
	function goDelete(){
        if(confirm("정말로 삭제하시겠습니까?")==true){
            location.href="eventDelete.cc?eventno=${requestScope.evo.eventno}";
        }
	}// end of function goDelete()---------------------------------------------

	
</script>
<div id="content" >
<h2 style="margin: 20px;">EVENT</h2>
    
    <form name="eventDetailForm">
    <table style="width: 700px; border-color: lightgray;">
        <tr>
            <td class="title">제목</td>
            <td style="padding-left:20px;">${title}</td>        
        </tr>
        <tr>
            <td class="title">작성자</td>
            <td style="padding-left:20px;">${fk_adminid}</td>
        </tr>
        <tr>
            <td class="title">시작일</td>
            <td style="padding-left:20px;">${startdate}</td>
        </tr>
        <tr>
            <td class="title">종료일</td>
            <td style="padding-left:20px;">${enddate}</td>
        </tr>
        <tr>
            <td class="title">등록일</td>
            <td style="padding-left:20px;">${registerdate}</td>
        </tr>
        
        <tr>
            <td colspan="2" id="title">
              	<div id="titletext">지금! 가위바위보를 이겨 포인트 500 점을 얻어가세요!<br></div>
            </td>
         </tr>
         <tr id="titletext">             
            <td colspan="2">
            	<div id="text">기회는 단 한번! 안내면 진다 가위 바위 보 !</div>
            	<div id= "userSel" style="border:solid 0px gray; width:67%; margin:100px auto;">
            		<button type="button" class="userSel button" id="gawi" name="gawi" value="1" ><img src='/CCcaseShoppingMall/images/event/가위.png' style='width:100px; height:100px; margin:0px auto;' />가위</button>
            		<button type="button" class="userSel button" id="bawi" name="bawi" value="2"><img src='/CCcaseShoppingMall/images/event/주먹.png' style='width:100px; height:100px; margin:0px auto;' />바위 </button>
            		<button type="button" class="userSel button" id="bo" name="bo" value="3"><img src='/CCcaseShoppingMall/images/event/보.png' style='width:100px; height:100px; margin:0px auto;' />보 </button>
            	</div>
            	<div id="pcSel" style=" width:30%; height:250px; margin:30px auto">[ PC 결과 ]</div>
            	
            </td>        
          </tr>
        
	</table>
	</form>
	  	
	<div style="display:inline-block;">
		<button type="button" class="button" onclick="goEventList()" style="margin-top: 50px; background-color: #98B7C1; border:none; width: 100px; height: 40px; border-radius: 5px; margin-right: 60%;">목록</button>
	</div>
	<div style="display:inline-block;">
		<c:if test="${sessionScope.adminUser.adminid !=null }">
			<button type="button" onclick="goEdit()" style="margin-top: 50px; background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px;">수정</button>
			<button type="button" onclick="goDelete()" style="margin-top: 50px; background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; border-radius: 5px;">삭제</button>
		</c:if>
	</div>
  	<!-- 이전글, 다음글 조회 -->
	<div>
		<table class="prev_next">
			<thead>
				<tr>
					<th>구분</th>
					<th>글번호</th>
					<th>글제목</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="font-weight: bold;">이전글</td>
					<c:choose>
						<c:when test="${requestScope.epvo.eventno eq null}">
							<td colspan="2" style="color: red; border: medium; border-bottom: 1px solid #444444;"> 이전 글이 없습니다. </td>
						</c:when>
						<c:when test="${requestScope.epvo.eventno ne null}">
							<td>${requestScope.pevo.eventno}</td>
							<td onclick="goPrev()" style="cursor: pointer;">${requestScope.pevo.title}</td>
						</c:when>
					</c:choose>
				</tr>
				<tr>
					<td style="font-weight: bold;">다음글</td>
					<c:choose>
						<c:when test="${requestScope.envo.eventno eq null}">
							<td colspan="2" style="color: red; border-bottom: 1px solid #444444; padding: 10px; text-align: center;">
								 다음 글이 없습니다. 
							</td>
						</c:when>
						<c:when test="${requestScope.envo.eventno ne null}">
							<td>${requestScope.envo.eventno}</td>
							<td id="nextEvent"style="cursor: pointer;">${requestScope.envo.title}</td>
						</c:when>
					</c:choose>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- 이전글, 다음글 끝 -->	
</div>
<jsp:include page="../footer.jsp" />
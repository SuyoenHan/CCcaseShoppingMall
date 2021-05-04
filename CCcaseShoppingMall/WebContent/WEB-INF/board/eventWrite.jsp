<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    

<%
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<title>Event 등록하기</title>
<jsp:include page="../adminheader.jsp" />
<jsp:include page="../adminleftSide.jsp"/>

<link rel="stylesheet" href="<%=ctxPath%>/css/style.css" />

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
   }
   
  </style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 <script type="text/javascript">
	
	 $(document).ready(function(){		
		 
		 document.getElementById("registerdate").valueAsDate = new Date();// 입력일 현재 날짜로 설정

	 });
 
	 // Function declaration

	function on_load(){
		document.eventWriteForm.title.focus();
	}
	
	//입력 날짜 체크
	function checkDate(){

		 var now = new Date();
		 year = now.getYear();          		// 현재 년도 가져오기
		 month = now.getMonth()+1;       // 현재 월 가져오기 (+1)
		
		 if((month+"").length < 2){         //월이 '7'로 찍히지 않고 '07'로 찍히도록 길이를 받아온다
		      month = "0" +month;         	//길이가 1이라면 앞에 0을 붙여서 '07'형태로 나오게 한다
		 }
		
		 date = now.getDate();       			// 현재 날짜 가져오기
		 
		if((date+"").length < 2){         		//일이 '7'로 찍히지 않고 '07'로 찍히도록 길이를 받아온다
		  date = "0" +date;           			//길이가 1이라면 앞에 0을 붙여서 '07'형태로 나오게 한다
		 }
		 today = year +""+ month +""+ date ;          	 //오늘 날짜 ex) 20080801
	
		 var InputStartDate = document.eventWriteForm.startdate.value;    //입력된 시작일 받아오기
		 var InputEndDate = document.eventWriteForm.enddate.value;    	//입력된  종료일 받아오기
		 
		 var startdateSplit = InputStartDate.split("-");         								//입력값을 '-'을 기준으로 나누어 배열에 저장해 주는 함수 split
		 var enddateSplit = InputEndDate.split("-");
		 
		 startyear = startdateSplit[0];      //첫번째 배열은 년
		 startmonth = startdateSplit[1];  	//월
		 startday = startdateSplit[2];   		//일
	
		 endyear = enddateSplit[0];      	//첫번째 배열은 년
		 endmonth = enddateSplit[1];  		//월
		 endday = enddateSplit[2];   		//일
		 
		 InputStartDate = startyear +""+ startmonth +""+ startday;       //입력된 값을 더해준다.
		 InputEndDate = endyear +""+ endmonth +""+ endday; 
		 
		 if (parseInt(InputStartDate) < parseInt(today) ){          //int형으로 변환하여 비교한다
		      alert("시작일이 오늘 날짜보다 이전 날짜입니다.");
		      document.eventWriteForm.startdate.value = "";         //이전 날짜라면 입력폼 리셋처리
		 }
		 if (parseInt(InputEndDate) < parseInt(today) ){          
		      alert("종료일이 오늘 날짜보다 이전 날짜입니다.");
		      document.eventWriteForm.enddate.value = "";        
		 }
		 
		 if(parseInt(InputStartDate) > parseInt(InputEndDate)){
			 alert("종료일이 시작일보다 이전 날짜입니다.");
		     document.eventWriteForm.enddate.value = "";
		 }
	}
	
</script>
</head>

<body onload="fn_onload()">
<div id="content" >
<h2 style="margin: 20px;">QnA</h2>
    
    <form action="eventWriteEnd.cc" method="post" name="eventWriteForm">
    <table style="width: 700px; border-color: lightgray;">

        <tr>
            <td class="title">제목</td>
            <td>
                <input name="title" id="title" type="text" size="70" maxlength="50" value=""/>
            </td>        
        </tr>
        <tr>
            <td class="title">작성자</td>
            <td><input type="text" id="fk_adminid" name="fk_adminid" size="70" value="${sessionScope.adminUser.adminid}" readonly></td>
        </tr>
		<tr>
            <td class="title">이벤트 시작일</td>
            <td><input type="date" size="70" class="startdate" name="startdate" value="yyyy-mm-dd" onchange="javascript:checkDate(this)"></td>
         </tr>
         <tr>
            <td class="title">이벤트 종료일</td>
            <td><input type="date" size="70" class="enddate" name="enddate" value="yyyy-mm-dd" onchange="javascript:checkDate(this)"></td>
        </tr>
        <tr>
            <td class="title">등록일</td>
            <td><input type="date" id="registerdate" name="registerdate" size="70"  value="currentDate" readonly></td>
        </tr>
        <tr>
            <td id="title">
               이벤트 내용
            </td>
            <td>
                <textarea name="content" id="content" cols="72" rows="15"></textarea>            
            </td>        
        </tr>

        <tr align="center" valign="middle">
            <td colspan="5">
                <input type="reset" value="작성취소" >
                <input type="submit" value="등록" >
                <input type="button" value="목록" onClick="location.href='<%=ctxPath%>/board/eventList.cc'" >            
            </td>
        </tr>
    </table>    
    </form>
</div>
</body>
</html>

<jsp:include page="../../WEB-INF/footer.jsp" />
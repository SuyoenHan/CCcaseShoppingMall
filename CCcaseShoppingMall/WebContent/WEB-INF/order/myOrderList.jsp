<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
    
<%
	String ctxPath = request.getContextPath();
%>


<jsp:include page="../header.jsp" />
<jsp:include page="../member/myPageHeader.jsp" />  
<jsp:include page="../mypageleftSide.jsp" />    


<!DOCTYPE html>
<html lang="en">
<head>
  <title>주문내역 조회</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="<%=ctxPath%>/css/style.css" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
  
<style>

	div#dateGroup{
		background-color: #a6a6a6;
		color:
	}
	
	 div#myOrderList{
		background-color: #6D919C;
	}
	
	 div#myOrderList:hover{
		background-color: #CCF2F4;
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
	
	tr#tr1{
	 background-color: #98B7C1;
	}
	
	tr#tr2{
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
	tr#tr2:hover{
	   
   	 background-color:  #ecf2f9 ;
    }
	
</style>

<script type="text/javascript">

	
	

	$(document).ready(function(){
		
		func_height(); 
		
		displayOrderList("1");
		
		// 주문목록 더보기 위하여 "더보기..." 버튼 클릭액션 이벤트 등록하기
	    $("button#btnMoreOrderList").click(function(){
	       
	       if($(this).text() == "처음으로"){
	          $("tbody#displayOrderList").empty();
	          $("span#end").empty();
	          displayOrderList("1");
	          $(this).text("더보기...");
	       }
	       else{
	          displayOrderList($(this).val());        
	          // displayHIT("9"); 
	          // displayHIT("17");
	          // displayHIT("25");
	          // displayHIT("33");            
	       }         
	    });
		
		
		
		// 배송조회 버튼 클릭
		$("button#shipstatusBtn").click(function(){
			alert("배송확인");
			<%-- var orderno =$(this).parent().parent().find("td#orderno").text();
			
			
			//배송조회 페이지로 이동 시켜준다.
			var frm = document.orderListFrm;
			frm.action="<%=ctxPath%>/order/shipStatus.cc?orderno="+orderno;
			frm.method="POST"; // 나중에 POST로 바꿔!?
			frm.submit();   --%>
			
			
		});
		
		
		//상품평관리 클릭
		$("button#productReviewBtn").click(function(){
			
			//하나의 상품(내가 클릭한 곳)리뷰 다는 곳으로 이동 시켜준다.
			var frm = document.orderListFrm;
			frm.action="<%=ctxPath%>/board/reviewWrite.cc";
			frm.method="GET"; // 나중에 POST로 바꿔!?
			frm.submit();
			
		});
		
				
		
	});//end of $(document).ready(function(){})------------------------------
	
	
	
	 // Function declaration
	 
	  var lenOrderList = 4;
	 // orderList "더보기..." 버튼을 클릭할때 보여줄 상품의 개수(단위)크기 
	 
	 var fk_userid = "${sessionScope.loginuser.userid}";
	 // display 할 orderList 정보를 추가 요청하기(Ajax 로 처리해야 함)
	 function displayOrderList(start){ 
	    // start가 1이라면 1~8 까지 상품 8개를 보여준다.
	    // start가 9이라면 9~16 까지 상품 8개를 보여준다.
	    // start가 17이라면 17~24 까지 상품 8개를 보여준다.
	    // start가 25이라면 25~32 까지 상품 8개를 보여준다.
	    // start가 33이라면 33~36 까지 상품 4개를 보여준다.(마지막 상품)
		
		 $.ajax({
	         url:"/CCcaseShoppingMall/order/orderListDisplayJSON.cc", 
	      //   type:"GET", 
	         data:{"fk_userid": fk_userid
	             ,"start":start   // "1"  "9"  "17"  "25"  "33"   
	             ,"len":lenOrderList},  //  8      8    8     8     8 
	         dataType:"JSON",
	         success:function(json){
	        	  
            var html = "";
             
            if(start == "1" && json.length == 0) {
                // 처음부터 데이터가 존재하지 않는 경우
                // !!! 주의 !!!
                // if(json == null) 이 아님!!!
                // if(json.length == 0) 으로 해야함!!
                html += "주문내역 상품이 없습니다.";
                
                // HIT 상품 결과를 출력하기
                $("tbody#displayOrderList").html(html);
            }
            
            else if( json.length > 0 ) {
               // 데이터가 존재하는 경우
             
               $.each(json, function(index, item){
            	
            	   var shipstatus ="";
 	            	  if(item.shipstatus==0){
 	            		  shipstatus = "<span>입금완료</span>";
 	            		  
 	            	  }
 	            	  else if(item.shipstatus==1){
 	            		 shipstatus = "<span>배송중</span><br>"+
 			        				 "<button type='button' class='shipstatusBtn' id='shipstatusBtn' name='shipstatusBtn' >배송조회</button>";
 	            	  }
 	            	 else if(item.shipstatus==2){
 	            		 shipstatus = "<span>배송완료</span><br>"+
			 			        	  "<button type='button' class='shipStatusBtn' id='shipChangeBtn' name='shipChangeBtn' >교환접수</button>"+
			 			        	  "<button type='button' class='shipStatusBtn' id='shipRefundBtn' name='shipDeleteBtn' >환불접수</button>";
 	            	  }
 	            	 else if(item.shipstatus==3){
 	            		 shipstatus = "<span>구매확정</span><br>"+
 			        				  "<button type='button' class='shipstatusBtn' id='productReviewBtn' name='productReviewBtn' >상품평관리</button>";
 	            	  }
 	            	 else if(item.shipstatus==4){
 	            		 shipstatus = "<span>교환처리중</span><br>";
 	            	  }
 	            	 else if(item.shipstatus==5){
 	            		 shipstatus = "<span>환불처리중</span><br>";
 	            	  }
 	            	 else if(item.shipstatus==6){
 	            		 shipstatus = "<span>교환완료</span><br>";
 	            	  }
 	            	 else if(item.shipstatus==7){
 	            		 shipstatus = "<span>환불완료</span><br>";
 	            	  }
  	            	   
 	            	  
 	            	  
 	            	  
  	                  html +=  
  	                	  	   "<tr id='tr2'> "+
  				      		   "     <td> "+
  							   "		<span><img src='/CCcaseShoppingMall/images/product/"+item.pimage1+"' name='pimage1'id='pimage1'style='width:55px; height:55px; float:left'/></span> "+ 
  							   "		<span id='productname' name='productname'>"+item.productname+"</span>&nbsp;&nbsp;<span id='pcolor' name='pcolor'>"+item.pcolor+"</span><br>  "+             
  							   " 		<span>옵션:&nbsp</span><span id='modelname' name='modelname'>"+item.modelname+"</span> "+
  							   "     </td>	 "+
  							   "     <td id='orderdate' name='orderdate'>주문일자 "+item.orderdate+"</td> "+
  							   "     <td id='orderno' name='orderno'>"+item.orderno+"</td> "+
  							   "     <td id='odetailno' name='odetailno'>"+item.odetailno+"</td> "+
  							   "	 <td id='pnum' name='pnum'>"+item.pnum+"</td> "+
  							   "     <td id='totalPrice' name='totalPrice'>주문금액"+item.totalPrice+"원</td> "+
  							   "     <td id='odqty' name='odqty'>"+item.odqty+"</td> "+
  							   "     <td>"+shipstatus+"<input type='hidden' id='odetailno' name='odetailno' value='"+item.odetailno+"' /></td> " +
  						       "</tr>"
  						     
	            	  	        //console.log(item.odetailno);        
  	             	
	
	                  
	               }); 
	               
	               // 결과를 출력하기
	               $("tbody#displayOrderList").append(html);
	               
	               // >>> !!! 중요 !!! 더보기... 버튼의 value 속성에 값을 지정하기 <<< //  
	               $("button#btnMoreOrderList").val(Number(start) + lenOrderList);
	               // 더보기... 버튼의 value 값이  9  로 변경된다.
	               // 더보기... 버튼의 value 값이 17  로 변경된다.
	               // 더보기... 버튼의 value 값이 25  로 변경된다.
	               // 더보기... 버튼의 value 값이 33  로 변경된다.
	               // 더보기... 버튼의 value 값이 41  로 변경된다.
	               
	               
	               // countHIT 에 지금까지 출력된 상품의 개수를 누적해서 기록한다.
	               $("span#countOrderList").text(  Number($("span#countOrderList").text()) + json.length );
	               
	               // 더보기... 버튼을 계속해서 클릭하여 countHIT 값과 totalHITCount 값이 일치하는 경우 
	               if( $("span#totalOrderListCount").text() == $("span#countOrderList").text() ) {
	                  $("span#end").html("더이상 조회할 제품이 없습니다.");
	                  $("button#btnMoreOrderList").text("처음으로");
	                  $("span#countOrderList").text("0");
	               }
	               
	               
	               
	               
	               
	               ///////////////////////////////////////////////////////////////////////////////////////
	               //배송조회 버튼 클릭
					$("button#shipstatusBtn").click(function(){
						
						 var orderno =$(this).parent().parent().find("td#orderno").text();
						
						
						//배송조회 페이지로 이동 시켜준다.
						var frm = document.orderListFrm;
						frm.action="<%=ctxPath%>/order/shipStatus.cc?orderno="+orderno;
						frm.method="POST"; // 나중에 POST로 바꿔!?
						frm.submit();   
						
						
					});
					
					
					//상품평관리 클릭
					$("button#productReviewBtn").click(function(){
						
						//하나의 상품(내가 클릭한 곳)리뷰 다는 곳으로 이동 시켜준다.
						var frm = document.orderListFrm;
						frm.action="<%=ctxPath%>/board/reviewWrite.cc";
						frm.method="GET"; // 나중에 POST로 바꿔!?
						frm.submit();
						
					});
		
					
					// 환불하기 버튼 클릭시
					$("button#shipRefundBtn").click(function(){
						
						var orderno =$(this).parent().parent().find("td#orderno").text();
						var productname =$(this).parent().parent().find("span#productname").text();
						var modelname =$(this).parent().parent().find("span#modelname").text();
						var odetailno=$(this).parent().parent().find("input#odetailno").val();					
						var url ="<%=ctxPath%>/board/productRefund.cc?orderno="+orderno+"&productname="+productname+"&odetailno="+odetailno;

						window.open(url, "refundProduct","lefe=350p, top=100px,width=700px, height=450px");
						
					});
					
					// 교환하기 버튼 클릭시
					$("button#shipChangeBtn").click(function(){
						
						var orderno =$(this).parent().parent().find("td#orderno").text();
						var odetailno = $(this).parent().parent().find("td#odetailno").text();
						var productname =$(this).parent().parent().find("span#productname").text();
						var modelname =$(this).parent().parent().find("span#modelname").text();
						var pcolor =$(this).parent().parent().find("span#pcolor").text();
						var odetailno=$(this).parent().parent().find("input#odetailno").val();					
						var url ="<%=ctxPath%>/board/productChange.cc?orderno="+orderno+"&productname="+productname+"&pcolor="+pcolor+"&odetailno="+odetailno;

						window.open(url, "changeProduct","lefe=350p, top=100px,width=700px, height=450px");
						
					});
					
					
					
	           
	              
	            }
	            
	         },
	         error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	         }
	      }); 
	   
	   }// end of displayOrderList()---------------------------------------
	
	
	
	
	
	
	

</script>
  
  
  
</head>
<body>

<div id="contents">
<form name ="orderListFrm" action="<%=ctxPath %>/order/myOrderList.cc" >
	<div class="container">
	  <h2><span name="userid" id= "userid">${sessionScope.loginuser.userid}</span><span> 님 주문내역 조회</span></h2>
	  <p>-- 배송상태 (0 입금대기 / 1 입금완료 / 2 배송중 / 3 배송완료 / 4 구매확정 / 5 교환  6 환불)</p>            
	  <table class="table table-hover">
	    
	    <thead>
	     
	      <tr id="tr1">
	        <th>상품정보</th>
	        <th>주문일자</th>
	        <th>주문번호</th>
	        <th>주문상세번호</th>
	        <th>제품번호</th>
	        <th>주문금액</th>
	        <th>주문수량</th>
	        <th>주문상태</th>
	      </tr>
	    </thead>
	    
	    <tbody id="displayOrderList">
	    </tbody>
	    
	  </table>
	   
	  
	
	  
	  <div style="margin: 20px 0;">
	  <span id="end" style="font-size: 16pt; font-weight: bold; color: red;"></span><br/> 
	  <button type="button" class="button"id="btnMoreOrderList" value="">더보기...</button>
	  <span id="totalOrderListCount">${requestScope.totalOrderListCount}</span>
      <span id="countOrderList">0</span>
      
	</div>
 </div>
</form>	
</div>
</body>
</html>

<jsp:include page="../footer.jsp" />

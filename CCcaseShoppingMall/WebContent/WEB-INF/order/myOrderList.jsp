<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
    
<%
	String ctxPath = request.getContextPath();
%>


<jsp:include page="../header.jsp" />
<jsp:include page="../mypageleftSide.jsp" />    
<jsp:include page="../member/myPageHeader.jsp" />  

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
		
		
	}
	
	 div#myOrderList{
		background-color: #6D919C;
		
	}
	
	 div#myOrderList:hover{
		background-color: #CCF2F4;
		transition: 1s;
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
	 color: white;
	 height: 65px;
	 font-size: 17px;
	}
	
	tr#tr2 {
	   color: #444;
	   cursor: pointer;
	   padding: 18px;
	   width: 50%;
	   border: none;
	   text-align: left;
	   font-weight:bold;
	   font-size: 15px;
	   transition: 2s;
	   height:80px;
	  
	}
	tr#tr2  > td {
		 vertical-align:middle; 
	}
	
	tr#tr2:hover{
	   
   	 background-color:  #ecf2f9 ;
    }
	
	
	
</style>

<script type="text/javascript">

	
	

	$(document).ready(function(){
		
		func_height();  //사이드바와 바디컨텐츠 높이 맞추기.
		
		//페이징 처리 1 번부터 시작되도록 
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
	          // displayOrderList("5"); 
	          // displayOrderList("9");
	         
	       }         
	    });
		
		
		
		
				
		
	});//end of $(document).ready(function(){})------------------------------
	
	
	
	 // Function declaration
	 
	  var lenOrderList = 4;
	 // orderList "더보기..." 버튼을 클릭할때 보여줄 상품의 개수(단위)크기 
	 
	
	 
	 var fk_userid = "${sessionScope.loginuser.userid}";
	 // display 할 orderList 정보를 추가 요청하기(Ajax 로 처리해야 함)
	 function displayOrderList(start){ 
	    // start가 1이라면 1~4 까지 상품 4개를 보여준다.
	    // start가 5이라면 5~8 까지 상품 4개를 보여준다.
	   
		
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
                html += "<< 주문내역이 없습니다. 구매 후 확인해주세요. >>";
                
                // 상품 결과를 출력하기
                $("tbody#displayOrderList").html(html);
            }
            
            else if( json.length > 0 ) {
               // 데이터가 존재하는 경우
             
              
               $.each(json, function(index, item){
            	
            	  var totalPrice = item.totalPrice;
 		          //console.log(totalPrice);    
 		       	  //상품가격에 , 찍어주기
 		          totalPrice= totalPrice.toLocaleString('en')+" 원";
            	  
 		       	  //중복리뷰달기 방지 >> 리뷰테이블에 odetailno 있는지 확인을 위한 변수
            	  var odetailno =  item.odetailno;
            	   
            	   
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
 	            		
 	            		var n =0;
 	            		 $.ajax({
 	            			 url:"/CCcaseShoppingMall/order/shipstatus3.cc", 
           		      //     type:"GET", 
           		             data:{"odetailno": odetailno},  
           		             dataType:"JSON",
           		             success:function(json){
           		            	 
           		            	 n=json.n
           		            	 console.log(n);
           		            	
           		             },
           		            error: function(request, status, error){
           		           		 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
           		            }
           		             
           		           
           		          
 	            		 });
 	            		 
 	            		 if(n==0){
 	            			 shipstatus = "<span>구매확정</span><br>"+
	        				  "<button type='button' class='shipstatusBtn' id='productReviewBtn' name='productReviewBtn' >상품평관리</button>";
	        				  
 	            		}
 	            		else if(n==1){
 	            			shipstatus = "<span>구매확정</span><br>"+
   		            		"<button type='button' class='shipstatusBtn' id='productReviewExist' name='productReviewExist' >상품평등록완료</button>";
   		            		
 	            		}
 	            		
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
  	            	   
 	            	  
 	         //  console.log(shipstatus);
 		            	  
 	            	 
  	                  html +=  
  	                	  	   "<tr id='tr2'> "+
  				      		   "     <td> "+
  							   "		<span><img src='/CCcaseShoppingMall/images/"+item.pimage1+"' name='pimage1'id='pimage1'style='width:60px; height:60px; float:left'/></span> "+ 
  							   "		&nbsp;&nbsp;<span id='productname' name='productname'>"+item.productname+"</span>&nbsp;&nbsp;<span id='pcolor' name='pcolor'>"+item.pcolor+"</span><br>  "+             
  							   " 		&nbsp;&nbsp;<span>옵션:&nbsp</span><span id='modelname' name='modelname'>"+item.modelname+"</span> "+
  							   "     </td>	 "+
  							   "     <td id='orderdate' name='orderdate'>"+item.orderdate+"</td> "+
  							   "     <td id='orderno' name='orderno'>"+item.orderno+"</td> "+
  							   "     <td id='odetailno' name='odetailno'>"+item.odetailno+"</td> "+
  							   "	 <td id='pnum' name='pnum'>"+item.pnum+"</td> "+
  							   "     <td id='totalPrice' name='totalPrice'>"+totalPrice+"</td> "+
  							   "     <td id='odqty' name='odqty'>"+item.odqty+"</td> "+
  							   "     <td>"+shipstatus+"<input type='hidden' id='odetailno' name='odetailno' value='"+item.odetailno+"' /></td> " +
  						       "</tr>"
  						     
	            	  	        //console.log(item.odetailno);        
  	             	
	                                      
	                  
	               }); //$.each(json, function(index, item) -------------------
               
	            		   

	               // 결과를 출력하기
	               $("tbody#displayOrderList").append(html);
	               
	               // >>> !!! 중요 !!! 더보기... 버튼의 value 속성에 값을 지정하기 <<< //  
	               $("button#btnMoreOrderList").val(Number(start) + lenOrderList);
	               // 더보기... 버튼의 value 값이  5  로 변경된다.
	               // 더보기... 버튼의 value 값이 9  로 변경된다.
	               // 더보기... 버튼의 value 값이 13  로 변경된다.
	               
	               
	               
	               // countOrderList 에 지금까지 출력된 상품의 개수를 누적해서 기록한다.
	               $("span#countOrderList").text(  Number($("span#countOrderList").text()) + json.length );
	               
	               // 더보기... 버튼을 계속해서 클릭하여 countOrderListCount 값과 totalOrderListCount 값이 일치하는 경우 
	               if( $("span#totalOrderListCount").text() == $("span#countOrderList").text() ) {
	              $("span#end").html("더이상 조회할 제품이 없습니다.<br>");
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
	               
	   ///////////            
	              
	               	
	   //////////////            
					
					
					//상품평관리 클릭
					$("button#productReviewBtn").click(function(){
						
						var orderno =$(this).parent().parent().find("td#orderno").text();
						var productname =$(this).parent().parent().find("span#productname").text();
						var modelname =$(this).parent().parent().find("span#modelname").text();
						var odetailno=$(this).parent().parent().find("input#odetailno").val();			
						
						//하나의 상품(내가 클릭한 곳)리뷰 다는 곳으로 이동 시켜준다.
						var frm = document.orderListFrm;
						frm.action="<%=ctxPath%>/board/reviewWrite.cc?orderno="+orderno+"&productname="+productname+"&odetailno="+odetailno;
						frm.method="POST"; // 나중에 POST로 바꿔!?
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

<div id="contents" style="margin:20px 0px 0px 20px; width: 80%;">
<form name ="orderListFrm" action="<%=ctxPath %>/order/myOrderList.cc" >
	<div class="container">
	  <h3>[ <span name="userid" id= "userid" style="color:#6D919C;">${sessionScope.loginuser.userid}</span><span> 님 주문내역 조회(3개월) ]</span></h3>
	  <p>------------------------------------------------------------------------------------------------------</p>            
	  <table class="table table-hover" style="width: 95%;">
	    
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
	   
	  
	
	  
	  <div style="margin: 30px auto;">
	  <span id="end" style="font-size: 15pt; font-weight: bold;  color:#008080;"></span><br/> 
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

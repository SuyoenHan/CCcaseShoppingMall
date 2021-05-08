<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	String ctxPath= request.getContextPath();
%>       

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	
	div#mypage{
		margin:120px 0px 80px 210px;
		width: 83%;
		font-size:20pt;
		height:130px;
		/* border: solid 1px blue; */
	}
	
	div#myInfo{
		padding-left:50px;
		padding-bottom:10px;
		margin-top:100px;
		border: solid 1px #AAAAAA;
	}	

	span#grade{
		color: navy;
		font-weight: bold;
		font-size: 16pt;
	}
	
	table#tblmyInfo{
		display:inline-block;
		margin-top:30px;
		width: 100%;
	}
	span#title{
	display:inline-block;
		font-weight: bold;
		margin-top: 15px;
	}
	


</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
	$.ajax({
		url : "<%= request.getContextPath()%>/member/myPageHeader.cc", //데이터베이스에 접근해 현재페이지로 결과를 뿌려줄 페이지
		data : {
		"userid":"${sessionScope.loginuser.userid}" //dbGet.jsp페이지로 데이터를 보냄
		},
		dataType:"json",
		success : function(json){ //DB접근 후 가져온 데이터
			//console.log($.trim(item)); //jsp페이지 통째로 가져오다보니 공백을 자를 필요가 있음.
			 $("div#coupon").html(json.acnt+"장");
			 $("div#order").html(json.ocnt+"건");
		}
		});

});


</script>
<div id="mypage">
	<div id="myInfo">
		<div id="myInfo1">
			<table id="tblmyInfo">
				<tr>
					<td rowspan="2" style="width:400px;">	
						<span style="font-size:12pt;">
						<span style="font-size:15pt; font-weight: bold;">${sessionScope.loginuser.name}</span>님의<br></span>
						<span style="font-size:15pt;">회원등급은</span>
						<span id=grade>
							<c:choose>
								<c:when  test="${sessionScope.loginuser.fk_grade eq 0}"><span style="color:#694639;">Brown</span></c:when>
								<c:when test="${sessionScope.loginuser.fk_grade eq 1}"><span style="color:#A8A9AD;">Silver</span></c:when>
								<c:otherwise><span style="color:#F7D000;">Gold</span></c:otherwise>
							</c:choose>
							회원등급
						</span> 
						<span style="font-size:15pt;">입니다</span> 
					</td>
					<td  style=" font-size: 13pt; text-align: center; width:200px;">
						<img src="<%= ctxPath%>/images/member/cart.png" alt="장바구니 이미지" width="70" height="70" />
						<br><span id="title">총 주문</span>
						
					</td>
					<td style="font-size: 13pt;text-align: center;width:200px;">
						<img src="<%= ctxPath%>/images/member/point1.png" alt="포인트 이미지" width="50" height="50" />
						<br><span id="title">포인트</span>
					</td>
					<td  style="font-size: 13pt;text-align: center;width:200px;">
						<img src="<%= ctxPath%>/images/member/쿠폰.png" alt="쿠폰이미지" width="70" height="70" />
						<br><span id="title">쿠폰</span>
					</td>
				</tr>
				<tr>
					<td style="font-size: 13pt;text-align: center;"><a href="<%= ctxPath %>/order/myOrderList.cc"><div id="order"></div></a></td>
					<td style="font-size: 13pt;text-align: center;"><a>${sessionScope.loginuser.totalpoint}point</a></td>
					<td style="font-size: 13pt;text-align: center;"><a href="<%= ctxPath %>/member/availableCoupon.cc"><div id="coupon">장</div></a></td>
				</tr>
			</table>

		</div>
	</div>
</div>
	<form action="<%= ctxPath%>/member/myPageHeader.cc" name="frm" >
		<input type="hidden" name="userid" value="${sessionScope.loginuser.userid}" />
	</form>
			
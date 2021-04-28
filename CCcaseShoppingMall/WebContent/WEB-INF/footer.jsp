<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String ctxPath= request.getContextPath();
%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<style type="text/css">

	div.footerNavigator{
		border: solid 0px red;
		float: left;
		margin-left: 15px;
		width: 100px;
		height: 150px;
	}
	
	div.footerInfo{
		background-color: #333300;
		color: #fff;
		font-weight: bold;
		text-align: center;
		height: 35px;
		padding-top: 10px;
		margin-bottom: 10px;
		opacity: 0;
	}
	
	div.footerNavigator img{
		width: 90px;
		height: 90px;
		margin-left: 4px;
		border-radius: 50%;
	}

	div.footerNavigato a{
		text-decoration: none;
	}

</style>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
	    
		 $("div.footerNavigator img").hover(function(){
			 
			 $(this).parent().prev().css("opacity","0.7");
			 $(this).css("opacity","0.5");

		 },function(){  // end of mouseover event-----------------
			 
			 $(this).parent().prev().css("opacity","0");
			 $(this).css("opacity","1");
		 }); // end of mouseout & hover event-----------------
			
	});
</script>

		<div id="footer">
			<div class="footerSection">
				<span style="font-size:20pt; font-weight: bold;">CCcase</span><br>
				COPYRIGHT &copy; CCcase ALL RIGHTS RESERVED<br><br><br><br><br>
			</div>
			<div class="footerSection" style="padding-left:50px; margin-left: 120px;">
				<span style="font-weight: bold;">BANK INFO</span><br>
				농협 000-0000-0000-00<br>
				신한 000-0000-0000-00<br>
				국민 000-0000-0000-00<br>
				예금주 (주) CCcase<br><br><br>
			</div>
			<div class="footerSection" style="padding-left:100px;">
				<br>
				<table>
					<tr>
						<td rowspan="2">전화이미지</td>
						<td style="font-size: 13pt;">&nbsp;&nbsp;&nbsp;&nbsp;02-0000-0000</td>
					</tr>
					<tr>
						<td style="font-size: 13pt;">&nbsp;&nbsp;&nbsp;&nbsp;010-0000-0000</td>
					</tr>
				</table>
				<br>
				<span style="font-weight: bold;">영업일</span><br>
				평일 오전 09:00~오후5:30<br>
				점심 오후 1:00~ 오후 2:00<br>
				토 / 일 / 공휴일 휴무
			</div>
			
			<div style="margin-left:50px; margin-top:40px;">
			
				<div class="footerNavigator">
					<div class="footerInfo">회사소개</div>
					<a href="<%=ctxPath%>/company.cc">
						<img src="<%=ctxPath%>/images/homeMain/companyInfoIcon.png" />
					</a>
				</div>
				
				<div class="footerNavigator">
					<div class="footerInfo">공지사항</div>
					<a href="">
						<img src="<%=ctxPath%>/images/homeMain/noticeIcon.png" />
					</a>
				</div>
				
				<div class="footerNavigator">
					<div class="footerInfo">상품문의</div>
					<a href="<%=ctxPath%>/board/qnaList.cc">
						<img src="<%=ctxPath%>/images/homeMain/qnaIcon.png" />
					</a>
				</div>
				
				<div class="footerNavigator">
					<div class="footerInfo">주문조회</div>
					<a href="">
						<img src="<%=ctxPath%>/images/homeMain/showOrderIcon.png" />
					</a>
				</div>
				
				<div class="footerNavigator">
					<div class="footerInfo">고객리뷰</div>
					<a href="">
						<img src="<%=ctxPath%>/images/homeMain/reviewIcon.png" />
					</a>
				</div>
				
			</div>
		</div>
	</div>

</body>

<script type="text/javascript">
function func_height(){
		var content_height= $("div#contents").height();
		$("div#leftSide").height(content_height);
	}
</script>

</html>
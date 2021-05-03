<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath= request.getContextPath();
%>

<style type="text/css">

	div.pdetail{
		border: solid 0px green;
		float: left;
		width: 450px;
		height: 510px;
		margin: 0px 0px 50px 100px;
	}
	
	div#primaryImg{
		border: solid 0px red;
		height: 350px;
		margin-bottom: 20px;
	}

	div.plusimg{
		border: solid 0px red;
		float: left;
		height: 130px;
		width: 150px;
	}

	div.pdetailTitle{
		border: solid 0px blue;
		float: left;
		height: 80px;
		width: 300px;
		margin-bottom: 20px;
		font-size: 25px;
		padding-top: 10px;
	}
	
	div.pdetailTitle img{
		border-radius: 50%;
	}
	
	table#pdetailInfoTable{
		border: solid 0px red;
		clear: both;
		margin-bottom: 20px;
	}
	
	table#pdetailInfoTable tr{
		border: solid 0px blue;
		line-height: 55px;
	}
	
	table#pdetailInfoTable th{
		width: 160px;
	}
	
	table#pdetailInfoTable td{
		border: solid 0px blue;
		width: 250px;
	}
	
	div.pdetailbt{
		border: solid 0px red;
		float: left;
		width: 130px;
		height: 60px;
		margin-top: 20px;
		margin-left: 20px;
		background-color: #bfbfbf;
		font-size: 18pt;
		font-weight: bold;
		text-align: center;
		padding-top: 13px;
	}
	
	div#pDescribeTitle{
		border-top: solid 0px #797c79;
		border-bottom: solid 1px #797c79;
		clear: both;
		margin-left: 100px;
		height: 50px;
		font-size: 13pt;
	}
	
	div#pDescribeTitle span{
		width: 140px;
		display: inline-block;
		height: 50px;
		padding-top: 15px;
		text-align: center;
	}
	
	div#pDescribeTitle span:hover{
		background-color: #bfc0bf;
		font-weight: bold;
	}
	
	div#pDescribe{
		border: solid 0px blue;
		margin: 20px 0px 0px 100px;
	}
	
	img.extraImgs{
		margin: 30px 40px 0px 0px;
	
	}
	
	div#rightSide{
		position: relative;
		left: 1000px;
	}

	div#goBack{
		width:120px; 
		height:50px; 
		background-color: #747472;
		color: #fff;
		padding-top: 15px;
		font-size: 15pt;
		margin-top:100px;
	}
</style>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">


	$(document).ready(function(){
		
		func_height();
		// 색상옵션에 따라 배송비 ajax로 넣어주기
		$("select#cOption").change(function(){
			
			$.ajax({
				url:"<%=ctxPath%>/product/deliveryOptionCheck.cc",
				type:"post",
				data:{"pnum":$(this).val()},
				dataType:"json",
				success:function(json){
					
					var html="";
					
					if(json.dOption==-1){ // 존재하지 않는 pnum
						html="<span>색상에 따라 상이</span>";
					}
					else if(json.dOption==0){ // 무료배송
						html="<span style='color:red; font-weight:bold;'>무료배송</span>";
					}
					else if(json.dOption==1){ // 유료배송
						html="<span>3,000 원</span>";
					}
					
					$("td#dOptionText").html(html);
					
				},
				error: function(request, status, error){
			           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			    }
			}); // end of $.ajax({--------------------------------
			
		}); // end of change event--------------------------------
		
		
		// === 스크롤 위치에 따라 오른쪽 사이드바 위치 옮겨주기 
		$(window).scroll(function(){
			
			var scrollTop= $(window).scrollTop();
			console.log(scrollTop);
			
			if(scrollTop<580){
				$("div#rightSide").hide();// 상품상세설명  부분만 goUp아이콘이 나오도록 hide() 처리
			}
			
			if(scrollTop>580){
				$("div#rightSide").show();
			}
			
			if(scrollTop>2800){
				return false; // footer 부분 침범하지 않도록 이벤트 종료
			}
			
			$("div#rightSide").css("top",scrollTop);	
			
		}); // end of scroll event--------------------
		
		$("div#rightSide").click(function(){
			window.scrollTo(0,0);
		});
		
		
		// 목록으로 돌아가기		
		var goBackURL= "${requestScope.goBackURL}";
		goBackURL= goBackURL.replace(/ /gi, "&")
	
		
		$("div#goBack").click(function(){
			location.href= "<%=ctxPath%>/"+goBackURL;
		})
		
		
		// 작은 이미지 클릭시 큰 이미지와 위치 변경
		$("div#pImg img").click(function(){
			
			var imgPath= $(this).prop('src');
			var bigImgPath= $("img#bigImg").prop('src');
			
			$("img#bigImg").prop('src',imgPath);
			$(this).prop('src',bigImgPath);
			
		});
		
		
		
		// home.cc에서 넘어온 경우 해당 spec 또는 doption에 해당하는 옵션 값 입력해주기
		
		
		
		

	}); // end of $(document).ready(function(){--------------------



</script>

<jsp:include page="../header.jsp" />
<jsp:include page="../productListLeftSide.jsp" />

<div id="contents" style="margin: 80px 0px;">
	<div style="margin-left:50px; width:50px; height:50px;" id="rightSide">
			<img src="<%=ctxPath%>/images/product/goUpIcon.png" width="50px" height="50px" />
	</div>
	<div class="pdetail" id="pImg" style="width: 500px;">
		<div id="primaryImg">
			<img src="<%=ctxPath%>/images/${onePInfo.pimage1}" id="bigImg" width="495px" height="350px" />
		</div>
		<div>
			<c:forEach var="primeFileName" items="${primePlusImgFile}" varStatus="status">
				<c:if test="${status.index < 3}">
					<c:if test="${status.index== 0}">
						<div class="plusimg">
							<img src="<%=ctxPath%>/images/${primeFileName}" width="145px" height="130px" />	
						</div>
					</c:if>
					<c:if test="${status.index > 0}">
						<div class="plusimg" style="margin-left: 24px;">
							<img src="<%=ctxPath%>/images/${primeFileName}" width="145px" height="130px" />	
						</div>
					</c:if>
				</c:if>
			</c:forEach>
		</div>
	</div>
	
	<div class="pdetail" id="pdetailInfo" style="margin-left: 50px; border:solid 2px #e3e3e3; padding: 40px 0px 0px 10px;">
		<div class="pdetailTitle" align="center" style="color:blue;">
			<div style="font-size:20px; margin-bottom:5px;">
				[${onePInfo.cname}]&nbsp;[${onePInfo.modelname}]
			</div>
			${onePInfo.productname}
		</div>
		<div class="pdetailTitle" style="width: 90px; margin-left: 20px;">
			<img src="<%=ctxPath%>/images/product/heartIcon.png" width="70x" height="70px;" />
		</div>
		<table id="pdetailInfoTable" style="margin: 10px 0px 0px 30px; ">
			<tr>
				<th>
					할인판매가
				</th>
				<td>
					${onePInfo.saleprice}원
				</td>
			</tr>
			<tr>
				<th>
					판매가
				</th>
				<td>
					${onePInfo.price}원&nbsp;&nbsp;<span>${onePInfo.salepercent}% OFF</span>
				</td>
			</tr>
			<tr>
				<th>
					색상 옵션
				</th>
				<td>
					<select id="cOption">
						<option value="">색상을 선택해 주세요</option>
						<c:forEach var="pDetailInfo" items="${onePDetailInfoList}" >
							<option value="${pDetailInfo.pnum}">${pDetailInfo.pcolor}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>
					배송방법
				</th>
				<td>
					택배
				</td>
			</tr>
			<tr>
				<th>
					배송비
				</th>
				<td id="dOptionText"> <%-- ajax로 값이 달라진다--%>
					색상에 따라 상이
				</td>
			</tr>
		</table>
		
		<div class="pdetailbt" style="margin-left: 0px;">바로구매</div>
		<div class="pdetailbt">장바구니</div>
		<div class="pdetailbt">관심상품</div>
	</div>

	<div id="pDescribeTitle">
		<span style="margin-left: 40px;">제품 설명</span>
		<span>구매 후기[개수]</span>
		<span>Q&A</span>
		<span>구매 가이드</span>
	</div>
	
	<div id="pDescribe" align="center">
		<div style="margin-top: 50px;">
			<img src="<%=ctxPath%>/images/homeMain/logo.png" width="300px" height="100px" />
		</div>
		<div>
			<div id="primaryImg" style="margin-top:30px; margin-bottom:30px;">
				<img src="<%=ctxPath%>/images/${onePInfo.pimage1}" width="300px" height="300px" />
			</div>
			<c:forEach var="primeFileName" items="${primePlusImgFile}" varStatus="status">
				<c:if test="${status.index < 3}">
					<c:if test="${status.index== 0}">
						<div  style="margin-top:30px; margin-bottom:30px;">
							<img src="<%=ctxPath%>/images/${primeFileName}" width="300px" height="300px" />	
						</div>
						<div style="font-size:20pt; color:red; border-bottom: solid 1px #797c79; width:300px; font-weight:bold; padding-bottom:10px;">
							${onePInfo.productname}
						</div>
						<div style="font-size:12pt; margin: 10px 0px 5px 0px;">모델명: ${onePInfo.modelname}</div>
						<div style="font-size:12pt">카테고리명: ${onePInfo.cname}</div>
					</c:if>
					<c:if test="${status.index > 0}">
						<div style="margin-top:30px;">
							<img src="<%=ctxPath%>/images/${primeFileName}" width="300px" height="300px" />	
						</div>
					</c:if>
				</c:if>
			</c:forEach>
		</div>
		<div style="border: solid 1px red; width: 500px; height: 70px; margin-top:30px;">
			제품설명칸
		</div>
		<c:forEach var="extraFileName" items="${extraPlusImgFile}" varStatus="status">
			<c:if test="${status.index < 3}">
				<c:if test="${status.index== 0}">
					<img src="<%=ctxPath%>/images/${extraFileName}" width="250px" height="250px" class="extraImgs"/>	
				</c:if>
				<c:if test="${status.index > 0}">
					<img src="<%=ctxPath%>/images/${extraFileName}" width="250px" height="250px" class="extraImgs"/>	
				</c:if>
			</c:if>
		</c:forEach>
		<div id="goBack">목록으로</div>
	</div>
</div>

<jsp:include page="../footer.jsp" />

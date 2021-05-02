<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath= request.getContextPath();
%>

<style type="text/css">

	div.pdetail{
		border: solid 1px green;
		float: left;
		width: 450px;
		height: 510px;
		margin: 0px 0px 50px 100px;
		
	}
	
	div#primaryImg{
		border: solid 1px red;
		height: 350px;
		margin-bottom: 20px;
	}

	div.plusimg{
		border: solid 1px red;
		float: left;
		height: 130px;
		width: 150px;
	}

	div.pdetailTitle{
		border: solid 1px blue;
		float: left;
		height: 80px;
		width: 330px;
		margin-bottom: 20px;
	}
	
	div.pdetailTitle img{
		border-radius: 50%;
	}
	
	table#pdetailInfoTable{
		border: solid 1px red;
		clear: both;
		margin-bottom: 20px;
	}
	
	table#pdetailInfoTable tr{
		border: solid 1px blue;
		line-height: 55px;
	}
	
	table#pdetailInfoTable th{
		width: 160px;
	}
	
	table#pdetailInfoTable td{
		border: solid 1px blue;
		width: 250px;
	}
	
	div.pdetailbt{
		border: solid 1px red;
		float: left;
		width: 120px;
		height: 50px;
		margin-left: 20px;
	}
	
	div#pDescribeTitle{
		border-top: solid 1px #797c79;
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
		border: solid 1px blue;
		margin: 20px 0px 0px 100px;
	}
</style>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

<%--
	$(document).ready(function(){
		
		// 색상옵션에 따라 배송비 ajax로 넣어주기
		$("select#cOption").change(function(){
			
			$.ajax({
				url:"<%=ctxPath%>/product/deliveryOptionCheck.cc",
				type:"post",
				data:{"pnum":$(this).val()},
				dataType:"json",
				success:function(json){
					
				},
				error: function(request, status, error){
			           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			    }
			}); // end of $.ajax({--------------------------------
			
		}); // end of change event--------------------------------
		
		
	}); // end of $(document).ready(function(){--------------------

--%>

</script>

<jsp:include page="../header.jsp" />
<jsp:include page="../productListLeftSide.jsp" />

<div id="contents" style="margin: 80px 0px;">

	<div class="pdetail" id="pImg" style="width: 500px;">
		<div id="primaryImg">
			<img src="<%=ctxPath%>/images/${onePInfo.pimage1}" width="495px" height="350px" />
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
	
	<div class="pdetail" id="pdetailInfo" style="margin-left: 50px;">
		<div class="pdetailTitle" align="center">
			[${onePInfo.cname}]&nbsp;[${onePInfo.modelname}]<br>
			${onePInfo.productname}
		</div>
		<div class="pdetailTitle" style="width: 90px; margin-left: 20px;">
			<img src="<%=ctxPath%>/images/product/heartIcon.png" width="90px" height="80px;" />
		</div>
		<table id="pdetailInfoTable">
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
				<td id="dOptionText">
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
	
	<div id="pDescribe">
		<div>맨위로 스크롤바 위치잡기</div>
		제품상세설명
	
	
	</div>


</div>

<jsp:include page="../footer.jsp" />

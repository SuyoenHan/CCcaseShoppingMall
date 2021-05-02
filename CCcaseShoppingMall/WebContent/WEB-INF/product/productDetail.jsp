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
</script>

<jsp:include page="../header.jsp" />
<jsp:include page="../productListLeftSide.jsp" />

<div id="contents" style="margin: 80px 0px;">

	<div class="pdetail" id="pImg" style="width: 500px;">
		<div id="primaryImg">대표이미지 사진</div>
		<div>
			<div class="plusimg">상품이지미1사진</div>
			<div class="plusimg" style="margin-left: 24px;">상품이지미2 사진</div>
			<div class="plusimg" style="margin-left: 24px;">상품이지미3 사진</div>
		</div>
	</div>
	
	<div class="pdetail" id="pdetailInfo" style="margin-left: 50px;">
		<div class="pdetailTitle">케이스명</div>
		<div class="pdetailTitle" style="width: 90px; margin-left: 20px;">관심상품담기 아이콘</div>
		<table id="pdetailInfoTable">
			<tr>
				<th>
					할인판매가
				</th>
				<td>
					할인판매가 가격
				</td>
			</tr>
			<tr>
				<th>
					판매가
				</th>
				<td>
					판매가격 <span>할인율</span>
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
				<td>
					배송가격/무료배송
				</td>
			</tr>
			<tr>
				<th>
					색상옵션
				</th>
				<td>
					색상드롭박스
				</td>
			</tr>
			<tr>
				<th>
					기종명
				</th>
				<td>
					기종드롭박스
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

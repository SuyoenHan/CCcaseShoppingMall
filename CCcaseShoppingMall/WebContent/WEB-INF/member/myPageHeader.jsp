<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	
	div#mypage{
		margin:120px 0px 0px 210px;
		background-color: #E0E0E0;
		width: 83%;
		font-size:20pt;
		height:130px;
		/* border: solid 1px blue; */
	}
	
	div#myInfo{
		padding-left:30px;
		margin-top:130px;
		border: solid 0px red;
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

</style>


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
					<td style=" font-size: 13pt; text-align: center; width:200px;">
						주문건수
					</td>
					<td style="font-size: 13pt;text-align: center;width:200px;">
						포인트 이미지 자리
					</td>
					<td style="font-size: 13pt;text-align: center;width:200px;">
						쿠폰 이미지 자리
					</td>
				</tr>
				<tr>
					<td style="font-size: 13pt;text-align: center;"> 0 건수 </td>
					<td style="font-size: 13pt;text-align: center;"><a>${sessionScope.loginuser.totalpoint}</a>point</td>
					<td style="font-size: 13pt;text-align: center;">1장</td>
				</tr>
			</table>
		</div>
	</div>
</div>

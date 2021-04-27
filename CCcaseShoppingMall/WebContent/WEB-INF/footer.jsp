<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
				<button type="button" class="footerNavigator" id="companyInfo">회사소개</button>
				<button type="button" class="footerNavigator" id="location">위치</button>
				<button type="button" class="footerNavigator" id="notice">공지사항</button>
				<button type="button" class="footerNavigator" id="q&a">상품문의</button>
				<button type="button" class="footerNavigator" id="orderDetail">주문조회</button>
				<button type="button" class="footerNavigator" id="review">고객리뷰</button>
			</div>
		</div>
	</div>

</body>

<script type="text/javascript">
	function func_height(){
		var content_height= $("div#contents").height();
		// header2.jsp의 하단에 표시된 div content의 height값
		
		$("div#leftSide").height(content_height);
		// header2.jsp의 div sideinfo 의 height 값으로 설정하기
	}
</script>
</html>
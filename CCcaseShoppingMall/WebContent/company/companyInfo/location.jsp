<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="../../css/companyInfo.css" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<jsp:include page="../../header.jsp" />
<jsp:include page="../../leftSide.jsp" /> 

<div id="contents">
	 <div id="locationPage">
		
		<div id="brandImage">
			<img src="/MyMVC/images/brandImg.png" />
		</div>
		
		<br>
		 
		 <div id="logoImage">
		 	<img src="/MyMVC/images/logoImg.png" />
		 </div>
	 
	 	<br><br>
	 	
	 	<div id="intro">
	 		<h3 style="color: #0099cc; font-weight: bolder;">CCcase STORE</h3>
	 			<span>CCcase의 첫번째 스토어를 소개합니다. <br>
	 						랜드마크 한국에 위치한 스토어에 방문해 최근 콜라보레이션을 둘러볼 수 있어요<br>
	 						나만의 커스텀 케이스 제작도 가능합니다.</span>
	 	</div>
	 	
	 	<br><br>
	 	
	 	<div id="location">
	 		<h5 style="color: #0099cc; font-weight: bolder;">위치</h5>
	 		<span>대한민국 서울특별시 마포구<br>
	 					Republic of Korea</span>
	 	</div>
	 
	 	<br><br>
	 	
	 	<div id="bizhours">
	 		<h5 style="color: #0099cc; font-weight: bolder;">운영시간</h5>
	 		<span>평일 오전 09:00 ~ 오후 5:50<br>
	 					점심 오후   1:00 ~ 오후 2:00<br>
	 					토 / 일 / 공휴일 휴무</span>
	 	</div>
	 
	 	<br><br>
	 	
	 	<div id="Q">
	 		<h5 style="color: #0099cc; font-weight: bolder;">문의</h5>
	 		<span>abcdefg@hijklmn.com</span>
	 	</div>
	 
	 	<br><br>
	 	
	 	<div>
	 		<input type="button" id="btnLearnmore" class="btn btn-success" value="Learn More" />
	 	</div>
		
		<br><br><br>
		
		<!-- * 카카오맵 - 지도퍼가기 -->
		<!-- 1. 지도 노드 -->
		<div id="daumRoughmapContainer1618727833081" class="root_daum_roughmap root_daum_roughmap_landing" style="margin: 0 auto;"></div>
		
		<!--
			2. 설치 스크립트
			* 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다.
		-->
		<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
		
		<!-- 3. 실행 스크립트 -->
		<script charset="UTF-8">
			new daum.roughmap.Lander({
				"timestamp" : "1618727833081",
				"key" : "25ept",
				"mapWidth" : "640",
				"mapHeight" : "360"
			}).render();
		</script>
	
		<br><br><br>
		 	
	 </div>
</div>

<jsp:include page="../../rightSide.jsp" />
<jsp:include page="../../footer.jsp" /> 

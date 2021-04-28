<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
   
<style type="text/css">
	div.companyInfocel{
		border:solid 0px red;
		width:60%;
		height:220px;
		padding:10px auto;
		text-align: center;
		margin:0px auto;
		margin-bottom: 30px;
		margin-top: 20px;
	}
	
	div#companyInfotext p{
		line-height: 30px;
		font-size: 12px;
	}	
	
	div#companyInfoImg > img{
		border:solid 0px gray; 
		width:100%;
		height: 300px;
	}
	
	div#companyInfoVideo{
		 width:490px;
	     height:300px;
		 margin: 0px auto;
	}
	
	div#hashTag >span{
		border:solid 0px gray;
		display:inline-block;
		height:30px;
		text-align:left;
		font-size:12px;
		font-weight: bold;
		line-height: 20px;
		color:#ff3385;
	}
	
	div#companyLocation {
		border:solid 0px gray;
		width:200px;
		height:180px;
		padding:10px;
		text-align: center;
		font-size:11px;
		margin-bottom: 100px;
		
	}
	
	div#companyLocation>span {
		font-weight: bold;
		color: #336699;
		font-size:12px;
	}
	
	#btnLearnmore {
		font-size: 15pt;
		font-weight: bold;
	}
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("input#btnLearnmore").bind('click',function(){
			location.href="<%=request.getContextPath()%>/company/location.cc";
		});
	});

</script>

<jsp:include page="../header.jsp" />

<div id="contents" style="clear: both;"> 
	
		<div id="companyInfoImg" class="companyInfocel" style="margin-top: 30px;">
			<img src="<%=request.getContextPath()%>/images/homeMain/flower.png" />
		</div>
		<br>
		<div  id="companyInfotext" class="companyInfocel" style="padding-top: 70px;">
			<h3>브랜드핵심소개글!!<br> (ex홍콩 랜드마크에서CASETiFY 팝업스토를만나보세요!)</h3>
			<span>
				<p>ex) CASETiFY 스튜디오를 방문해보세요!온라인으로만 접하던 CASETiFY를 랜드마크 팝업스토어에서 만날 수 있어요.커스텀 케이스로 나만의 스타일을 보여주세요. #ShowYourColors 
					CASETiFY 스튜디오에서는 15분만에 내가 원하는 대로 커스텀 케이스 주문제작이 가능하며, 전 세계 아티스트들과 협업한 다양한 디자인 케이스도 둘러볼 수 있습니다.
					CASETiFY co-lab의 가장 최근 콜라보레이션 CASETiFY & Pokémon 을
					전 세계에서 가장 빨리 접해보세요. CASETiFY 팝업스토어에서 독점 공개합니다!</p>
			</span>
		</div>
		
		<br><br>
		<div  id="hashTag" class="companyInfocel">
			<br><br><홍보 해시태그><br><br>
			<span>#ShowYourColors</span><br>
			<span>#CASETiFYHK</span><br>
			<span>#CASETiFYPokemon</span><br>
			<span>#CASETiFYxLandmark</span>
		</div>
		
		<div id="companyInfoVideo">
			<video width="490" height="300"  controls autoplay loop>   
			   <source src="video/The Simpsons.mp4" type='video/mp4;codec="avc.1.42e01e, mp4a.40.2"'></source>
			</video>
		</div>
		<br>
		
		<div class="companyInfocel" id="companyLocation" style="margin-bottom: 150px;">
			  <br><br><span>위치</span><br>
			    대한민국 서울특별시 마포구<br>
			  Republic of Korea<br><br>
						
			  <span>운영시간</span><br>
			    평일 오전 09:00 ~ 오후 5:50<br>
			    점심 오후   1:00 ~ 오후 2:00<br>
			    토 / 일 / 공휴일 휴무 <br><br>
			 
			 <span>문의</span><br>
			  abcdefg@hijklmn.com
		</div>

		<div align="center" style="margin-bottom: 150px;">
	 		<input type="button" id="btnLearnmore" class="btn btn-success" value="Learn More" />
	 	</div>
	
	
</div>

<jsp:include page="../footer.jsp" /> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   
<style type="text/css">
	div.companyInfocel{
		border:solid 0px red;
		height:220px;
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
		width:450px;
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
	
	button#btnLearnmore {
		font-size: 13pt;
		font-weight: bold;
		width: 150px;
		height: 50px;
		background-color: #e1e8ea;
		border: solid 1px #6d919c;
	}
	
	button#btnLearnmore:hover{
		background-color: #87a3ab;
		color: #fff;
		font-weight: bold;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("button#btnLearnmore").bind('click',function(){
			location.href="<%=request.getContextPath()%>/company/location.cc";
		});
	});

</script>

<jsp:include page="../header.jsp" />

<div id="contents" style="clear: both; border: solid 0px red; width:1200px; margin-left: 130px;"> 
	
		<div id="companyInfoImg" class="companyInfocel" style="margin-top: 60px;">
			<img src="<%=request.getContextPath()%>/images/companyInfo/companyInfo.jpg" />
		</div>
		<br>
		<div  id="companyInfotext" class="companyInfocel" style="padding-top: 60px;">
			<h2><span style="color:#000066; font-weight:bold;">CCcase</span> 쇼핑몰에 오신 걸 환영합니다!!<br><br></h2>
			<span>
				<p>CCcase만의 케이스를 둘러보세요.<br/>
				   CCcase는 우수한 품질의 제품만 판매하며, 당일출고를 원칙으로 합니다. 
				</p>
			</span>
		</div>
		
		<br><br>
		<div  id="hashTag" class="companyInfocel" style="margin-bottom:0px;">
			&lt;홍보 해시태그&gt;<br><br>
			<span>#ShowYourColors</span><br>
			<span>#CCcase</span>
		</div>
		
		<div id="companyInfoVideo" style="margin-top:-30px;">
		<video width="490" height="300" controls autoplay src="<%=request.getContextPath()%>/video/companyInfo.mp4" type='video/mp4;codec="avc.1.42e01e, mp4a.40.2"'></video>
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
			  CCcase@gmail.com
		</div>

		<div align="center" style="margin-bottom: 150px;">
	 		<button type="button" id="btnLearnmore">Learn More</button>
	 	</div>
	
	
</div>

<jsp:include page="../footer.jsp" /> 
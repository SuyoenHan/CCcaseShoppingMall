<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">

	div#leftContainer{
		position: relative;
	}
	
	div#leftContainer div{
		height: 40px;
		padding-top: 10px;
		border: none;
		background-color: #f0f4f5;
		cursor:pointer;
	}
	
	div#leftContainer div:hover{
		background-color: #b4c6cb;
		font-weight: bold;
		cursor:pointer;
	}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		
		
		// === 스크롤 위치에 따라 왼쪽 사이드바 위치 옮겨주기 
		$(window).scroll(function(){
			
			var scrollTop= $(window).scrollTop();
			//console.log(scrollTop);
			
			if(scrollTop>2500){
				return false; // footer 부분 침범하지 않도록 이벤트 종료
			}
			
			$("div#leftContainer").css("top",scrollTop);	
			
		}); // end of scroll event--------------------
		
		
		// 각 사이드바 메뉴 클릭 시 해당 스크롤 위치로 이동
		$("div#best").click(function(){
			window.scrollTo(0,500);
		}); 
		
		$("div#new").click(function(){
			window.scrollTo(0,1400);
		});
		
		$("div#free").click(function(){
			window.scrollTo(0,2400);
		});
		
	}); // end of $document.ready(function(){


</script>

    
<div id="leftSide">
	<div id="leftContainer">
		<div class="leftSection" id="best">Best 50</div>
		<div class="leftSection" id="new">신상 10% 할인</div>
		<div class="leftSection" id="free">무료배송 상품</div>
	</div>
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath= request.getContextPath();
%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">

	div.plContainer{
		border: solid 0px red;
		width: 190px;
	}


</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 
      
<div id="leftSide" style="border: solid 0px red;">

	<div class="container plContainer">  
	    <div id="myCarousel" class="carousel slide" data-ride="carousel">
		    <!-- Indicators -->
		    <ol class="carousel-indicators">
		    	<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
		    	<li data-target="#myCarousel" data-slide-to="1"></li>
		      	<li data-target="#myCarousel" data-slide-to="2"></li>
		    </ol>
		
		    <!-- Wrapper for slides -->
		    <div class="carousel-inner" style="width: 200px; height: 1500px; margin-left: -22px;">
			    <div class="item active">
			    	<img src="<%=ctxPath%>/images/product/pLeft1.png" style="width:210px; height: 1500px;">
			    </div>
			    <div class="item">
			        <img src="<%=ctxPath%>/images/product/pLeft2.png" style="width:210px; height: 1500px;">
			    </div>
		      	<div class="item">
		        	<img src="<%=ctxPath%>/images/product/pLeft3.png" style="width:210px; height: 1500px;">
		      	</div>
		    </div>
        </div>
	</div>
</div>
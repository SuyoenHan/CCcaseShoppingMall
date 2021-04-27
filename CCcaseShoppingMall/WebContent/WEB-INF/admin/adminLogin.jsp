<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
	
	div.container{
		border:solid 0px red;
		margin-top: 100px;
		margin-left: 500px;
		margin-bottom: 100px;
	}
	
	input#email, #password{
		width: 400px !important;
		height: 100px !important;
	}
	
	span#adminLogin{
		border: solid 1px black;
		width: 440px;
	}
	
</style>

<jsp:include page="../adminheader.jsp" /> 

<%-- bootstrap이용 --%>
<div id="contents">
	<div class="container">
	    <form>
    <div class="input-group">
      <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
      <input id="email" type="text" class="form-control" name="email" placeholder="Email">
    </div>
    <div class="input-group">
      <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
      <input id="password" type="password" class="form-control" name="password" placeholder="Password">
    </div>
    <span class="input-group-addon" id="adminLogin">로그인</span>
  </form>
	</div>
</div>

<jsp:include page="../footer.jsp" />
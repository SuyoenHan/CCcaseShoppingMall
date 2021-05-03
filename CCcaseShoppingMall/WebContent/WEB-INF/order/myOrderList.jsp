<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
    
<%
	String ctxPath = request.getContextPath();
%>



	<jsp:include page="../header.jsp" />
	<jsp:include page="../communityLeftSide.jsp" />    
    
    
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="<%=ctxPath%>/css/style.css" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>

<div id="contents">

	<div class="container">
	  <h2>주문내역 조회</h2>
	  <p>The .table-hover class enables a hover state on table rows:</p>            
	  <table class="table table-hover">
	    <thead>
	      <tr>
	        <th>상품정보</th>
	        <th>주문일자</th>
	        <th>주문번호</th>
	        <th>주문금액</th>
	        <th>주문수량</th>
	        <th>주문상태</th>
	      </tr>
	    </thead>
	    <tbody>
	      <tr>
	        <td><img src=""/></td>
	        <td colspan="2">해드폰케이스명-화이트</td>
	        <td >옵션: 아이폰7</td>
	        <td>주문일자</td>
	      </tr>
	      <tr>
	        <td>Mary</td>
	        <td>Moe</td>
	        <td>mary@example.com</td>
	      </tr>
	      <tr>
	        <td>July</td>
	        <td>Dooley</td>
	        <td>july@example.com</td>
	      </tr>
	    </tbody>
	  </table>
	</div>
</div>
</body>
</html>
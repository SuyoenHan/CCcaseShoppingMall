<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<style>

	div#contents ,table{
		color: #333;
		width:100%;
	}

	div#title{
		border:solid 1px gray;
		background-color: #ccc;
		width:100%;
		height:100px;
		text-align: left;
		font-size: 18pt;
	}

	
	table , tr ,td{
		border:solid 1px gray;
	}
	
	

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("button#faqwrite").click(function(){
			//버튼(글쓰기)를 클릭하면
			
			location.href="<%=ctxPath%>/faqnotice/faqwrite.cc"
			
		});//end of $("button#faqwrite").click(function(){}); ------------------
		
		
		// 특정 게시물을 클릭하면 내용물이 보여지도록 한다.
		$("tr.faqList").click(function(){
			// console.log($(this).html()); // ==>tr 나옴
			var faqno = $(this).children(".faqno").text(); 
			// alert(faqno); 
			
			
			//NO값을 받아와서 그 내용을 그대로 보여주도록함.(구현하기!!!)
			
		});
		
		
		
		
	});// end of $(document).ready(function(){})--------------

</script>


<link rel="stylesheet" href="<%=ctxPath%>/css/style.css" />
<jsp:include page="../header.jsp" />
<jsp:include page="../leftSide.jsp" />
<div id="contents">

	<form action ="<%=ctxPath %>board/faqList.cc"name="faqList" method="GET">
		<div id="title"> 
				커뮤니티
		</div>
			
			<h2> FAQ </h2>
			
			<table>
				<thead>
					<tr>
						<th>NO.</th>
						<th>제목</th>
						<th>등록일자</th>
						<th>조회수</th>
					</tr>
				</thead>
				
				<tbody>
					<tr class="faqList">
						<td class="faqno">ㄱ</td>
						<td>ㄴ</td>
						<td>ㄷ</td>
						<td>ㄹ</td>
					</tr>
					<tr class="faqDetail" calspan></tr>
				</tbody>
			
			</table>
			
			<button type="button" id="faqwrite" name="faqwrite" style="float:right; margin:20px 30px;">글쓰기</button>
			<!-- 페이징바 -->
			<div ></div>
	
	</form>
	
</div>


<jsp:include page="../footer.jsp" />




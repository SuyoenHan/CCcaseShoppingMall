<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<style>


	 tr.faqDetail {
	 	 overflow: visible;
	 	 border:solid 1px red;
	 	/*  display: none;  */
	 }

	div#contents ,table{
		color: #333;
		width:80%;
		
	}

	div#title{
		border:solid 1px gray;
		background-color: #ccc;
		width:80%;
		height:100px;
		text-align: left;
		font-size: 18pt;
	}

	
	table , tr ,td{
		border:solid 1px gray;
	}
	
	button.button{
	 width:80px;
	 height:50px;
	}
	
	thead th {
	
	background-color: #8c8c8c;
	}
	

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		func_height();//footer.jsp에 있음!
		
		$("button#faqwrite").click(function(){
			//버튼(글쓰기)를 클릭하면
			
			location.href="<%=ctxPath%>/board/faqwrite.cc"
			
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

	<form action ="<%=ctxPath %>board/faqList.cc" name="faqList" method="GET">
	
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
					<tr class="faqDetail">
						<td colspan="4"> 
							<table>
								<tr>
									<td>제목</td>
									<td colspan="2">제목명</td>
								<tr>
								<tr>
									<td>작성자</td>
									<td colspan="2">작성자명</td>
								<tr>
								<tr>
									<td>등록일</td>
									<td >최초등록일 </td>
									<td> 최근수정일</td>
								<tr>
								<tr>
									<td colspan="3">
										<span>글내용</span>
										<div>요기가 글내용 들어오는곳입니다잉
										auddlkakld
										asdjaslkdmsad
										asdnlaksdklasmd
										asdklsalkdsalkd
										asdkljaslkfjlkgklsdmf
										dskjfnjelknsd,mna
										faljsdhfowehonsdlvnwoehwenfjsnvinwjlenilsdhfiuweNFKJSDNFLHEIFNKJNF
										KAJSFIUWehfjnsdkfnieheiwnlsnkldjsnliuhlagjnlkㅏㅇ머ㅣㅏㅁ너아ㅣㄴ머아ㅣㅓㅁ나ㅣ러ㅏㅣㄴ어라ㅣ먼아ㅣ러마ㅣㄴ어리ㅏㅓ
										ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ
										ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ
										ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ
										</div>
								     </td>
								<tr>
							</table>
						
							<button type="button" class="button faqList" name="faqList" style="align:left;">목록</button>
							<button type="button" class="button faqEdit" name="faqEdit" style="align:right;">수정</button>
							<button type="button" class="button faqDel" name="faqDel" style="align:right;">삭제</button>
						
						</td>
						
						
						
					</tr>
					
					<tr class="faqSimple">
						<td class="faqno">ㄱ</td>
						<td>ㄴ</td>
						<td>ㄷ</td>
						<td>ㄹ</td>
					</tr>
					<tr class="faqDetail">
						<td colspan="4">
						미ㅏ어ㅣ만리ㅏ머니ㅏㅇ러ㅣㅏㅁㄴㅇ림ㄴ래ㅑ주대ㅜ미ㅓ루ㅑㅐ져루ㅏㅓ누라ㅣㅓㄴㅁ우리ㅏㅇㅁ누라ㅣㅜ
						미ㅏ어ㅣㅏㅁ너아ㅣㅁ너아ㅣㅁ너ㅣ암
						ㅁ니ㅏ어미나ㅓ아ㅣㄴ머아ㅣㅁ넝
						ㅁ나어미나ㅓ이ㅏㄴ머아ㅣㅁ너ㅏㅣ엄니ㅏㅓ이ㅏ
						</td>
					</tr>
					
				</tbody>
			
			</table>
			
			<button type="button" class="button faqwrite" name="faqwrite" style="float:right; margin:20px 300px;">글쓰기</button>
			<!-- 페이징바 -->
			<div ></div>
	
	</form>
	
</div>


<jsp:include page="../footer.jsp" />




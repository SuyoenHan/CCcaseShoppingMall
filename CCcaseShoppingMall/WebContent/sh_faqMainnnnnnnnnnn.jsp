<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

 tr.faqDetail {
 	 overflow: visible;
 	 border:solid 1px red;
 	/*  display: none;  */
 }

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
	
	button.button{
	 width:100px;
	 height:50px;
	}

</style>
</head>
<body>

<form action ="/board/faqList.cc"name="faqList" method="GET">
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
			
			<button type="button" class="button faqwrite" name="faqwrite" style="float:right; margin:20px 30px;">글쓰기</button>
			<!-- 페이징바 -->
			<div ></div>
	
	</form>

</body>
</html>
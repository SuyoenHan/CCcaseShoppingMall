<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>
    
<link rel="stylesheet" href="<%=ctxPath%>/css/style.css" />
<jsp:include page="../header.jsp" />
<jsp:include page="../leftSide.jsp" />
<div id="contents">

<table>
								<tr>
									<td>제목</td>
									<td ><input type="text" id="faqboardName" name="faqboardName" /> </td>
								<tr>
								<tr>
									<td>작성자(default)</td>
									<td ><input type="text" id="faqwriter" name="faqwriter" />작성자명(default)</td>
								<tr>
								<tr>
									<td>등록일(default)</td>
									<td><input type="text" id="faqwriteday" name="faqwriteday" /></td>
								<tr>
								<tr>
									<td colspan="2">
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


</div>





<jsp:include page="../footer.jsp" />    
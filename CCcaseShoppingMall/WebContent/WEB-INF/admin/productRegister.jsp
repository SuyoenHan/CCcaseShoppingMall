<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../adminheader.jsp" />
<jsp:include page="../adminleftSide.jsp" />

<style>
	
	div#leftSide {
		height: 850px;
	}
	
	div#contents {
		border:solid 1px red;
		width: 1000px;
		font-size: 15pt;
	}
	
	div#menuname{
		padding-left: 40px;
	}
	
	div#proRegister{
		font-size: 10pt;
		line-height: 40px;
	}
	
	label.registerInfo{
		display: inline-block;
		width: 400px;
		padding-left: 20px;
	}
	
	textarea#proname{
		margin-top: 10px;
		padding-top: 10px;
	}
	
	button.proButton{
		width: 100px;
		
	}
	
	div#buttons{
		margin-left: 700px;
		padding-top: 50px;
	}
	
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 

<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.css" />
<script type="text/javascript">
	
	$(document).ready(function(){
			
		// 로그인버튼을 클릭했을경우
		$("button#register").click(function(){
			
			var loginflag = false;
				
			// 필수입력사항 검사(input태그,select태그)
			$(".pilsu").each(function(){ 
				
				if($(this).val().trim()=="" ||$(this).val().trim()=="선택하세요"){
					alert("필수입력사항은 모두 입력해주세요.");
					loginflag = true;
					return false;
				}
				
			});
			
			if(!loginflag){
				
				var frm = document.regitserFrm;
				frm.submit();
			}
			

		});// end of $("button#register").click(function(){
		
	});
	
	
</script>

<div id="contents">
	
	<div id="menuname">
		<h2>상품등록<span style="font-size:15px;">&nbsp;(필수입력사항은 꼭 입력해주세요)</span></h2>
		
	</div>
	 
	<form name="regitserFrm" action="<%= ctxPath%>/admin/productRegister.cc" method="POST" enctype="multipart/form-data">
		<div id="proRegister">
					
			<div id="info1"> 
				<label class="registerInfo" for="specNo">1. 스펙번호 </label>
				<select id="specNo" name="fk_snum">
					<option value="">선택하세요</option>
					<c:forEach var="map" items="${requestScope.specList}">
						<option value="${map.snum}">${map.sname}</option>
					</c:forEach>	
				</select>
			</div>
		
			<div id="info2"> 
				<label class="registerInfo" for="cname">2. 카테고리명 <span style="color:red; font-size:10pt;">(필수)</span></label>
				<select id="cname" name="fk_cnum" class="pilsu">
					<option value="null">선택하세요</option>
					<c:forEach var="cList" items="${requestScope.categoryList}">
						<option value="${cList.cnum}">${cList.cname}</option>
					</c:forEach>
				</select>
			</div>
			
			<div id="info3">
				<label class="registerInfo" for="mname">3. 회사명 <span style="color:red; font-size:10pt;">(필수)</span></label>
				<select id="mname" name="fk_mnum" class="pilsu">
					<option value="">선택하세요</option>
					<c:forEach var="coList" items="${requestScope.companyList}">
						<option value="${coList.mnum}">${coList.mname}</option>
					</c:forEach>
					
				</select>
			</div>
			
			<div id="info4"> 
				<label class="registerInfo" for="productname">4. 제품명 <span style="color:red; font-size:10pt;">(필수)</span></label>
				<input type="text" name="productname" class="pilsu" id="productname" placeholder="ex) 냥냥케이스" /> 
			</div>
			
			<div id="info5"> 
				<label class="registerInfo" for="modelname">5. 기종명 <span style="color:red; font-size:10pt;">(필수)</span></label>
				<input type="text" name="modelname" class="pilsu" id="modelname" placeholder="ex) 아이폰12pro" /> 
			</div>
			
			<div id="info6"> 
				<label class="registerInfo" for="pcolor">6. 색상 <span style="color:red; font-size:10pt;">(필수)</span></label>
				<input type="text" name="pcolor" class="pilsu" id="pcolor" placeholder="ex) 빨강,검빨" /> 
			</div>
			
			<div id="info7"> 
				<label class="registerInfo" for="price">7. 제품정가</label>
				<input type="text" name="price" id="price" placeholder=",를 제외하고 입력해주세요" /> 
			</div>
			
			<div id="info8"> 
				<label class="registerInfo" for="salepercent">8. 할인율(%)</label>
				<input type="text" name="salepercent" id="salepercent" placeholder="수치만 입력해주세요" /> <span style="font-size:12pt">%</span> 
			</div>
			
			<div id="info9"> 
				<label class="registerInfo" for="pinputdate">9. 제품입고일자</label>
				<input type="date" name="pinputdate" id="pinputdate" />
			</div>
			
			<div id="info10"> 
				<label class="registerInfo" for="doption">10. 배송조건<span style="color:red; font-size:10pt;">(필수)</span></label>
				<select id="doption" name= "doption" class="pilsu">
					<option value="">선택하세요</option>
					<option value="0">무료</option>
					<option value="1">일반</option>
				</select> 
			</div>
			
			<div id="info11"> 
				<label class="registerInfo" for="pqty">11. 재고량</label>
				<input type="number" name="pqty" id="pqty" min="0" value="1" step="1" style="width:50px; height:30px;" /> 
			</div>
			
			<div id="info12" style="border:solid 1px red;"> 
				<label class="registerInfo" for="plusimage1" style="border:solid 1px green;">12. 대표이미지파일명<span style="color:red; font-size:10pt;">(필수)</span></label>
				<input type="file" name="pimage1" id="pimage1" class="pilsu" style="border:solid 1px blue;" /> 
			</div>
			
			<div id="info13" style="border:solid 1px red;"> 
				<label class="registerInfo" for="imgPlus1">13. 추가이미지1<span style="color:red; font-size:10pt;">(필수)</span></label>
				<input type="file" name="imgPlus1" id="imgPlus1" class="pilsu" /> 
			</div>
			
			
			<div id="info14"> 
				<label class="registerInfo" for="pcontent">14. 제품설명<br><br></label>
				<textarea name="pcontent" id="pcontent" rows="5" cols="25" placeholder="간단히 설명하세요" maxlength="100"></textarea>
			</div>
			
		</div>
		
		<div id="buttons">
			<button type="button" id="register" class="proButton">등록</button>
			<button type="reset" id="cancel" class="proButton">취소</button>
		</div>
	</form>
</div>


<jsp:include page="../footer.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../adminheader.jsp" />
<jsp:include page="../adminleftSide.jsp" />

<style>
	
	label.Infoname {
		width: 300px;
		height: 50px;
		margin: 0 auto;
		padding-top: 14px;
		font-size: 12pt;
		border: solid 0px red;
	}
	
	h2 {
		margin-left: 30px;
	}
	
	div#buttons{
		border: solid 0px red;
		margin-left: 500px;
		margin-top : 40px;
		width: 400px;
		
	}
	
	td#info15{
		width: 500px;
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
		
		
		// 가격 입력시 숫자만 입력했는지 확인
		$("input#price").blur(function(){
			
			var price = $(this).val();
			var regExp = /^[1-9][0-9]{0,5}$/;
			// console.log(typeof(Number(percent)));
			
			if(!regExp.test(price)){
				alert("가격을 올바르게 입력해주세요!");
				$(this).val(Number(1));
				$(this).focus();
				return;
			}
			
		})	// end of $("input#salepercent").blur(function(){	

			
			
		// 할인율 입력시 0.1~1 사이의 숫자를 입력했는지 확인
		$("input#salepercent").blur(function(){
			
			var percent = $(this).val();
			var regExp = /^[0-9][.][0-9]$/;
			// console.log(typeof(Number(percent)));
			
			if(Number(percent)<0 || Number(percent)>1){
				alert("할인율은 0.0부터 1.0사이까지만 가능합니다.")
				$(this).val(0.0);
				$(this).focus();
				return;
			}
			
		})	// end of $("input#salepercent").blur(function(){
		
		
	});
	
	
</script>

<div id="contents">
	
	<div id="proregister">
		<h2>상품등록<span style="font-size:15px; text-decoration: underline; margin-left:5px;">&nbsp;(** 필수입력사항은 꼭 입력해주세요 **)</span></h2>	
	</div>
	
	<form name="regitserFrm" action="<%= ctxPath%>/admin/productRegister.cc" method="POST" enctype="multipart/form-data">
		<div id="container">
			<table>
				<tbody>
					<tr> 
						<td id="info1"><label class="Infoname" for="fk_snum">1. 제품스펙</label></td>
						<td>
							<select id="fk_snum" name="fk_snum">
								<option value="">선택하세요</option>
								<c:forEach var="map" items="${requestScope.specList}">
									<option value="${map.snum}">${map.sname}</option>
								</c:forEach>	
							</select> 
						</td>				
					</tr>
					<tr> 
						<td id="info2"><label class="Infoname" for="fk_cnum">2. 카테고리명 <span style="color:red; font-size:10pt;">(필수)</span></label></td>
						<td> 
							<select id="fk_cnum" name="fk_cnum" class="pilsu">
								<option value="-1">선택하세요</option>
								<c:forEach var="cList" items="${requestScope.categoryList}">
									<option value="${cList.cnum}">${cList.cname}</option>
								</c:forEach>
							</select>
						</td>				
					</tr>
					<tr> 
						<td id="info3"><label class="Infoname" for="fk_mnum">3. 회사명 <span style="color:red; font-size:10pt;">(필수)</span></label></td>
						<td>
							<select id="fk_mnum" name="fk_mnum" class="pilsu">
								<option value="">선택하세요</option>
								<c:forEach var="coList" items="${requestScope.companyList}">
									<option value="${coList.mnum}">${coList.mname}</option>
								</c:forEach>
							</select>
						</td>				
					</tr>												
					<tr> 
						<td id="info4"><label class="Infoname" for="productname">4. 제품명 <span style="color:red; font-size:10pt;">(필수)</span></label></td>
						<td><input type="text" name="productname" class="pilsu" id="productname" placeholder="ex) 냥냥케이스" /></td>				
					</tr>
					<tr> 
						<td id="info5"><label class="Infoname" for="modelname">5. 기종명 <span style="color:red; font-size:10pt;">(필수)</span></label></td>
						<td>
							<select name="modelname" class="pilsu" id="modelname">
								<option value="">선택하세요</option>
								<c:forEach var="gijong" items="${requestScope.gijongList}">
									<option value="${gijong}">${gijong}</option>
								</c:forEach>
							</select>
						</td>				
					</tr>
					<tr> 
						<td id="info6"><label class="Infoname" for="pcolor">6. 색상 <span style="color:red; font-size:10pt;">(필수)</span></label></td>
						<td>
							<select name="pcolor" class="pilsu" id="pcolor">
								<option value="">선택하세요</option>
								<c:forEach var="pcolor" items="${requestScope.colorList}">
									<option value="${pcolor}">${pcolor}</option>
								</c:forEach>
							</select>
						</td>				
					</tr>
					<tr> 
						<td id="info7"><label class="Infoname" for="price">7. 제품정가</label></td>
						<td><input type="number" name="price" id="price" value="1"/>원</td>				
					</tr>
					<tr> 
						<td id="info8"><label class="Infoname" for="salepercent">8. 할인율<span style="font-size:10pt">(0.0 ~ 1.0만 가능합니다.)</span></label></td>
						<td><input type="number" name="salepercent" id="salepercent" min="0.0" max="1.0" value="0.0" step="0.1" /></td>				
					</tr>
					<tr> 
						<td id="info9"><label class="Infoname" for="pinputdate">9. 제품입고일자</label></td>
						<td><input type="date" name="pinputdate" id="pinputdate" /></td>				
					</tr>
					<tr> 
						<td id="info10"><label class="Infoname" for="doption">10. 배송조건<span style="color:red; font-size:10pt;">(필수)</span></label></td>
						<td>
						<select id="doption" name= "doption" class="pilsu">
							<option value="">선택하세요</option>
							<option value="0">무료</option>
							<option value="1">일반</option>
						</select>
						</td>				
					</tr>
					<tr> 
						<td id="info11"><label class="Infoname" for="pqty">11. 재고량</label></td>
						<td><input type="number" name="pqty" id="pqty" min="0" value="1" step="1" style="width:50px; height:30px;" /></td>				
					</tr>
					<tr> 
						<td id="info12"><label class="Infoname" for="pimage1">12. 대표이미지파일명<span style="color:red; font-size:10pt;">(필수)</span></label></td>
						<td><input type="file" name="pimage1" id="pimage1" class="pilsu" /></td>				
					</tr>
					<tr> 
						<td id="info13"><label class="Infoname" for="imgPlus1">13. 추가이미지1<span style="color:red; font-size:10pt;">(필수)</span></label></td>
						<td><input type="file" name="imgPlus1" id="imgPlus1" class="pilsu" /></td>
						<td style="border:solid 1px red;"><button>+</button><button>-</button></td>			
					</tr>
					<tr> 
						<td id="info14"><label class="Infoname" for="pcontent">14. 제품설명<br><br></label></td>
						<td colspan="2"><textarea name="pcontent" id="pcontent" rows="5" cols="40" placeholder="간단히 설명하세요" maxlength="100"></textarea></td>				
					</tr>																										
				</tbody>
			</table>
			
			<div id="buttons">
				<button type="button" id="register" class="proButton">등록</button>
				<button type="reset" id="cancel" class="proButton">취소</button>
			</div>
		</div>
	</form>	
		 
</div>
<jsp:include page="../footer.jsp" />
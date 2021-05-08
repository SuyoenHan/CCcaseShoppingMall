<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="../adminheader.jsp" />

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
		font-weight: bolder !important;
	}
	
	div#buttons{
		border: solid 0px red;
		margin-left: 600px;
		margin-top : 40px;
		width: 400px;
		
	}
	
	td.Infoname {
		
		width: 250px !important;
		height: 70px;
		padding-left: 30px;
		padding-top: 14px;
		font-size: 12pt;
		background-color: #C5D7DD;
		
	}
	
	td.Info{
	
		padding-left: 80px;
	}
	
	td {
		border-bottom: solid 1px black;
	}
	
	td#info15{
		width: 500px;
	}
	
	div#proregister{
		margin-bottom: 70px;
		margin-left: 30px;
		margin-top: 30px;
		
	}
	
	table {
		margin-top : -20px;
		margin-left: 50px;
	}
	
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 

<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.css" />
<script type="text/javascript">
	
	$(document).ready(function(){
		
		// leftside랑 길이맞추기
		func_height();
		
		// 제품등록 화면 페이지로 이동시, 추가등록 화면은 숨기기
		$("div#register2").hide();
		
		// 상품관리에서 추가정보등록시, 기존에 입력했던 정보(productid가 같은것)가져오기
		if("0"!="${requestScope.mapSize}"){
			
			var productid = "${requestScope.productid}";
			var productname = "${requestScope.productname}";
			var modelname = "${requestScope.modelname}";
			var pimage1 = "${requestScope.pimage1}";
			var price = Number("${requestScope.price}");
			var salepercent = Number("${requestScope.salepercent}");
			var fk_cnum = "${requestScope.fk_cnum}";
			var fk_mnum = "${requestScope.fk_mnum}";
			
			
			$("input#productname").val(productname);
			

			$("select#fk_mnum").val(fk_mnum);
			
			$("select#modelname").val(modelname);
			
			
			$("select#fk_cnum").val(fk_cnum);
	
			$("input#price").val(price);

			$("input#salepercent").val(salepercent);
			
			$("input#productid").val(productid);

			
		}
		
		
		
		
		
		// 상세정보등록하기 버튼 클릭 시
		$("button#goregister2").click(function(){
			
			var flag = false;
			
			// 필수입력사항 검사(input태그,select태그)
			$(".pilsu1").each(function(){ 
				
				if($(this).val().trim()=="" ||$(this).val().trim()=="선택하세요"){
					alert("필수입력사항은 모두 입력해주세요.");
					flag = true;
					return false;
				}
				
			});
			
			if(!flag){
				$("div#register1").hide();
				$("div#register2").show();
				
				
				var mname = $("select#fk_mnum option:selected").text();
				var modelname = $("select#modelname option:selected").text();
				var productname = $("input#productname").val();
				$("input#pname").val(mname+"-"+modelname+"-"+productname);
			
			}
			
		}); // end of $("button#goregister2").click(function(){
		
		
		// 제품등록하기로 다시가기
		$("button#goregister1").click(function(){ 
			
			$("input#productname").text("우우우");
			
			$("div#register1").show();
			$("div#register2").hide();
			
		}); // end of $("button#goregister1").click(function(){

		
		
		// 최종 등록버튼을 클릭했을경우
		$("button#finalRegister").click(function(){
			
			var Registerflag = false;
				
			// 필수입력사항 검사(input태그,select태그)
			$(".pilsu2").each(function(){ 
				
				if($(this).val().trim()=="" ||$(this).val().trim()=="선택하세요"){
					alert("필수입력사항은 모두 입력해주세요.");
					Registerflag = true;
					return false;
				}
				
			});
			
			if(!Registerflag){
				
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
	
	<div id="registerall">
		<form name="regitserFrm" action="<%= ctxPath%>/admin/productRegister.cc" method="POST" enctype="multipart/form-data">
			<div id="register1">
				<div id="proregister">
					<h2>상품등록<span style="font-size:15px; text-decoration: underline; margin-left:5px;">&nbsp;(** 필수입력사항은 꼭 입력해주세요 **)</span></h2>	
				</div>
				<table>
					<tbody>
						<tr> 
							<td id="info1" class="Infoname"><label for="productname">1. 제품명 <span style="color:red; font-size:10pt;">(필수)</span></label></td>
							<td class="Info"><input type="text" name="productname" class="pilsu1" id="productname" placeholder="ex) 냥냥케이스" /></td>				
						</tr>
						<tr> 
							<td id="info2" class="Infoname"><label for="fk_mnum">2. 회사명 <span style="color:red; font-size:10pt;">(필수)</span></label></td>
							<td class="Info">
								<select id="fk_mnum" name="fk_mnum" class="pilsu1" >
									<option value="">선택하세요</option>
									<c:forEach var="coList" items="${requestScope.companyList}">
										<option value="${coList.mnum}">${coList.mname}</option>
									</c:forEach>
								</select>
							</td>				
						</tr>
						<tr> 
							<td id="info3" class="Infoname"><label for="modelname">3. 기종명 <span style="color:red; font-size:10pt;">(필수)</span></label></td>
							<td class="Info">
								<select name="modelname" class="pilsu1" id="modelname">
									<option value="">선택하세요</option>
									<c:forEach var="gijong" items="${requestScope.gijongList}">
										<option value="${gijong}">${gijong}</option>
									</c:forEach>
								</select>
							</td>				
						</tr>		
						<tr> 
							<td id="info4" class="Infoname"><label for="fk_cnum">4. 카테고리명 <span style="color:red; font-size:10pt;">(필수)</span></label></td>
							<td class="Info"> 
								<select id="fk_cnum" name="fk_cnum" class="pilsu1">
									<option value="-1">선택하세요</option>
									<c:forEach var="cList" items="${requestScope.categoryList}">
										<option value="${cList.cnum}">${cList.cname}</option>
									</c:forEach>
								</select>
							</td>				
						</tr>										
						<tr> 
							<td id="info5" class="Infoname"><label for="price">5. 제품정가</label></td>
							<td class="Info"><input type="number" name="price" id="price" value="1"/>원</td>				
						</tr>
						<tr> 
							<td id="info6" class="Infoname"><label for="salepercent">6. 할인율<span style="font-size:10pt">(0.0 ~ 1.0만 가능합니다.)</span></label></td>
							<td class="Info"><input type="number" name="salepercent" id="salepercent" min="0.0" max="1.0" value="0.0" step="0.1" /></td>				
						</tr>
						<tr> 
							<td id="info7" label class="Infoname"><label class="Infoname" for="pimage1">7. 대표이미지파일명</label></td>
							<td class="Info"><input type="file" name="pimage1" id="pimage1" /></td>				
						</tr>																									
					</tbody>
				</table>
				<br>
				<div style="color:red; margin-left:30px;"> * 상품 상세정보까지 입력하셔야 성공적으로 상품이 최종 등록됩니다 </div>
				
				<div id="buttons">
					<button type="button" id="goregister2" class="proButton">상품상세정보 등록하기</button>
					<button type="reset" id="cancel" class="proButton">취소</button>
				</div>
			</div>
			
			<div id="register2">
				<div id="proregister">
					<h2>추가 상품등록<span style="font-size:15px; text-decoration: underline; margin-left:5px;">&nbsp;(** 필수입력사항은 꼭 입력해주세요 **)</span></h2>	
				</div>
				
				<input type="hidden" id="productid" name="productid" value="x" />
				<table>
					<tbody>
						<tr> <%-- 제품상세명 : 회사명(mname) - 기종명(modelname) - productname(제품명)   --%>
							<td id="info8" class="Infoname"><label for="pname">1. 제품상세명</label></td>
							<td colspan="2" class="Info"><input type="text" name="pname" id="pname" readonly="readonly" style="width:300px"/></td>				
						</tr>	
						<tr> 
							<td id="info9" class="Infoname"><label for="pcolor">2. 색상 <span style="color:red; font-size:10pt;">(필수)</span></label></td>
							<td class="Info">
								<select name="pcolor" class="pilsu2" id="pcolor">
									<option value="">선택하세요</option>
									<c:forEach var="pcolor" items="${requestScope.colorList}">
										<option value="${pcolor}">${pcolor}</option>
									</c:forEach>
								</select>
							</td>				
						</tr>
						<tr> 
							<td id="info10" class="Infoname"><label for="pqty">3. 입고량</label></td>
							<td class="Info"><input type="number" name="pqty" id="pqty" min="0" value="1" step="1" style="width:50px; height:30px;" /></td>				
						</tr>
						<tr> 
							<td id="info11" class="Infoname"><label for="fk_snum">4. 제품스펙</label></td>
							<td class="Info">
								<select id="fk_snum" name="fk_snum">
									<option value="-1">선택하세요</option>
									<c:forEach var="map" items="${requestScope.specList}">
										<option value="${map.snum}">${map.sname}</option>
									</c:forEach>	
								</select> 
							</td>				
						</tr>
						<tr> 
							<td id="info12" class="Infoname"><label for="pinputdate">5. 제품입고일자</label></td>
							<td class="Info"><input type="date" name="pinputdate" id="pinputdate" /></td>				
						</tr>
						<tr> 
							<td id="info13" class="Infoname"><label for="doption">6. 배송조건<span style="color:red; font-size:10pt;">(필수)</span></label></td>
							<td class="Info">
							<select id="doption" name= "doption" class="pilsu2">
								<option value="">선택하세요</option>
								<option value="0">무료</option>
								<option value="1">일반</option>
							</select>
							</td>				
						</tr>
						<tr> 
							<td id="info14" class="Infoname"><label for="pcontent">7. 제품설명<br><br></label></td>
							<td colspan="2" class="Info"><textarea name="pcontent" id="pcontent" rows="4" cols="40" placeholder="간단히 설명하세요" maxlength="100"></textarea></td>				
						</tr>
						<tr> 
							<td id="info15" class="Infoname"><label for="imgPlus1">8. 추가이미지1<span style="color:red; font-size:10pt;">(필수)</span></label></td>
							<td class="Info"><input type="file" name="imgPlus1" id="imgPlus1" class="pilsu2" /></td>		
						</tr>
						<tr> 
							<td id="info16" class="Infoname"><label for="imgPlus2">9. 추가이미지2<span style="font-size:10pt;">(선택)</span></label></td>
							<td class="Info"><input type="file" name="imgPlus2" id="imgPlus2" /></td>		
						</tr>
						<tr> 
							<td id="info17" class="Infoname"><label for="imgPlus3">10. 추가이미지3<span style="font-size:10pt;">(선택)</span></label></td>
							<td class="Info"><input type="file" name="imgPlus3" id="imgPlus3" /></td>		
						</tr>	
					</tbody>
				</table>
				
				<div id="buttons">
					<button type="reset" id="goregister1" class="proButton">제품등록으로 다시가기</button>
					<button type="button" id="finalRegister" class="proButton">최종 등록하기</button>
				</div>
				
			</div>	
		</form>	
	</div>
</div>
<jsp:include page="../footer.jsp" />
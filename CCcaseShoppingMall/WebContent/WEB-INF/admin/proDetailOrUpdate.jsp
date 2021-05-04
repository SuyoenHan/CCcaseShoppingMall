<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<% String ctxPath=request.getContextPath(); %>
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
		margin-left: 600px;
		margin-top : 40px;
		width: 400px;
		
	}
	
	td#info15{
		width: 500px;
	}
	
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script> 
	
	$(document).ready(function(){
		
		
		if("0"!="${requestScope.mapSize}" ){
			// 페이지가 로딩될때 가져온 값들을 input박스에 자동으로 기입해주겠다.(image태그는 불가)
			var productid = "${requestScope.productid}";
			var pnum = "${requestScope.pnum}";
			var productname = "${requestScope.productname}";
			var mnum = Number("${requestScope.mnum}");
			var modelname = "${requestScope.modelname}";
			var cnum = Number("${requestScope.cnum}");
			var price = Number("${requestScope.price}");
			var salepercent = Number("${requestScope.salepercent}");
			var pname = "${requestScope.pname}";
			var pcolor = "${requestScope.pcolor}";
			var pqty = Number("${requestScope.pqty}");
			var snum = Number("${requestScope.snum}");
			
			
			
			// DB에서 가져올때 "2021-05-05 00:00:00"이렇게 가져와서 아래와 같이 substr작업을 해야한다.
			// console.log(pinputdate); //"2021-05-05 00:00:00"
			var pinputdate = "${requestScope.pinputdate}";
			pinputdate = pinputdate.substr(0,10);
	
			
			var doption = Number("${requestScope.doption}");
			var pcontent = "${requestScope.pcontent}";
			var imgno = "${requestScope.imgno}";
			
			$("input#productname").val(productname);
			/*
			$("select#fk_mnum option:selected").each(function(){

			    if($(this).val()==mnum){

			      $(this).attr("selected","selected"); // attr적용안될경우 prop으로 
					break;
			   }
			}   
			*/    
		    $("select#fk_mnum").val(mnum);
			$("select#modelname").val(modelname);
			$("select#fk_cnum").val(cnum);
			$("input#price").val(price);
			$("input#salepercent").val(salepercent);
			$("input#pname").val(pname);
			$("select#pcolor").val(pcolor);
			$("input#pqty").val(pqty);
			$("input#pinputdate").val(pinputdate);
			$("select#fk_snum").val(snum);
			$("select#doption").val(doption);
			$("textarea#pcontent").val(pcontent);
			// update를 위해 hidden값 3개에도 넣어준다.
			$("input#productid").val(productid);
			$("input#pnum").val(pnum);
			$("input#imgno").val(imgno);
			
		}
		
		
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
		

		// 최종 등록버튼을 클릭했을경우
		$("button#goUpdate").click(function(){
			
			var Registerflag = false;
				
			// 필수입력사항 검사(input태그,select태그)
			$(".pilsu").each(function(){ 
				
				if($(this).val().trim()=="" ||$(this).val().trim()=="선택하세요"){
					alert("필수입력사항은 모두 입력해주세요.");
					Registerflag = true;
					return false;
				}
				
			});
			
			if(!Registerflag){
				
				var frm = document.updateFrm;
				frm.submit();
			}
			

		});// end of $("button#goUpdate").click(function(){
		
		
		
		
	}); // end of $(document).ready(function(){
	
</script>

     
<div id="contents">
	<div id="container">
		<form name="updateFrm" action="<%= ctxPath%>/admin/prodetailOrUpdate.cc" method="POST" enctype="multipart/form-data">
			<div id="registerall">
				<div id="proregister">
					<h2>상품수정하기<span style="font-size:15px; text-decoration: underline; margin-left:5px;">&nbsp;(** 필수입력사항은 꼭 입력해주세요 **)</span></h2>	
				</div>
				<table>
					<tbody>
						<tr> 
							<td id="info1"><label class="Infoname" for="productname">1. 제품명 <span style="color:red; font-size:10pt;">(필수)</span></label></td>
							<td><input type="text" name="productname" class="pilsu" id="productname" placeholder="ex) 냥냥케이스" /></td>				
						</tr>
						<tr> 
							<td id="info2"><label class="Infoname" for="fk_mnum">2. 회사명 <span style="color:red; font-size:10pt;">(필수)</span></label></td>
							<td>
								<select id="fk_mnum" name="fk_mnum" class="pilsu" >
									<option value="">선택하세요</option>
									<c:forEach var="coList" items="${requestScope.companyList}">
										<option value="${coList.mnum}">${coList.mname}</option>
									</c:forEach>
								</select>
							</td>				
						</tr>
						<tr> 
							<td id="info3"><label class="Infoname" for="modelname">3. 기종명 <span style="color:red; font-size:10pt;">(필수)</span></label></td>
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
							<td id="info4"><label class="Infoname" for="fk_cnum">4. 카테고리명 <span style="color:red; font-size:10pt;">(필수)</span></label></td>
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
							<td id="info5"><label class="Infoname" for="price">5. 제품정가</label></td>
							<td><input type="number" name="price" id="price" value="1"/>원</td>				
						</tr>
						<tr> 
							<td id="info6"><label class="Infoname" for="salepercent">6. 할인율<span style="font-size:10pt">(0.0 ~ 1.0만 가능합니다.)</span></label></td>
							<td><input type="number" name="salepercent" id="salepercent" min="0.0" max="1.0" value="0.0" step="0.1" /></td>				
						</tr>
						<tr> 
							<td id="info7"><label class="Infoname" for="pimage1">7. 대표이미지파일명</label></td>
							<td><input type="file" name="pimage1" id="pimage1" /></td>				
						</tr>
						
						<tr> 
							<td id="info8"><label class="Infoname" for="pcolor">8. 색상 <span style="color:red; font-size:10pt;">(필수)</span></label></td>
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
							<td id="info9"><label class="Infoname" for="pqty">9. 입고량</label></td>
							<td><input type="number" name="pqty" id="pqty" min="0" value="1" step="1" style="width:50px; height:30px;" /></td>				
						</tr>
						<tr> 
							<td id="info10"><label class="Infoname" for="fk_snum">10. 제품스펙</label></td>
							<td>
								<select id="fk_snum" name="fk_snum">
									<option value="-1">선택하세요</option>
									<c:forEach var="map" items="${requestScope.specList}">
										<option value="${map.snum}">${map.sname}</option>
									</c:forEach>	
								</select> 
							</td>				
						</tr>
						<tr> 
							<td id="info11"><label class="Infoname" for="pinputdate">11. 제품입고일자</label></td>
							<td><input type="date" name="pinputdate" id="pinputdate" /></td>				
						</tr>
						<tr> 
							<td id="info12"><label class="Infoname" for="doption">12. 배송조건<span style="color:red; font-size:10pt;">(필수)</span></label></td>
							<td>
							<select id="doption" name= "doption" class="pilsu">
								<option value="">선택하세요</option>
								<option value="0">무료</option>
								<option value="1">일반</option>
							</select>
							</td>				
						</tr>
						<tr> 
							<td id="info13"><label class="Infoname" for="pcontent">13. 제품설명<br><br></label></td>
							<td colspan="2"><textarea name="pcontent" id="pcontent" rows="5" cols="40" placeholder="간단히 설명하세요" maxlength="100"></textarea></td>				
						</tr>
						<tr> 
							<td id="info14"><label class="Infoname" for="imgPlus1">14. 추가이미지1<span style="color:red; font-size:10pt;">(필수)</span></label></td>
							<td><input type="file" name="imgPlus1" id="imgPlus1" class="pilsu" /></td>		
						</tr>
						<tr> 
							<td id="info15"><label class="Infoname" for="imgPlus2">15. 추가이미지2<span style="font-size:10pt;">(선택)</span></label></td>
							<td><input type="file" name="imgPlus2" id="imgPlus2" /></td>		
						</tr>
						<tr> 
							<td id="info16"><label class="Infoname" for="imgPlus3">16. 추가이미지3<span style="font-size:10pt;">(선택)</span></label></td>
							<td><input type="file" name="imgPlus3" id="imgPlus3" /></td>		
						</tr>																										
					</tbody>
				
				</table>
				
				<div id="buttons">
					<button type="reset" id="goback()" class="proButton">목록으로</button>
					<button type="button" id="goUpdate" class="proButton">수정하기</button>
				</div>
				
			</div>
				<input type="hidden" id="productid" name="productid" />
				<input type="hidden" id="pnum" name="pnum" />
				<input type="hidden" id="imgno" name="imgno" />	
		</form>	
	</div>
</div>
<jsp:include page="../footer.jsp" />
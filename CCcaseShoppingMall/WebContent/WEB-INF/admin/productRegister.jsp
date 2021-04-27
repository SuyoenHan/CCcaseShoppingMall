<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../adminleftSide.jsp" />

<style>
	
	div#leftSide {
		height: 850px;
	}
	
	div#contents {
		border:solid 1px red;
		width: 1000px;
		height: 850px;
	}
	
	span#category{
		border:solid 1px red;
	}
	
	div#menuname{
		padding-left: 40px;
	}
	
	div#proRegister{
		font-size: 20px;
		line-height: 40px;
	}
	
	span.registerInfo{
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


<div id="contents">
	
	<div id="menuname">
		<h2>상품등록<span style="font-size:15px;">&nbsp;(필수입력사항은 꼭 입력해주세요)</span></h2>
		
	</div>
	
	<div id="proRegister">
		<div id="info1"> 
			<span class="registerInfo">1. 제품번호(필수입력)</span>
			<input type="text" name="productid" placeholder="고유한 값입니다" autofocus="autofocus"/> 
		</div>
		
		<div id="info2"> 
			<span class="registerInfo">2. 제품상세번호(필수입력)</span>
			<input type="text" name="proDetailId" placeholder="고유한 값입니다" /> 
		</div>
		
		<div id="info3"> 
			<span class="registerInfo">3. 스펙번호(0:인기 1:신상)(필수입력)</span>
			<select id="specNo">
				<option>선택하세요</option>
				<option>0</option>
				<option>1</option>
			</select> 
		</div>
	
		<div id="info4"> 
			<span class="registerInfo">4. 카테고리명(필수입력)</span>
			<select id="cname">
				<option>선택하세요</option>
				<option>하드케이스</option>
				<option>젤리케이스</option>
				<option>범퍼케이스</option>
				<option>악세사리</option>
			</select>
		</div>
		
		<div id="info5">
			<span class="registerInfo">5. 회사명(필수입력)</span>
			<select id="mname">
				<option>선택하세요</option>
				<option>LG</option>
				<option>삼성</option>
				<option>애플</option>
			</select>
		</div>
		
		<div id="info6"> 
			<span class="registerInfo">6. 제품명(필수입력)</span>
			<input type="text" name="productname" placeholder="정확히 입력해주세요" /> 
		</div>
		
		<div id="info7"> 
			<span class="registerInfo">7. 기종명(필수입력)</span>
			<input type="text" name="modelname" placeholder="정확히 입력해주세요" /> 
		</div>
		
		<div id="info8"> 
			<span class="registerInfo">8. 색상(필수입력)</span>
			<input type="text" name="pcolor" placeholder="정확히 입력해주세요" /> 
		</div>
		
		<div id="info9"> 
			<span class="registerInfo">9. 제품상세명(필수입력)</span>
			<input type="text" name="pname" placeholder="정확히 입력해주세요" /> 
		</div>
		
		<div id="info10"> 
			<span class="registerInfo">10. 제품정가</span>
			<input type="text" name="price" placeholder="정확히 입력해주세요" /> 
		</div>
		
		<div id="info11"> 
			<span class="registerInfo">11. 할인율</span>
			<input type="text" name="salepercent" placeholder="정확히 입력해주세요" /> 
		</div>
		
		<div id="info12"> 
			<span class="registerInfo">12. 제품입고일자(date)</span>
			<input type="date" name="pinputdate" />
		</div>
		
		<div id="info14"> 
			<span class="registerInfo">13. 배송조건(0:무료 1:일반)(필수입력)</span>
			<select id="doption">
				<option>선택하세요</option>
				<option>0</option>
				<option>1</option>
			</select> 
		</div>
		
		<div id="info15"> 
			<span class="registerInfo">14. 재고량</span>
			<input type="text" name="pqty" placeholder="정확히 입력해주세요" /> 
		</div>
		
		<div id="info16"> 
			<span class="registerInfo">15. 대표이미지파일명(pimage1)</span>
			<input type="text" name="pimage1" placeholder="정확히 입력해주세요" /> 
		</div>
		
		<div id="info13"> 
			<span class="registerInfo">16. 제품설명<br><br></span>
			<textarea name="proname" rows="4" cols="25" placeholder="간단히 설명하세요" maxlength="30"></textarea>
		</div>
		
	</div>
	
	<div id="buttons">
	<button type="button" id="register" class="proButton">등록</button>
	<button type="reset" id="cancel" class="proButton">취소</button>
	</div>

</div>

<jsp:include page="../footer.jsp" />
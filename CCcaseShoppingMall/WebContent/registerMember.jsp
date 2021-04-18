<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="header.jsp" />

<style>
   table#tblMemberRegister {
          width: 70%;
          border: hidden;          
          margin: 10px;
   }  
   
   table#tblMemberRegister #th {
         height: 40px;
         text-align: center;
         font-size: 14pt;
   }
   
   table#tblMemberRegister td {
         line-height: 30px;
         padding-top: 8px;
         padding-bottom: 8px;
   }
   
   span.error {
   		color: red;
   }
   
</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

var b_flagIdDuplicateClick =false; // 아이디중복확인 여부 확인
var b_flagEmailDuplicateClick = false; // 이메일중복확인 여부 확인

$(document).ready(function(){
	
	$("span.error").hide(); // 에러 숨기기
	$("input#userid").focus(); // 이름 자동포커스
	

	// 1. 아이디
	$("input#userid").blur(function(){
		
		var userid = $(this).val().trim();
		if(userid == "") {
			// 입력하지 않거나 공백만 입력
			$("table#tblMemberRegister :input").prop("disabled",true);
			$(this).prop("disabled",false);
			
			$(this).parent().find(".error").show();
			$(this).focus();
		}
		else {
			// 공백이 아닌 글자를 입력
			$("table#tblMemberRegister :input").prop("disabled",false);
			$(this).parent().find(".error").hide();
		}
		
	}); // end of $("input#userid").blur(function(){})------------------------------------
	
	// 2. 비밀번호
	$("input#pwd").blur(function(){
		
		var regExp = new RegExp(/^.*(?=^.{10,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
		// 숫자/문자/특수문자/ 포함 형태의 10~15자리 이내의 암호 정규표현식 객체 생성	
	
		var bool = regExp.test($(this).val());
		
		if(!bool) {
			// 암호가 정규표현식에 위배된 경우
			$("table#tblMemberRegister :input").prop("disabled",true);
			$(this).prop("disabled",false);
		
			$(this).parent().find(".error").show();
			$(this).focus();
		}
		else {
			// 암호가 정규표현식에 맞는 경우
			$("table#tblMemberRegister :input").prop("disabled",false);
			$(this).parent().find(".error").hide();
		}
		
	}); // end of $("input#pwd").blur(function(){})--------------------------------------------	
	
	// 3. 비밀번호 확인
	$("input#pwdcheck").blur(function(){
		
		var pwd = $("input#pwd").val();
		var pwdcheck = $(this).val();
		
		if(pwd != pwdcheck) {
			// 암호와 암호확인값이 틀린 경우
			$("table#tblMemberRegister :input").prop("disabled",true);
			$(this).prop("disabled",false);
			$("input#pwd").prop("disabled",false);
					
			$(this).parent().find(".error").show();
			$("input#pwd").focus();
		}
		else {
			// 암호와 암호확인값이 같은 경우
			$("table#tblMemberRegister :input").prop("disabled",false);
			
			$(this).parent().find(".error").hide();
		}
		
	}); // end of $("input#pwdcheck").blur(function(){})---------------------------------
	
	// 4. 이름
	$("input#name").blur(function(){
	
		var name = $(this).val().trim();
		if(name == "") {
			// 입력하지 않거나 공백만 입력
			$("table#tblMemberRegister :input").prop("disabled",true);
			$(this).prop("disabled",false);
			
			$(this).parent().find(".error").show();
			$(this).focus();
		}
		else {
			// 공백이 아닌 글자를 입력
			$("table#tblMemberRegister :input").prop("disabled",false);
			$(this).parent().find(".error").hide();
		}
		
	});// end of $("input#name").blur(function(){})-------------------------------------

	// 5. 이메일
	$("input#email").blur(function(){
		
			var regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
			// 이메일 정규표현식 객체 생성	
		
			var bool = regExp.test($(this).val());
			
			if(!bool) {
				// 이메일이 정규표현식에 위배된 경우
				$("table#tblMemberRegister :input").prop("disabled",true);
				$(this).prop("disabled",false);
			
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else {
				// 이메일이 정규표현식에 맞는 경우
				$("table#tblMemberRegister :input").prop("disabled",false);
				$(this).parent().find(".error").hide();
			}
			
		}); // end of $("input#email").blur(function(){})------------------------------------
	
	// 5. 핸드폰 번호	
	$("input#hp2").blur(function(){
		
			var regExp = /^[1-9][0-9]{3}$/i; // 첫번째 숫자는 0을 제외하고 나머지 3개는 0을 포함한 숫자만 오도록 검사해주는 정규표현식 객체 생성  
		
			var bool = regExp.test($(this).val());
			
			if(!bool) {
				// 국번이 정규표현식에 위배된 경우
				$("table#tblMemberRegister :input").prop("disabled",true);
				$(this).prop("disabled",false);
			
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else {
				// 국번이 정규표현식에 맞는 경우
				$("table#tblMemberRegister :input").prop("disabled",false);
				$(this).parent().find(".error").hide();
			}
			
		}); // end of $("input#hp2").blur(function(){})----------------------------------------------
		
		
		$("input#hp3").blur(function(){
			
			var regExp = /^\d{4}$/i; 
			// 숫자 4개만 오도록 검사해주는 정규표현식 객체 생성  
		
			var bool = regExp.test($(this).val());
			
			if(!bool) {
				// 마지막 전화번호 4자리가 정규표현식에 위배된 경우
				$("table#tblMemberRegister :input").prop("disabled",true);
				$(this).prop("disabled",false);
			
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else {
				// 마지막 전화번호 4자리가 정규표현식에 맞는 경우
				$("table#tblMemberRegister :input").prop("disabled",false);
				$(this).parent().find(".error").hide();
			}
			
		}); // end of $("input#hp3").blur(function(){})----------------------------------------------		
		
}); // end of $(document).ready(function(){})------------------

function goRegister() {
	
	//// 최종적으로 필수입력사항에 모두 입력이 되었는지 검사한다. ////
	var bFlagRequiredInfo = false;
	
	$(".requiredInfo").each(function(index, item){
		var data = $(item).val();
		if(data == "") {
			bFlagRequiredInfo = true;
			alert("필수입력사항은 모두 입력하셔야 합니다.");
			return false; // break 라는 뜻이다.
		}
	});
	
	if(!b_flagIdDuplicateClick){
		//가입하기 버튼을 클릭시 "아이디중복확인" 을 클릭하지 않았을 경우.
		alert("아이디중복확인을 클릭하여 아이디 중복검사를 하세요!!");
		return; //종료 submit되어지면 안되니까.
	}
	else{
		//가입하기 버튼을 클릭시 "아이디중복확인" 을 클릭했을 경우.
	}
	
	
	if(!bFlagRequiredInfo) {
		var frm = document.registerFrm;
		frm.action = "memberRegister.up";
		frm.method = "post";
		frm.submit();
	}
	
	
}// end of function goRegister()---------------------------------

</script>


<div class="row" id="divRegisterFrm">
   <div class="col-md-12" align="center">
   <form name="registerFrm">
   
   <table id="tblMemberRegister">
      <thead>
      <tr>
         <th colspan="2" id="th"> <h2>회원가입</h2> <hr></th>
      </tr>
      </thead>
      <tbody>

      <tr>
         <td style="width: 20%; font-weight: bold;">아이디&nbsp;</td>
         <td style="width: 80%; text-align: left;">
             <input type="text" name="userid" id="userid" class="requiredInfo" />&nbsp;&nbsp;
             <button type="button" id="btnIdCheck" style="background-color: rgb(224, 224, 224); border:none; height: 28px; border-radius: 5px;" >아이디 중복 확인</button> 
             <span id="idcheckResult"></span>
             <span class="error">아이디는 필수입력 사항입니다.</span>
         </td> 
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">비밀번호&nbsp;</td>
         <td style="width: 80%; text-align: left;">
         	<input type="password" name="pwd" id="pwd" class="requiredInfo" />&nbsp;&nbsp;
            <span style="font-size: 12px;">(문자/숫자/특수문자 포함, 10자~15자)</span><br>
            <span class="error">암호는 영문자,숫자,특수기호가 혼합된 10~15 글자로 입력하세요.</span>
         </td>
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">비밀번호확인&nbsp;</td>
         <td style="width: 80%; text-align: left;"><input type="password" id="pwdcheck" class="requiredInfo" /> 
            <span class="error">암호가 일치하지 않습니다.</span>
         </td>
      </tr>
            <tr>
         <td style="width: 20%; font-weight: bold;">성명&nbsp;</td>
         <td style="width: 80%; text-align: left;">
             <input type="text" name="name" id="name" class="requiredInfo" /> 
            <span class="error">성명은 필수입력 사항입니다.</span>
         </td>
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">이메일&nbsp;</td>
         <td style="width: 80%; text-align: left;">
         	<input type="text" name="email" id="email" class="requiredInfo" placeholder="abc123@ssangyong.com" /> 
             <span class="error">이메일 형식에 맞지 않습니다.</span>

         </td>
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">휴대전화</td>
         <td style="width: 80%; text-align: left;">
             <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
             <input type="text" id="hp2" name="hp2" size="6" maxlength="4" />&nbsp;-&nbsp;
             <input type="text" id="hp3" name="hp3" size="6" maxlength="4" />
             <span class="error">휴대폰 형식이 아닙니다.</span>
         </td>
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">주소</td>
         <td style="width: 80%; text-align: left;">
             <input type="text" id="postcode" name="postcode" size="6" maxlength="5" placeholder="우편번호"/>&nbsp;&nbsp;
             <button type="button" id="btnZipSearch" style="background-color: rgb(224, 224, 224); border:none; height: 28px; border-radius: 5px;" >검색</button><br> 
             <span class="error">우편번호 형식이 아닙니다.</span>
             
            <input type="text" id="address" name="address" size="40" placeholder="주소" /><br/>
            <input type="text" id="detailAddress" name="detailAddress" size="40" placeholder="상세주소" />
            <span class="error">주소를 입력하세요</span>
         </td>
      </tr>
             
      <tr style="text-align: center;">
         <td colspan="2" style="line-height: 90px;">
            <button type="button" id="btnRegister" style="background-color: rgb(94, 94, 94); color: white; border:none; width: 100px; height: 40px;  border-radius: 5px;" onClick="goRegister();">회원가입</button> 
        	<button type="button" id="btnRegister" style="background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; margin-left: 5%; border-radius: 5px;" onClick="goRegister();">취소</button> 
         </td>
      </tr>
      </tbody>
   </table>
   </form>
   </div>
</div>

<jsp:include page="footer.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
    String ctxPath = request.getContextPath();
    //     /MyMVC 
%>    
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.min.js"></script> 
<link rel="stylesheet" href="<%= ctxPath %>/css/register.css" />
    
<jsp:include page="../../WEB-INF/header.jsp" />


<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("span.error").hide();

	
		$("input#userid").blur(function(){
			
			var userid = $(this).val().trim();
			if(userid == "") {
				// 입력하지 않거나 공백만 입력했을 경우
				$("table#tblMemberRegister :input").prop("disabled",true);
				$(this).prop("disabled",false);
			
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else {
				// 공백이 아닌 글자를 입력했을 경우
				$("table#tblMemberRegister :input").prop("disabled",false);
				$(this).parent().find(".error").hide();
			}
			
		}); // 아이디가 userid 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.	
		
		$("input#pwd").blur(function(){
	
			var regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
		
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
			
		}); // 아이디가 pwd 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.	
		
		
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
			
		}); // 아이디가 pwdcheck 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.	
		$("input#name").blur(function(){
			
			var name = $(this).val().trim();
			if(name == "") {
				// 입력하지 않거나 공백만 입력했을 경우
				$("table#tblMemberRegister :input").prop("disabled",true);
				$(this).prop("disabled",false);
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else {
				// 공백이 아닌 글자를 입력했을 경우
				$("table#tblMemberRegister :input").prop("disabled",false);
				$(this).parent().find(".error").hide();
			}
			
		}); // 아이디가 name 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다. 
		
		$("input#email").blur(function(){
			
	
				var regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
			
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
				
			}); // 아이디가 email 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
			
		$("input#hp2").blur(function(){
			
				var regExp = /^[1-9][0-9]{3}$/i; 
				// 첫번째 숫자는 0을 제외하고 나머지 3개는 0을 포함한 숫자만 오도록 검사해주는 정규표현식 객체 생성  
			
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
				
			}); // 아이디가 hp2 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.	
			
			
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
				
			}); // 아이디가 hp3 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.		
		
			
		$("img#zipcodeSearch").click(function(){
			new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("extraAddress").value = '';
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('postcode').value = data.zonecode;
	                document.getElementById("address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("detailAddress").focus();
	            }
	        }).open();
		});	


    
	}); // end of $(document).ready(function(){})------------------
	

	
	// === Function declaration === //
	
   function goEdit() {
	   var flagBool=false;
	  $(".requiredInfo").each(function(index,item){
		  
		  var data = $(item).val().trim();
		   
		   if(data==""){
			   flagBool=true;
			   return false;
			   /*
               for문에서의 continue; 와 동일한 기능을 하는것이 
               each(); 내에서는 return true; 이고,
               for문에서의 break; 와 동일한 기능을 하는것이 
               each(); 내에서는 return false; 이다.
            */
		   }
	   });
   	
	  if(flagBool){
		  alert("필수입력란은 모두 입력하셔야 합니다.");
	  	  return;
	  }
	  else{
		  var frm=document.editFrm;
		  frm.method="POST";
		  frm.action="<%= ctxPath%>/member/memberEditEnd.cc";
	  	  frm.submit();
	  }
      
   }// end of goEdit(event)------------------
	
</script>

<div class="row" id="divRegisterFrm">
	<div class="col-md-12" align="center">
	<form name="editFrm">
	
	<table id="tblMemberRegister">
		<thead>
	      <tr>
         <th colspan="2" id="th"> <h2>회원정보수정</h2> <hr></th>
      </tr>
		</thead>
		<tbody>
		
		<tr>
			<td style="width: 20%; font-weight: bold;">아이디&nbsp;</td>
			<td style="width: 80%; text-align: left;">
		 	<input type="hidden" name="userid" value="${sessionScope.loginuser.userid}"/>
            <span>${sessionScope.loginuser.userid}</span>
			    
			</td> 
		</tr>
		<tr>
			<td style="width: 20%; font-weight: bold;">비밀번호&nbsp;<span class="star">*</span></td>
			<td style="width: 80%; text-align: left;"><input type="password" name="pwd" id="pwd" class="requiredInfo" />
				<span class="error">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로 입력하세요.</span>
			</td>
		</tr>
		<tr>
			<td style="width: 20%; font-weight: bold;">비밀번호확인&nbsp;<span class="star">*</span></td>
			<td style="width: 80%; text-align: left;"><input type="password" id="pwdcheck" class="requiredInfo" /> 
				<span class="error">암호가 일치하지 않습니다.</span>
			</td>
		</tr>
		<tr>
			<td style="width: 20%; font-weight: bold;">성명&nbsp;<span class="star">*</span></td>
			<td style="width: 80%; text-align: left;">
			    <input type="text" name="name" id="name" class="requiredInfo" /> 
				<span class="error">성명은 필수입력 사항입니다.</span>
			</td>
		</tr>
		<tr>
			<td style="width: 20%; font-weight: bold;">이메일&nbsp;</td>
			<td style="width: 80%; text-align: left;"><span>${sessionScope.loginuser.email}</span>
			    <span id="emailCheckResult"></span>
			    <span class="error">이메일 형식에 맞지 않습니다.</span>
			</td>
		</tr>
		<tr>
			<td style="width: 20%; font-weight: bold;">연락처</td>
			<td style="width: 80%; text-align: left;">
			    <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
			    <input type="text" id="hp2" name="hp2" size="6" maxlength="4" />&nbsp;-&nbsp;
			    <input type="text" id="hp3" name="hp3" size="6" maxlength="4" />
			    <span class="error">휴대폰 형식이 아닙니다.</span>
			</td>
		</tr>
		<tr>
			<td style="width: 20%; font-weight: bold;">우편번호</td>
			<td style="width: 80%; text-align: left;">
			   <input type="text" id="postcode" name="postcode" size="6" maxlength="5" />&nbsp;&nbsp;
			   <%-- 우편번호 찾기 --%>
			   <img id="zipcodeSearch" src="<%= ctxPath %>/images/member/b_zipcode.gif" style="vertical-align: middle;" />
			   <span class="error">우편번호 형식이 아닙니다.</span>
			</td>
		</tr>
		<tr>
			<td style="width: 20%; font-weight: bold;">주소</td>
			<td style="width: 80%; text-align: left;">
			   <input type="text" id="address" name="address" size="40" placeholder="주소" /><br><br>
			   <input type="text" id="detailAddress" name="detailAddress" size="40" placeholder="상세주소" />&nbsp;<input type="text" id="extraAddress" name="extraAddress" size="40" placeholder="참고항목" /> 
			   <span class="error">주소를 입력하세요</span>
			</td>
		</tr>
		    <tr style="text-align: center;">
         <td colspan="2" style="line-height: 30px;">
            <button type="button" id="btnRegister" style="background-color: rgb(94, 94, 94); color: white; border:none; width: 100px; height: 40px;  border-radius: 5px;" onClick="goEdit();">확인</button>  
         	<button type="button" id="btnRegister" style="background-color: rgb(94, 94, 94); color: white; border:none; width: 100px; height: 40px;  border-radius: 5px;" onClick="javascript:history.back();">취소</button> 
         </td>
      </tr>
	
		</tbody>
	</table>
	</form>
	</div>
</div>
<jsp:include page="../../WEB-INF/footer.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%  
    String ctxPath = request.getContextPath();
    //     /MyMVC 
%>    
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.min.js"></script> 
    
<jsp:include page="../../WEB-INF/header.jsp" />
<jsp:include page="../../WEB-INF/member/myPageHeader.jsp"/>
<jsp:include page="../../WEB-INF/mypageleftSide.jsp" />

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>

	div#divEidtFrm{
	border: solid 0px blue;
	width: 70%;
	height:80%;
	margin-left: 240px;
	/* padding-bottom: 500px; */
	padding-bottom: 300px;
	}
	table#tblMemberEdit{
		border: solid 0px red;
		height:600px;
		line-height:25px;
	}
	button#btnEdit{
		margin: 30px 50px 12px 0px;
	
	}
	span#delete{
	 text-align:right;
	  padding-left:470px;
		
	}

	div#emailEditclick{
	margin-top: 5px;
	
	}
	span#delete{
		color:gray;
		font-size: 8pt;
		width: 100%;
	}
</style>

<script type="text/javascript">
	
var b_flagEmailDuplicateClick = true;

	$(document).ready(function(){
		
		$("span.error").hide();
		
		 $("span.emailcheck").hide();
		$("div#emailEditclick").hide();
		$("span.emailEditBack").hide();
		
		$("button#emailCheckButton").prop("disabled",true);
		
		$("input#pwd").blur(function(){
	
			var regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
		
			var bool = regExp.test($(this).val());
			
			if(!bool) {
				// 암호가 정규표현식에 위배된 경우
				$("table#tblMemberEdit :input").prop("disabled",true);
				$(this).prop("disabled",false);
			
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else {
				// 암호가 정규표현식에 맞는 경우
				$("table#tblMemberEdit :input").prop("disabled",false);
				$(this).parent().find(".error").hide();
			}
			
		}); // 아이디가 pwd 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.	
		
		
		$("input#pwdcheck").blur(function(){
			
			var pwd = $("input#pwd").val();
			var pwdcheck = $(this).val();
			
			if(pwd != pwdcheck) {
				// 암호와 암호확인값이 틀린 경우
				$("table#tblMemberEdit :input").prop("disabled",true);
				$(this).prop("disabled",false);
				$("input#pwd").prop("disabled",false);
						
				$(this).parent().find(".error").show();
				$("input#pwd").focus();
			}
			else {
				// 암호와 암호확인값이 같은 경우
				$("table#tblMemberEdit:input").prop("disabled",false);
				
				$(this).parent().find(".error").hide();
			}
			
		}); // 아이디가 pwdcheck 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.	
		$("input#name").blur(function(){
			
			var name = $(this).val().trim();
			if(name == "") {
				// 입력하지 않거나 공백만 입력했을 경우
				$("table#tblMemberEdit :input").prop("disabled",true);
				$(this).prop("disabled",false);
				$(this).parent().find(".error").show();
				$(this).focus();
			}
			else {
				// 공백이 아닌 글자를 입력했을 경우
				$("table#tblMemberEdit :input").prop("disabled",false);
				$(this).parent().find(".error").hide();
			}
			
		}); // 아이디가 name 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다. 
		
	      $("input#email").blur(function(){
	           $("span#emailCheckResult").html("");
	            var regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
	         
	            var bool = regExp.test($(this).val());
	            
	            if(!bool) {
	               // 이메일이 정규표현식에 위배된 경우
	               $("table#tblMemberEdit :input").prop("disabled",true);
	               $(this).prop("disabled",false);
	            
	               $(this).parent().find(".error").show();
	               $(this).focus();
	               $("button#emailCheckButton").prop("disabled",true);
	            }
	            else {
	               // 이메일이 정규표현식에 맞는 경우
	                $("button#emailCheckButton").prop("disabled",false);
	               $("table#tblMemberEdit :input").prop("disabled",false);
	               $(this).parent().find(".error").hide();
	            }
	            
	         }); // 아이디가 email 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
			
		$("input#hp2").blur(function(){
			
				var regExp = /^[1-9][0-9]{3}$/i; 
				// 첫번째 숫자는 0을 제외하고 나머지 3개는 0을 포함한 숫자만 오도록 검사해주는 정규표현식 객체 생성  
			
				var bool = regExp.test($(this).val());
				
				if(!bool) {
					// 국번이 정규표현식에 위배된 경우
					$("table#tblMemberEdit :input").prop("disabled",true);
					$(this).prop("disabled",false);
				
					$(this).parent().find(".error").show();
					$(this).focus();
				}
				else {
					// 국번이 정규표현식에 맞는 경우
					$("table#tblMemberEdit :input").prop("disabled",false);
					$(this).parent().find(".error").hide();
				}
				
			}); // 아이디가 hp2 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.	
			
			
			$("input#hp3").blur(function(){
				
				var regExp = /^\d{4}$/i; 
				// 숫자 4개만 오도록 검사해주는 정규표현식 객체 생성  
			
				var bool = regExp.test($(this).val());
				
				if(!bool) {
					// 마지막 전화번호 4자리가 정규표현식에 위배된 경우
					$("table#tblMemberEdit :input").prop("disabled",true);
					$(this).prop("disabled",false);
				
					$(this).parent().find(".error").show();
					$(this).focus();
				}
				else {
					// 마지막 전화번호 4자리가 정규표현식에 맞는 경우
					$("table#tblMemberEdit :input").prop("disabled",false);
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
	
	  function isExistEmailCheck() {
    
      b_flagEmailDuplicateClick = true;
       // "이메일중복확인"을  클릭했다 라고 표기를 해주는 것이다.
   
      if ($('#email').val() == '') {
              alert('이메일을 확인 해주세요.')
              return;
        }
      
   
         $.ajax({
             url:"<%= ctxPath%>/member/emailDuplicateCheck.cc",
             data:{"email":$("input#email").val()},
             type:"post",
             dataType:"json",   
             success:function(json){
             
       
              if(json.isExists) {
                   // 입력한 email 이 이미 사용중이라면 
                   $("span#emailCheckResult").html($("input#email").val()+" 은 중복된 email 이므로 사용불가 합니다.").css("color","red");
                   $("input#email").val("");
                }
                
                else {
                   // 입력한 email 이 DB 테이블에 존재하지 않는 경우라면 
                    $("span#emailCheckResult").html("사용가능합니다").css("color","navy");
                }
             },
             error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
          });
  
   }// end of function isExistEmailCheck()---------------------------
	
   function emailEdit(){
	  
	   $("span.emailEdit").hide();
	   $("span.emailEditBack").show();
	   $("span.emailcheck").show();
	   $("div#emailEditclick").show();
	   b_flagEmailDuplicateClick = false;
   }
   function emailEditBack(){
	   $("span.emailEdit").show();
	   $("span.emailcheck").hide();
	   $("div#emailEditclick").hide();
	   $("span.emailEditBack").hide();
	   b_flagEmailDuplicateClick = true;
   }
	
   function goEdit() {
	 
	  if(!b_flagEmailDuplicateClick) { 
	    	// "이메일중복확인" 을  클릭을 안했을 경우 
	    	alert("이메일중복확인 클릭하여 이메일중복검사를 하세요!!");
	    	return; // 종료
	  }
	 
      var flagBool=false;
   	  $(".requiredInfo").each(function(index,item){
   		  
   		  var data = $(item).val().trim();
   		   
   		   if(data==""){
   			   flagBool=true;
   			   return false;

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
   function goDelete(){
	
	location.href="<%= request.getContextPath()%>/member/deletepasswdCheckMain.cc";
   
   }
</script>

<div class="row" id="divEidtFrm">
	<div class="col-md-12" align="center">
	<form name="editFrm">
	<table id="tblMemberEdit">
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
			<td style="width: 80%; text-align: left;">
			<input type="password" name="pwd" id="pwd" class="requiredInfo" value="${sessionScope.loginuser.pwd}" placeholder="●●●●" />
				<span class="error">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로 입력하세요.</span>
			</td>
		</tr>
		<tr>
			<td style="width: 20%; font-weight: bold;">비밀번호확인&nbsp;<span class="star">*</span></td>
			<td style="width: 80%; text-align: left;"><input type="password" id="pwdcheck" class="requiredInfo" value="${sessionScope.loginuser.pwd}" placeholder="●●●●" /> 
				<span class="error">암호가 일치하지 않습니다.</span>
			</td>
		</tr>
		<tr>
			<td style="width: 20%; font-weight: bold;">성명&nbsp;<span class="star">*</span></td>
			<td style="width: 80%; text-align: left;">
			    <input type="text" name="name" id="name" class="requiredInfo" value="${sessionScope.loginuser.name}"/> 
				<span class="error">성명은 필수입력 사항입니다.</span>
			</td>
		</tr>
		<tr>
			<td style="width: 20%; font-weight: bold;">이메일&nbsp;<span class="star">*</span></td>
			<td style="width: 80%; text-align: left;"> <input type="hidden"  name="hiemail" id="hiemail" class="requiredInfo" value="${sessionScope.loginuser.email}"/>${sessionScope.loginuser.email}
				<span class="emailEdit"style="display: inline-block; width: 80px; height: 30px; border: solid 1px gray; border-radius: 5px; font-size: 8pt; text-align: center; margin-left: 10px; cursor: pointer;" onclick="emailEdit();">이메일변경하기</span> 
			  <span class="emailEditBack"style="display: inline-block; width: 80px; height: 30px; border: solid 1px gray; border-radius: 5px; font-size: 8pt; text-align: center; margin-left: 10px; cursor: pointer;" onclick="emailEditBack();">이메일변경 취소</span> 
			  
			    <div id="emailEditclick">
				    <input type="text" name="email" id="email"class="requiredInfoEdit" placeholder="abc@def.com" />
				     <span class="emailCheckButton"style="display: inline-block; width: 80px; height: 30px; border: solid 1px gray; border-radius: 5px; font-size: 8pt; text-align: center; margin-left: 10px; cursor: pointer;"  onclick="isExistEmailCheck();">이메일중복확인</span>
				    <span id="emailCheckResult"></span> 
				    <span class="error">이메일 형식에 맞지 않습니다.</span>
			    </div>
			    
			</td>
		</tr>
		<tr>
			<td style="width: 20%; font-weight: bold;">연락처</td>
			<td style="width: 80%; text-align: left;">
			    <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
			    <input type="text" id="hp2" name="hp2" size="6" maxlength="4" value="${fn:substring(sessionScope.loginuser.mobile,3,7)}"/>&nbsp;-&nbsp;
			    <input type="text" id="hp3" name="hp3" size="6" maxlength="4"value="${fn:substring(sessionScope.loginuser.mobile,7,11)}" />
			    <span class="error">휴대폰 형식이 아닙니다.</span>
			</td>
		</tr>
		<tr>
			<td style="width: 20%; font-weight: bold;">우편번호</td>
			<td style="width: 80%; text-align: left;">
			   <input type="text" id="postcode" name="postcode" value="${sessionScope.loginuser.postcode}" size="6" maxlength="5" />&nbsp;&nbsp;
			   <%-- 우편번호 찾기 --%>
			   <img id="zipcodeSearch" src="<%= ctxPath %>/images/member/b_zipcode.gif" style="vertical-align: middle;" />
			   <span class="error">우편번호 형식이 아닙니다.</span>
			</td>
		</tr>
		<tr>
			<td style="width: 20%; font-weight: bold;">주소</td>
			<td style="width: 80%; text-align: left;">
			   <input type="text" id="address" name="address" value="${sessionScope.loginuser.address}" size="40" placeholder="주소" /><br>
			   <input type="text" style="margin-top: 5px;"id="detailAddress" name="detailAddress"  value="${sessionScope.loginuser.detailaddress}" size="40" placeholder="상세주소" />
			   <input type="text" style="margin-top: 5px;id="extraAddress" name="extraAddress" value="${sessionScope.loginuser.extraaddress}" size="40" placeholder="참고항목" /> 
			   <span class="error">주소를 입력하세요</span><br>
			 
			</td>
	
		</tr>
	
		
		 <tr style="text-align: center;">
         <td colspan="2">
         <hr>
            <span id="delete">탈퇴를 원하시면 우측의 회원탈퇴 버튼을 눌러주세요.<button type="button" id="btnDelete" style="background-color: #E0E0E0; border:none; width: 100px; height: 25px;  border-radius: 5px;" onClick="goDelete('${(sessionScope.loginuser).userid}');">회원탈퇴</a></span>
            <button type="button" id="btnEdit" style="background-color: rgb(94, 94, 94); color: white; border:none; width: 100px; height: 40px;  border-radius: 5px;" onClick="goEdit();">확인</button>  
         	<button type="button" id="btnback" style="background-color: #E0E0E0; color: black; border:none; width: 100px; height: 40px;  border-radius: 5px;" onClick="javascript:history.back();">취소</button> 
         </td>
      </tr>
      <tr>
		
		</tr>
		
		</tbody>
	</table>
	</form>
	</div>
</div>


<jsp:include page="../../WEB-INF/footer.jsp" />
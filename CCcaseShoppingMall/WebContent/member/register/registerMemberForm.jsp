<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="../../css/register.css" />
    
<jsp:include page="../../header.jsp" />

<div align="center">
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
             <input type="text" name="userid" id="userid" class="requiredInfo" maxlength="10"/>&nbsp;&nbsp;
             <button type="button" id="btnIdCheck" style="background-color: rgb(224, 224, 224); border:none; height: 28px; border-radius: 5px;" >아이디 중복 확인</button> 
         </td> 
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">비밀번호&nbsp;</td>
         <td style="width: 80%; text-align: left;">
         	<input type="password" name="pwd" id="pwd" class="requiredInfo" />&nbsp;&nbsp;
            <span style="font-size: 12px;">(문자/숫자/특수문자 포함, 10자~15자)</span><br>
         </td>
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">비밀번호확인&nbsp;</td>
         <td style="width: 80%; text-align: left;"><input type="password" id="pwdcheck" class="requiredInfo" /> 
         </td>
      </tr>
            <tr>
         <td style="width: 20%; font-weight: bold;">성명&nbsp;</td>
         <td style="width: 80%; text-align: left;">
         <input type="text" name="name" id="name" class="requiredInfo" /> 
         </td>
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">이메일&nbsp;</td>
         <td style="width: 80%; text-align: left;">
         	<input type="text" name="email" id="email" class="requiredInfo" placeholder="abc123@ssangyong.com" /> 
         </td>
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">휴대전화</td>
         <td style="width: 80%; text-align: left;">
             <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
             <input type="text" id="hp2" name="hp2" size="6" maxlength="4" />&nbsp;-&nbsp;
             <input type="text" id="hp3" name="hp3" size="6" maxlength="4" />
         </td>
      </tr>
      <tr>
         <td style="width: 20%; font-weight: bold;">주소</td>
         <td style="width: 80%; text-align: left;">
             <input type="text" id="postcode" name="postcode" size="6" maxlength="5" placeholder="우편번호"/>&nbsp;&nbsp;
             <button type="button" id="btnZipSearch" style="background-color: rgb(224, 224, 224); border:none; height: 28px; border-radius: 5px;" >검색</button><br> 
             
             <input type="text" id="address" name="address" size="40" placeholder="주소" /><br/>
             <input type="text" id="detailAddress" name="detailAddress" size="40" placeholder="상세주소" />
         </td>
      </tr>
             
      <tr style="text-align: center;">
         <td colspan="2" style="line-height: 90px;">
            <button type="button" id="btnRegister" style="background-color: rgb(94, 94, 94); color: white; border:none; width: 100px; height: 40px;  border-radius: 5px;" onClick="goRegister();">회원가입</button> 
        	<button type="button" id="btnRegister" style="background-color: rgb(224, 224, 224); border:none; width: 100px; height: 40px; margin-left: 5%; border-radius: 5px;" onClick="goBack();">취소</button> 
         </td>
      </tr>
      </tbody>
   </table>
   </form>
 </div>

<jsp:include page="../../footer.jsp" />
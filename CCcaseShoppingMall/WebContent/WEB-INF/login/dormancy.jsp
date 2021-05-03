<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
    //     /MyMVC
%>    

<jsp:include page="../../WEB-INF/header.jsp" />
<style>

	div#divdorFrm{
		margin:200px 0px 200px 100px;
		
	}
	table#tbldor{
	width: 100%;
	}
	tbody{
	
		margin-top: 30px;
	}
	td{
	
		margin-top: 30px;
	}
	

</style>


<script type="text/javascript">

	function goclear(userid){

		location.href="<%= request.getContextPath()%>/login/dormancy.cc?userid="+userid;
		if(${requestScope.n !=0}) {
			alert("휴면해제 되었습니다. 다시 로그인 해주세요!");
			location.href="<%= ctxPath%>/home.cc";
		}
	   }
</script>


<div class="row" id="divdorFrm">
	<div class="col-md-12" align="center">
	<form>
	<table id="tbldor">
		<thead>
	      <tr>
         <th colspan="2" id="th" style="text-align: center;"> <span style="font-weight: bold; font-size:40pt;">계정이 휴면 상태 입니다.</span><br>
          1년간 로그인 이력이 없어 휴면 전환된 계정을 해제하여 다시 사용 하실 수 있습니다.<hr></th>
     
      </tr>
		</thead>
		<tbody>
		
		<tr style="border-bottom: solid 2px gray;">
			<td style="font-weight: bold; font-size:20pt; height: 80px;">휴면 계정 해제 </td> 
			<th> </th>
		</tr>
	
		<tr style="font-weight: bold; font-size:15pt;border-bottom: solid 2px gray;height: 100px;">
			<td style="font-weight: bold;font-size:18pt;">휴면 해제 안내</td>
			<th>휴면해제 안내 휴면 상태를 해제하시면 다시 정상적으로 사용이 가능합니다.<br>휴면상태 해제 후에는 다시 로그인이 필요합니다.</th>
		</tr>

		 <tr style="text-align: center;">
	         <td colspan="2" style="line-height: 30px;">
	            <button type="button" id="btnEdit" style="background-color: rgb(94, 94, 94); color: white;margin-top:70px; border:none; width: 200px; height: 60px; font-size:13pt; border-radius: 5px;" onClick="goclear('${userid}');">휴면 상태 해제</button>  
	         	<button type="button" id="btnback" style="background-color: #E0E0E0; color: black; margin-left:50px; border:none; width: 150px; height: 60px; font-size:13pt; border-radius: 5px;" onClick="javascript:history.back();">취소</button> 
	         </td>
      	</tr>
		</tbody>
	</table>
	</form>
	</div>
			<form name="loginFrm">
		<input type="hidden" name="userid" value="${requestScope.userid}" />
		<input type="hidden" name="pwd"    value="${requestScope.pwd}" />
		</form>
</div>


<jsp:include page="../../WEB-INF/footer.jsp" />








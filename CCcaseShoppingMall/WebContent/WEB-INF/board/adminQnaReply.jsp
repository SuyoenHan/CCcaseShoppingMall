<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
		request.setCharacterEncoding("UTF-8"); 	
		String fk_qnano = request.getParameter("fk_qnano");
		String fk_adminid = request.getParameter("fk_adminid"); 
		String cmtcontent= request.getParameter("cmtcontent");
		
		if(cmtcontent != null){
			session.setAttribute("fk_qnano", fk_qnano);
			session.setAttribute("fk_adminid", fk_adminid);
			session.setAttribute("cmtcontent", cmtcontent);
		}

		fk_qnano = (String)session.getAttribute("fk_qnano");
		fk_adminid = (String)session.getAttribute("fk_adminid");
		cmtcontent= (String)session.getAttribute("cmtcontent");
		
		response.sendRedirect("adminQnaDetail.jsp");
		
%>

<div>	
		
  		<form name="qnaReplyDetailForm">
  			<table style="width: 700px; border: 1px; border-color: lightgray;">
  				 <tr>
  				 	<td style="display: none"><%=fk_qnano%></td>
		            <td class="title">등록일</td>
		            <td>${requestScope.qrvo.cmtregisterday}</td>
		        </tr>
		        <tr>
		            <td id="title">
		               글내용
		            </td>           
		            <td><%=cmtcontent%></td>        
		        </tr>						        	
  			</table>
  		</form>
  		
  		</div>
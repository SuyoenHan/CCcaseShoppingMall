<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
		request.setCharacterEncoding("UTF-8"); 	
		String fk_adminid = request.getParameter("fk_adminid"); 
		String cmtcontent= request.getParameter("cmtcontent");
		
		if(cmtcontent != null){
			session.setAttribute("fk_adminid", fk_adminid);
			session.setAttribute("cmtcontent", cmtcontent);
		}

		fk_adminid = (String)session.getAttribute("fk_adminid");
		cmtcontent= (String)session.getAttribute("cmtcontent");
		
		response.sendRedirect("adminQnaList.jsp");
%>
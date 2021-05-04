<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
		request.setCharacterEncoding("UTF-8"); 
		String fk_adminid = request.getParameter("fk_adminid");
		
		if(fk_adminid!=null){
			session.setAttribute("fk_adminid", fk_adminid);
		}

		fk_adminid= (String)session.getAttribute("fk_adminid");
		
		response.sendRedirect("eventList.jsp");
%>
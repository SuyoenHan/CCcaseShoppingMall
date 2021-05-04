<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
		String eventno = request.getParameter("eventno");
		session.setAttribute("eventno", eventno);
		
		eventno = (String)session.getAttribute("eventno");
		
		response.sendRedirect("eventList.jsp");
%>

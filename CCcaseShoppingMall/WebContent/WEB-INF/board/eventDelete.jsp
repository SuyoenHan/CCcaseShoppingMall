<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.model.EventDAO"  %>

<%
		int eventno = Integer.parseInt(request.getParameter("eventno"));
		
		EventDAO edao = new EventDAO();
		edao.deleteEvent(eventno);
		
		response.sendRedirect("eventList.jsp");
%>

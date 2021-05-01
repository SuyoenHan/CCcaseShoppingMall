<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.model.QnaDAO"  %>

<%
		String qnano = request.getParameter("qnano");
		session.setAttribute("qnano", qnano);
		
		qnano = (String)session.getAttribute("qnano");
		
		response.sendRedirect("qnaList.jsp");
%>

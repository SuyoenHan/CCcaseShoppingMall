<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.model.QnaDAO"  %>

<%
		int qnano = Integer.parseInt(request.getParameter("qnano"));
		
		QnaDAO qdao = new QnaDAO();
		qdao.deleteQna(qnano);
		
		response.sendRedirect("qnaList.jsp");
%>

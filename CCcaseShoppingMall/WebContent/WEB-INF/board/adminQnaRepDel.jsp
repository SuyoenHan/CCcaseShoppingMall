<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.model.QnaDAO"  %>

<%
		int cmtno = Integer.parseInt(request.getParameter("cmtno"));
		
		session.setAttribute("cmtno", cmtno);

		QnaDAO qdao = new QnaDAO();
		qdao.deleteQnaRep(cmtno);
		
		response.sendRedirect("qnaList.jsp");
%>
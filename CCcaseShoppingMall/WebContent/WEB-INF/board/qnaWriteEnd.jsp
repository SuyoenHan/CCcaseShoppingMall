<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
		request.setCharacterEncoding("UTF-8"); 
		String fk_userid = request.getParameter("fk_userid");
		String email = request.getParameter("email");
		
		if(fk_userid!=null && email!=null){
			session.setAttribute("fk_userid", fk_userid);
			session.setAttribute("email",email);
		}

		fk_userid= (String)session.getAttribute("fk_userid");
		email = (String)session.getAttribute("email");
		
		response.sendRedirect("qnaList.jsp");
%>
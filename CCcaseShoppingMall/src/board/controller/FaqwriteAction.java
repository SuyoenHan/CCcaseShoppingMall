package board.controller;



import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.AdminVO;
import board.model.*;
import common.controller.AbstractController;


public class FaqwriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		
		HttpSession session = request.getSession();
		AdminVO avo = (AdminVO)session.getAttribute("adminUser");
		
		String method = request.getMethod();
		
		if(!"GET".equalsIgnoreCase(method)) { //POST 방식일때
		
			String ftitle = request.getParameter("ftitle");
	   	    String adminid = request.getParameter("adminid");
	   	    String fregisterdate = request.getParameter("fregisterdate");
	   	    String fcontent = request.getParameter("fcontent");
	   	    
	   	    FaqVO fvo = new FaqVO();
	   	    fvo.setFtitle(ftitle);
	   	    fvo.setFk_adminid(adminid);
	   	    fvo.setFregisterdate(fregisterdate);
	   	    fvo.setFcontent(fcontent);
	   	   //  System.out.println(fcontent);
	   	    
	   	    InterFaqDAO fdao = new FaqDAO();
	   	   
	   	    int n = fdao.faqInsert(fvo);
	   	 
	   	    if(n==1) {
	   	    	
	   	    	
	   	    	String message = "FAQ 글쓰기 등록이 완료되었습니다.";
				String loc = request.getContextPath()+"/board/faqList.cc";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
	   	    }
	   	    
		
		}
		else {//GET 방식일때
			if(avo!=null) {
				
				request.setAttribute("avo", avo);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/board/faqwrite.jsp");
			}
			else {
				String message = "FAQ 글쓰기는 관리자만 접근이 가능합니다.";
				String loc = "javascript:location.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}

		}
	
	}

}

package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.AdminVO;
import board.model.*;
import common.controller.AbstractController;

public class NoticewriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		AdminVO avo = (AdminVO)session.getAttribute("adminUser");
		
		String method = request.getMethod();
		
		if(!"GET".equalsIgnoreCase(method)) { //POST 방식일때
		
			String ntitle = request.getParameter("ntitle");
	   	    String adminid = request.getParameter("adminid");
	   	    String nregisterdate = request.getParameter("nregisterdate");
	   	    String ncontent = request.getParameter("ncontent");
	   	    
	   	    NoticeVO nvo = new NoticeVO();
	   	    nvo.setNtitle(ntitle);
	   	    nvo.setFk_adminid(adminid);
	   	    nvo.setNregisterdate(nregisterdate);
	   	    nvo.setNcontent(ncontent);
	   	   //  System.out.println(ncontent);
	   	    
	   	    InterNoticeDAO ndao = new NoticeDAO();
	   	   
	   	    int n = ndao.noticeInsert(nvo);
	   	 
	   	    if(n==1) {
	   	    	
	   	    	
	   	    	String message = "공지사항 글쓰기 등록이 완료되었습니다.";
				String loc = request.getContextPath()+"/board/noticeList.cc";
				
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
				super.setViewPage("/WEB-INF/board/noticewrite.jsp");
			}
			else {
				String message = "공지사항 글쓰기는 관리자만 접근이 가능합니다.";
				String loc = "javascript:location.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}

		}
	
	}

}

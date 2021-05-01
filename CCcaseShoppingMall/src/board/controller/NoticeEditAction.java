package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.AdminVO;
import board.model.*;
import common.controller.AbstractController;

public class NoticeEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		AdminVO avo = (AdminVO)session.getAttribute("adminUser");
	
		request.setAttribute("avo", avo);
		
		
		String method = request.getMethod();
		
		String noticeno = request.getParameter("noticeno");
		
		if("GET".equalsIgnoreCase(method)) {
			//GET방식이라면
			
			InterNoticeDAO ndao = new NoticeDAO();
			
			NoticeVO nvo = ndao.noticeEditOneView(noticeno);
			
			request.setAttribute("nvo", nvo);
			
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/noticeEdit.jsp");
			
		}
		
		else {
			//post방식이라면 update해준다.
			
			
			String noticeno1 =request.getParameter("noticeno");
			String ntitle = request.getParameter("ntitle");
	   	    String adminid = request.getParameter("adminid");
	   	   
	   	   
	   	// !!!! 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드) 작성하기 !!!! // 
	   	   String ncontent = request.getParameter("ncontent");
	   	   ncontent=ncontent.replaceAll("<", "&lt;"); // textarea에 장난치지 못하도록 < 를 바꾸어줌
	   	   ncontent=ncontent.replaceAll(">", "&gt;");
          //이것을 꼭 넣어주어야 공격을 당하지 않는다 
           
           //입력한 내용에서 엔터는<br>로 변환시키기
	   	   ncontent=ncontent.replaceAll("\r\n", "<br>");
	           
	       /////////////////////////////////////////////////////////////// 
	   	    
	   	    
	   	    
	   	    NoticeVO nvo = new NoticeVO();
	   	    nvo.setNoticeno(Integer.parseInt(noticeno1));
	   	    nvo.setNtitle(ntitle);
	   	    nvo.setFk_adminid(adminid);
	   	    nvo.setNcontent(ncontent);
	   	 
	   	    
	   	    InterNoticeDAO ndao = new NoticeDAO();
	   	   
	   	    int n = ndao.noticeEditUpdate(nvo);
	   	 
	   	    String message = "";
	   	    String loc ="";
	   	    if(n==1) {
	   	    	
	   	    	message = "공지사항 글쓰기 수정이 완료되었습니다.";
	   	    	loc =request.getContextPath()+"/board/noticeList.cc";
	   	    
	   	    }
	   	    else {
	   	    	message = "공지사항 글쓰기 수정이 실패되었습니다.";
	   	    	loc ="javascript:history.back()";
	   	   
	   	    }
	   
		   	 request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setViewPage("/WEB-INF/msg.jsp");
			
		
		
			
		}
		
		
		
	}


}

package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.AdminVO;
import board.model.FaqDAO;
import board.model.FaqVO;
import board.model.InterFaqDAO;
import common.controller.AbstractController;

public class FaqEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		AdminVO avo = (AdminVO)session.getAttribute("adminUser");
	
		request.setAttribute("avo", avo);
		
		
		String method = request.getMethod();
		
		String faqno = request.getParameter("faqno");
		
		if("GET".equalsIgnoreCase(method)) {
			//GET방식이라면
			
			InterFaqDAO fdao = new FaqDAO();
			
			FaqVO fvo = fdao.faqEditOneView(faqno);
			
			request.setAttribute("fvo", fvo);
			
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/faqEdit.jsp");
			
		}
		
		else {
			//post방식이라면 update해준다.
			
			
			String faqno1 =request.getParameter("faqno");
			String ftitle = request.getParameter("ftitle");
	   	    String adminid = request.getParameter("adminid");
	   	   
	   	   
	   	// !!!! 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드) 작성하기 !!!! // 
	   	   String fcontent = request.getParameter("fcontent");
	   	   fcontent=fcontent.replaceAll("<", "&lt;"); // textarea에 장난치지 못하도록 < 를 바꾸어줌
	   	   fcontent=fcontent.replaceAll(">", "&gt;");
          //이것을 꼭 넣어주어야 공격을 당하지 않는다 
           
           //입력한 내용에서 엔터는<br>로 변환시키기
	   	   fcontent=fcontent.replaceAll("\r\n", "<br>");
	           
	       /////////////////////////////////////////////////////////////// 
	   	    
	   	    
	   	    
	   	    FaqVO fvo = new FaqVO();
	   	    fvo.setFaqno(Integer.parseInt(faqno1));
	   	    fvo.setFtitle(ftitle);
	   	    fvo.setFk_adminid(adminid);
	   	    fvo.setFcontent(fcontent);
	   	 
	   	    
	   	    InterFaqDAO fdao = new FaqDAO();
	   	   
	   	    int n = fdao.faqEditUpdate(fvo);
	   	 
	   	    String message = "";
	   	    String loc ="";
	   	    if(n==1) {
	   	    	
	   	    	message = "FAQ 글쓰기 수정이 완료되었습니다.";
	   	    	loc =request.getContextPath()+"/board/faqList.cc";
	   	    
	   	    }
	   	    else {
	   	    	message = "FAQ 글쓰기 수정이 실패되었습니다.";
	   	    	loc ="javascript:history.back()";
	   	   
	   	    }
	   
		   	 request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setViewPage("/WEB-INF/msg.jsp");
			
		
		
			
		}
		
		
		
	}

}

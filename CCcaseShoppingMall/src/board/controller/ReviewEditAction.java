package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;


public class ReviewEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		String reviewno = request.getParameter("reviewno");
		
		if("GET".equalsIgnoreCase(method)) {
			
			InterReviewDAO rdao = new ReviewDAO();
			
			ReviewVO rvo = rdao.revEditOneView(reviewno);
			
			request.setAttribute("rvo", rvo);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/reviewEdit.jsp");
			
		}
		else {
		String goBackURL = request.getParameter("goBackURL");
		request.setAttribute("goBackURL", goBackURL);
		
		reviewno = request.getParameter("reviewno");
		String rvtitle = request.getParameter("rvtitle");
		
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/board/reviewEdit.cc");
		}
	}

}

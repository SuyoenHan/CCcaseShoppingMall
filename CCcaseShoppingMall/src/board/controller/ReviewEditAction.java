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
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String method = request.getMethod();
		String userid = request.getParameter("fk_userid");
		
		if(super.checkLogin(request)) {
		
			String reviewno = request.getParameter("reviewno");
			
			if("POST".equalsIgnoreCase(method)) {
				
				userid = loginuser.getUserid();
				
				InterReviewDAO rdao = new ReviewDAO();
				ReviewVO rvo = rdao.getReviewContents(userid , reviewno);
				
				request.setAttribute("rvo", rvo);
				
				String rvcontent = request.getParameter("rvcontent");
				rvcontent = rvcontent.replaceAll("<", "&lt;");
				rvcontent = rvcontent.replaceAll(">", "&gt;");
				
				rvcontent = rvcontent.replaceAll("\r\n","<br>");
				
				int n = rdao.revEditUpdate(rvo);
				
				String message = "";
				String loc ="";
				
				if(n==1) {
					message = "리뷰 수정이 완료되었습니다.";
					loc = request.getContextPath() + "/board/reviewList.cc";
				}
				else {
					message = "리뷰 수정에 실패하였습니다.";
					loc = "javascript:history.back()";
				}
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				// super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			else {
				InterReviewDAO rdao = new ReviewDAO();
				
				ReviewVO rvo = rdao.revEditOneView(reviewno);
				
				request.setAttribute("rvo", rvo);
			}
		}
		else {
			String message = "로그인 후 사용 가능합니다!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
	}

}

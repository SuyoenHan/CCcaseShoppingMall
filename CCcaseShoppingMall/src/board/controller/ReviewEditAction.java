package board.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.ProductDetailVO;


public class ReviewEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			String rvtitle = request.getParameter("rvtitle");
			String satisfaction = request.getParameter("satisfaction");
			String rvcontent = request.getParameter("rvcontent");
			
			
			ReviewVO rvo = new ReviewVO();
			rvo.setRvtitle(rvtitle);
			rvo.setSatisfaction(Integer.parseInt(satisfaction));
			rvo.setRvcontent(rvcontent);
			
			InterReviewDAO rdao = new ReviewDAO();
			
			try {
			int n = rdao.revEditUpdate(rvo);
			
			String message = "";
			String loc = "";
			
			if(n==1) {
				
				message = "글을 성공적으로 수정하였습니다.";
				loc="javascript:history.back()";
				
			}
			else {
				message="글 수정에 실패하였습니다.";
				loc="javascript:history.back()";
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			} catch(SQLException e) {
				e.printStackTrace();
				
				super.setRedirect(true);
				super.setViewPage(request.getContextPath() + "/error.cc");
			}
		}
		else {
			
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			String reviewno =  request.getParameter("reviewno");
			InterReviewDAO rdao = new ReviewDAO();
			
			ReviewVO rvo  = rdao.revEditOneView(reviewno);
			
			ProductDetailVO pdvo = rdao.getProdInfo(reviewno);
			
			request.setAttribute("pdvo", pdvo);
			request.setAttribute("rvo", rvo);
			
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/reviewEdit.jsp");
			
			
		}
	}

}

package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;

public class ReviewOneDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 *** //
		String goBackURL = request.getParameter("goBackURL");
		request.setAttribute("goBackURL", goBackURL);
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String reviewimage1 = request.getParameter("reviewimage1");
		
		InterReviewDAO rdao = new ReviewDAO();
		ReviewVO rvo = rdao.reviewOneDetail(reviewimage1);
		
		request.setAttribute("rvo", rvo);
		request.setAttribute("loginuser", loginuser);
		
		String reviewno = request.getParameter("reviewno");
		
		// 조회수 증가시키기
		if(reviewno != null) {
			rdao.updateViewCount(reviewno);
		}
		
		// super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/reviewOneDetail.jsp");

		}
		
	}



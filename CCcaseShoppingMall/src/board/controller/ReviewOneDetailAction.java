package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.*;
import common.controller.AbstractController;

public class ReviewOneDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
		
		String reviewimage1 = request.getParameter("reviewimage1");
		InterReviewDAO rdao = new ReviewDAO();
		ReviewVO rvo = rdao.reviewOneDetail(reviewimage1);
		
		request.setAttribute("rvo", rvo);
		
		// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 *** //
		String goBackURL = request.getParameter("goBackURL");
		request.setAttribute("goBackURL", goBackURL);
		// super.setRedirect(false);
		super.setViewPage("/WEB-INF/board/reviewOneDetail.jsp");
		}
		
	}

}

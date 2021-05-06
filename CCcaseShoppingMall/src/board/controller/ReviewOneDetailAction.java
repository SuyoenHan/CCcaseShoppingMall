package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.*;
import common.controller.AbstractController;
import product.model.ProductVO;

public class ReviewOneDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 *** //
		String goBackURL = request.getParameter("goBackURL");
		request.setAttribute("goBackURL", goBackURL);
		
		HttpSession session = request.getSession();
		ReviewVO rvo = (ReviewVO) session.getAttribute("rvo");
		
		String reviewno = rvo.getReviewno();
		
		InterReviewDAO rdao = new ReviewDAO();
		rvo = rdao.reviewOneDetail(reviewno);
		
		request.setAttribute("rvo", rvo);
		
		// 해당 리뷰의 구매 제품 가져오기 
		ProductVO pvo = rdao.selectProduct(reviewno);
		
		request.setAttribute("pvo", pvo);
		
		// 조회수 증가시키기
		if(reviewno != null) {
			rdao.updateViewCount(reviewno);
		}
		
		// super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/reviewOneDetail.jsp");

		}
		
	}



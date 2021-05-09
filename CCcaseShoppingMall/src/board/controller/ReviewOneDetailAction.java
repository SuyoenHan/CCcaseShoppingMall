package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.ProductDetailVO;
import product.model.ProductVO;

public class ReviewOneDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 *** //
		String goBackURL = request.getParameter("goBackURL");
		request.setAttribute("goBackURL", goBackURL);
		
		
		String reviewno = request.getParameter("reviewno");
		InterReviewDAO rdao = new ReviewDAO();
		ReviewVO rvo = rdao.reviewOneDetail(reviewno);
		request.setAttribute("rvo", rvo);
		
		request.setAttribute("reviewno", reviewno);
		// 해당리뷰 구매제품의 스펙번호 알아오기 
		String odetailno= rvo.getFk_odetailno();		
		int snum= rdao.getSnumByReviewno(odetailno);
		
		  /*
		 		snum=-1  해당 pnum 또는 odetailno 존재하지 않음
		 		snum=0  베스트상품
		 		snum=1    신상품
		  */
		request.setAttribute("snum", snum);
		
		// 해당 리뷰의 구매 제품 가져오기 
		ProductVO pvo = rdao.selectProduct(reviewno);
		request.setAttribute("pvo", pvo);
		
		// pnum 알아오기
		ProductDetailVO pdvo = rdao.getPnum(reviewno);
		request.setAttribute("pdvo", pdvo);
		
		// 조회수 증가시키기
		if(reviewno != null) {
			rdao.updateViewCount(reviewno);
		}
		
		
		
		// super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/reviewOneDetail.jsp");

		}
		
	}



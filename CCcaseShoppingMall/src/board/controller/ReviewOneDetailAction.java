package board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.*;
import common.controller.AbstractController;

public class ReviewOneDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
		
		String rvtitle = request.getParameter("rvtitle");
		
		InterReviewDAO rdao = new ReviewDAO();
		ReviewVO rvo = rdao.reviewOneDetail(rvtitle);
		
		if(rvo == null) {
			String message = "검색하신 리뷰는 존재하지 않습니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
		}
		else {
			request.setAttribute("rvo", rvo);
			// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 *** //
			String goBackURL = request.getParameter("goBackURL");
			request.setAttribute("goBackURL", goBackURL);
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/reviewOneDetail.jsp");
		}
		
		

		}
		
	}

}

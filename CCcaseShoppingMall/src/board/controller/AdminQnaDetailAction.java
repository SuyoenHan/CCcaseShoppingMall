package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.AdminVO;
import board.model.InterQnaDAO;
import board.model.QnaDAO;
import board.model.QnaVO;
import common.controller.AbstractController;


public class AdminQnaDetailAction extends AbstractController {

			
			@Override
			public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

				// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 *** //
				String goBackURL = request.getParameter("goBackURL");
				request.setAttribute("goBackURL", goBackURL); 
				
				HttpSession session = request.getSession();
				AdminVO adminUser = (AdminVO) session.getAttribute("adminUser");
				
				String qtitle = request.getParameter("qtitle");
				String qnano = request.getParameter("qnano");
				
				InterQnaDAO qdao = new QnaDAO();
				QnaVO qvo = qdao.qnaDetail(qnano);
				
				request.setAttribute("qvo", qvo);
				
				if( adminUser != null) { // 로그인했으면
					
					// 조회수 증가
					qdao.updateViewCount(qvo.getQnano());
	
					super.setViewPage("/WEB-INF/board/adminQnaDetail.jsp");
					
				}
				else {
					// 로그인을 안 했으면
					String message = "글을 보려면 먼저 로그인을 하세요!";
					String loc = "javascript:history.back()";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
			}
		}
}

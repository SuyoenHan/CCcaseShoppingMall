package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;

public class QnaDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 *** //
		String goBackURL = request.getParameter("goBackURL");
		request.setAttribute("goBackURL", goBackURL); 
				
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String qnano = request.getParameter("qnano");
		
		InterQnaDAO qdao = new QnaDAO();
		QnaVO qvo = qdao.qnaDetail(qnano);
		
		request.setAttribute("qvo", qvo);
		
		if( loginuser != null) { // 로그인했으면
		
		// 로그인 유저와 작성자 아이디가 다르면 조회수 증가
			if( !qvo.getFk_userid().equals(loginuser.getUserid()) ) {
				qdao.updateViewCount(qvo.getQnano());
			}
			
/*
			// 비공개 QNA 글 열람 자격 검사
			if("1".equals(qvo.getQstatus()) ) { // 비공개 글이라면
				
				if( loginuser.getUserid().equals(qvo.getFk_userid()) ) {
					// 로그인한 사용자가 자신의 글을 보는 경우
				//	super.setRedirect(false); 
					super.setViewPage("/WEB-INF/board/qnaDetail.jsp");
				}
				else {
					// 로그인한 사용자가 다른 사용자의 글을 보는 경우
					String message = "비공개 글은 작성자 본인 외에는 볼 수 없습니다..";
					String loc = "javascript:history.back()";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
					return;
				}		
			}
			else {// 비공개 글이 아니라면*/
//			}				
			
				//super.setRedirect(false);
				super.setViewPage("/WEB-INF/board/qnaDetail.jsp");
			
		}
			else {
				// 로그인을 안 했으면 누구의 글을 봐도 조회수 증가
				qdao.updateViewCount(qvo.getQnano());				
		
				super.setViewPage("/WEB-INF/board/qnaDetail.jsp");
			}
	}

}

package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.InterQnaDAO;
import board.model.QnaDAO;
import board.model.QnaVO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class MemberWriteListMainAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

				
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String userid = request.getParameter("userid");
		
		InterQnaDAO qdao = new QnaDAO();
		QnaVO qvo = qdao.qnaMywrite(userid);
		
		request.setAttribute("qvo", qvo);
		
		if( loginuser != null) { // 로그인했으면
	
				if( loginuser.getUserid().equals(qvo.getFk_userid()) ) {
					// 로그인한 사용자가 자신의 글을 보는 경우
				//	super.setRedirect(false); 
					super.setViewPage("/WEB-INF/member/memberWriteListMain.jsp");
				}
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

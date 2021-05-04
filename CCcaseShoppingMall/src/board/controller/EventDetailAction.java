package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.AdminVO;
import board.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;

public class EventDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 *** //
		String goBackURL = request.getParameter("goBackURL");
		request.setAttribute("goBackURL", goBackURL); 
				
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		AdminVO adminUser = (AdminVO) session.getAttribute("adminUser");
		
		String eventno = request.getParameter("eventno");
		
		InterEventDAO edao = new EventDAO();
		EventVO evo = edao.eventDetail(eventno);
		
		request.setAttribute("evo", evo);
		
		//	super.setRedirect(false); 
		super.setViewPage("/WEB-INF/board/eventDetail.jsp");
		
		// 글을 보는 사람이 관리자만 아니라면 조회수 증가
		if( loginuser != null || loginuser == null) {
			if(adminUser == null)
				edao.updateViewCount(evo.getEventno());
		}
	}
}

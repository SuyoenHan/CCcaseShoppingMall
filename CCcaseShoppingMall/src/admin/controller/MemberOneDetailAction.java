package admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.AdminVO;
import common.controller.AbstractController;
import member.model.*;




public class MemberOneDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// == 관리자(admin)로 로그인 했을 때만 조회가 가능하도록 한다. == //
		HttpSession session = request.getSession();
		AdminVO aloginuser = (AdminVO) session.getAttribute("loginuser");
	
		// 관리자(admin)로 로그인 했을 경우
		if(aloginuser == null ) {
		
		String userid = request.getParameter("userid");
		InterMemberDAO mdao = new MemberDAO();
		MemberVO mvo = mdao.memberOneDetail(userid);
		
		request.setAttribute("mvo", mvo);
		
		// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 *** //
		String goBackURL = request.getParameter("goBackURL");
		request.setAttribute("goBackURL", goBackURL);
		// super.setRedirect(false);
		super.setViewPage("/WEB-INF/admin/memberOneDetail.jsp");
		}
		else {
			// 로그인을 안한 경우 또는 일반사용자로 로그인 한 경우
			String message = "관리자만 접근이 가능합니다.";
	        String loc = "javascript:history.back()";
	         
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	         
	      //   super.setRedirect(false);
	         super.setViewPage("/WEB-INF/adminMsg.jsp");
		}
	}

}

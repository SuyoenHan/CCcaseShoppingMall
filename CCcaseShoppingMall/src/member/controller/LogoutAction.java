package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class LogoutAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 로그아웃 처리하기
		HttpSession session = request.getSession(); // 세션불러오기
		
		///////////////////////////////////////////////////////////////////////////////////////////
		// 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임. 
		String goBackURL =(String)session.getAttribute("goBackURL");
		if(goBackURL!=null) {
			goBackURL = request.getContextPath()+"/"+goBackURL;
			
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String login_userid=loginuser.getUserid();
		// 두번째 방법 : WAS 메모리 상에서 세션을 아예 삭제해버리기 
		session.invalidate();
		
		super.setRedirect(true);
		if(goBackURL != null && !"admin".equals(login_userid)) {
			//관리자가 아닌 일반 사용자로 들어와서 돌아갈 페이지가 있다면 돌려준다.
			super.setViewPage(goBackURL);
		}
		else {
			//돌아갈 페이지가 없거나 또는 관리로 로그아웃을 하면 무조건 /MYMVC/index.up
		super.setViewPage(request.getContextPath()+"/home.up");
		// WAS 사이트 페이지에 연결만 하면 세션은 자동적으로 다시 생성된다.
		}
	  }
	}

}

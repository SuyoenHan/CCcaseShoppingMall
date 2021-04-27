package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import member.model.MemberVO;

public abstract class AbstractController implements InterCommand {

	private boolean isRedirect = false;   // false면 view단 페이지로  forward , true면 sendRedirect 로 페이지(url)이동
	private String viewPage;
	
	
	public boolean isRedirect() {
		return isRedirect;
	}
	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}
	
	public String getViewPage() {
		return viewPage;
	}
	public void setViewPage(String viewPage) {
		this.viewPage = viewPage;
	}

	//  로그인 검사=> 로그인 했으면 true 를 리턴, 안했으면 false 리턴
	public boolean checkLogin(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser != null) {// 로그인 한 경우
			return true;
		}
		else {// 로그인 안한 경우
			return false;
		}
	}
}

package common.controller;

import javax.servlet.http.*;

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
	 
	//  로그인 유무 검사
	public boolean checkLogin(HttpServletRequest request) {
		
		HttpSession session= request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser !=null) {
			return true;
		}
		else {
			return false;
		}
	}
}

package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;

public class MyCartAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session= request.getSession();
		MemberVO loginuser= (MemberVO)session.getAttribute("loginuser");
		
		
		if(loginuser!=null) { // 로그인 한 경우
			
			request.setAttribute("userid", loginuser.getUserid());
			request.setAttribute("name", loginuser.getName());
			
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/myCart.jsp");
			return;
			
		}
			
		else { // 로그인 하지 않은 경우
			String message="로그인 후 이용 가능합니다.";
			String loc="javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");	
			return;
		}
		
			
	
	}

}

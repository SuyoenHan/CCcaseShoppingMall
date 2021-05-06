package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class MemberEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			if(super.checkLogin(request)) {
				//로그인을 했으면
				
				String userid = request.getParameter("userid");
				String pwd = request.getParameter("pwd");
				HttpSession session =request.getSession();
				MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
				
				if(loginuser.getUserid().equals(userid)) {
					request.setAttribute("pwd",pwd);
					System.out.println(pwd);
					//로그인한 사용자가 자신의 정보를 수정하는 경우
				      //   super.setRedirect(false);
			         super.setViewPage("/WEB-INF/member/memberEdit.jsp");
					
				}
				else {
					//로그인한 사용자가 다른 사용자의 정보를 수정하는 경우
					String message = "다른 사용자의 정보변경은 불가합니다.!!";
			         String loc = "javascript:history.back()";
			         
			         request.setAttribute("message", message);
			         request.setAttribute("loc", loc);
			         
			      //   super.setRedirect(false);
			         super.setViewPage("/WEB-INF/msg.jsp");
			         
			         return;
				}
			}
			else {
				//로그인을 안했으면
				String message = "마이페이지는 로그인 후 이용가능합니다.";
		         String loc = "javascript:history.back()";
		         
		         request.setAttribute("message", message);
		         request.setAttribute("loc", loc);
		         
		      //   super.setRedirect(false);
		         super.setViewPage("/WEB-INF/msg.jsp");
			}
		}

}

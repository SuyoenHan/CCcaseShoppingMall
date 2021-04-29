package member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class PasswdCheckAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session =  request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		//System.out.println(loginuser);
		if(loginuser!=null){
		
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			paraMap.put("pwd", pwd);
			
			InterMemberDAO mdao = new MemberDAO();
			
			boolean mvo = mdao.passwdcheck(paraMap);
			
			request.setAttribute("mvo", mvo);
			
			if(mvo==true) {
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/memberEdit.jsp");
			
			return;
			}
			else {
				// 로그인을 안한 경우 또는 일반사용자로 로그인 한 경우 
				String message = "비밀번호가 틀립니다!";
		         String loc = "javascript:history.back()";
		         
		         request.setAttribute("message", message);
		         request.setAttribute("loc", loc);
		         
		      //   super.setRedirect(false);
		         super.setViewPage("/WEB-INF/msg.jsp");
			}
		}
		else {
			// 로그인을 안한 경우 또는 일반사용자로 로그인 한 경우 
				String message = "로그인하세요.";
		         String loc = "javascript:history.back()";
		         
		         request.setAttribute("message", message);
		         request.setAttribute("loc", loc);
		         
		      //   super.setRedirect(false);
		         super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}
		

}

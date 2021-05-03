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


public class LoginAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();  // "GET" 또는 "POST" 
		
		if(!"POST".equalsIgnoreCase(method)) {
			// POST 방식으로 넘어온 것이 아니라면
			
			String message = "비정상적인 경로로 들어왔습니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");

		}
		
		else {
			// POST 방식으로 넘어온 것이라면
			
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			// ===> 클라이언트의 IP 주소를 알아오는 것   <=== //
			String clientip = request.getRemoteAddr();
			
			//System.out.println("확인용 clientip => " + clientip);
			// 확인용 clientip => 127.0.0.1 
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			paraMap.put("pwd", pwd);
			paraMap.put("clientip", clientip);
			
			InterMemberDAO mdao = new MemberDAO();


			super.setRedirect(false);
			super.setViewPage("/WEB-INF/login/loginForm.jsp");

			MemberVO loginuser = mdao.selectOneMember(paraMap);
			
			if(loginuser != null) {
				
				HttpSession session = request.getSession();
				// 메모리에 생성되어져 있는 session 을 불러오는 것이다.
				
				session.setAttribute("loginuser", loginuser);
				// session(세션)에 로그인 되어진 사용자 정보인 loginuser 을 키이름을 "loginuser" 으로 저장시켜두는 것이다.
				if(loginuser.getIdle() == 1) {
					// 원래는 휴면처리 되어진 사용자를 풀어주는 페이지로 이동해야 한다.
					request.setAttribute("userid", userid);
					
					session.invalidate();
					super.setViewPage("/WEB-INF/login/dormancy.jsp");
					
					return;  // 메소드 종료
				}
				if( loginuser.isRequirePwdChange() ) {
					// === 비밀번호를 변경한지가 3개월이 지난 경우 === 
					
					String message = "비밀번호를 변경하신지 3개월이 지났습니다. 암호를 변경하세요!!";
					String loc = request.getContextPath()+"/home.cc";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
					
					return;
				}
				
				else {
					super.setRedirect(true);
					super.setViewPage(request.getContextPath()+"/home.cc");
				}
			
			}
		
			if(loginuser == null) {
				String message = "아이디 또는 비밀번호를 확인해 주세요";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				//super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
			
		}
		
		

	}
		
}



package member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;

public class IdFindAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();  // "GET" 또는 "POST" 
		
		if("POST".equalsIgnoreCase(method)) {
			// 아이디 찾기 모달창에서 찾기 버튼을 클릭했을 경우 
			
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			
			InterMemberDAO mdao = new MemberDAO();
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("name", name);
			paraMap.put("email", email);
			String userid = mdao.findUserid(paraMap);
			
			if(userid != null) {
				request.setAttribute("userid", userid);
				super.setViewPage("/WEB-INF/login/idFindEnd.jsp");
				return;
			}
			else if(userid == null){
				String message = " 입력 하신 정보로 가입한 아이디가 존재하지 않습니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				//super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
			}
	
		}// end of if("POST".equalsIgnoreCase(method))---------------------------------
		
		
		request.setAttribute("method", method);
		

		super.setViewPage("/WEB-INF/login/idFind.jsp");
	}

}

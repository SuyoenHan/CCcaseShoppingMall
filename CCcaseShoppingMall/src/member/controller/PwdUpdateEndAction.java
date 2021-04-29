package member.controller;

import java.util.*;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;


public class PwdUpdateEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
	String userid = request.getParameter("userid");
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			String pwd = request.getParameter("pwd");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid",userid);
			paraMap.put("pwd",pwd);
			  
			InterMemberDAO mdao = new MemberDAO();
			int n = mdao.pwdUpdate(paraMap);
			
			request.setAttribute("n", n);
		}
		
		
		request.setAttribute("method", method);
		request.setAttribute("userid", userid);
		
		super.setViewPage("/WEB-INF/login/pwdUpdateEnd.jsp");                     
	}

}

package admin.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.*;
import common.controller.AbstractController;

public class AdLoginAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			
			String message = "비정상적인 경로로 들어왔습니다.";
			String loc = "javascript:history.back()"; // 이게 이전페이지로 가는 소스
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/adminMsg.jsp");
			
		}
		else {
			
			String adminId = request.getParameter("adminId");
			String adminPwd = request.getParameter("adminPwd");
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("adminId", adminId);
			paraMap.put("adminPwd", adminPwd);
			
			InterAdminDAO adao = new AdminDAO();
			AdminVO adminUser = adao.checkid(paraMap);
			
			if(adminUser != null) {
				HttpSession session = request.getSession();
				session.setAttribute("adminUser", adminUser);
				
				String message = adminUser.getAdminname()+"님 로그인되었습니다.";
				String loc = request.getContextPath()+"/admin.cc";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/adminMsg.jsp");
				return;
			}
			else {
				String message = "아이디랑 비밀번호를 다시 확인해주세요";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/adminMsg.jsp");
				return;
			}
			
		}
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/admin/adminLogin.jsp");
		
	}

}

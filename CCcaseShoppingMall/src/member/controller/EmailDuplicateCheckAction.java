package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.*;

public class EmailDuplicateCheckAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) { 
		
			String email = request.getParameter("email");
			
			InterMemberDAO dao = new MemberDAO();
			boolean isExists = dao.emailDuplicateCheck(email);
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("isExists", isExists);
			
			String json = jsonObj.toString();
			
			request.setAttribute("json", json);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
	}

}

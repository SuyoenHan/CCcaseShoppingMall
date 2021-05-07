package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import board.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;

public class ReviewDelAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser != null) {
			
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) {
				// "POST" 방식이라면
				
				InterReviewDAO rdao = new ReviewDAO();
				
				String reviewno = request.getParameter("reviewno");
				
				int n = rdao.revDeleteOne(reviewno);
				
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("n", n);
				
				String json = jsonObj.toString();
				request.setAttribute("json", json);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/jsonview.jsp");
				
			}
			else {
				String message = "비정상적인 경로를 통해 들어왔습니다!!";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/msg.jsp");
				
			}
		
		}
		else {
			String message = "로그인 후 사용 가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}

}

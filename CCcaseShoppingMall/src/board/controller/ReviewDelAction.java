package board.controller;

import java.sql.SQLException;

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
			
		String method = request.getMethod();
		
		
		if("GET".equalsIgnoreCase(method)) {
			 // GET 방식이라면
	         
	         String message = "비정상적인 경로로 들어왔습니다";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setViewPage("/WEB-INF/msg.jsp");
	         return;
		}
		else if("POST".equalsIgnoreCase(method) && super.checkLogin(request)){
				
			String reviewno = request.getParameter("reviewno");
				
				InterReviewDAO rdao = new ReviewDAO();
				
				int n = rdao.revDeleteOne(reviewno);
				
				JSONObject jsobj = new JSONObject();
				jsobj.put("n", n);
				
				String json = jsobj.toString();
				
				request.setAttribute("json", json);
				
				// super.setRedirect(false);
				super.setViewPage("/WEB-INF/jsonview.jsp");
				
				
		}
	}

}

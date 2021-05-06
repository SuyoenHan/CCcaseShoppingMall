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
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String userid = request.getParameter("userid");
		
		if(loginuser != null && userid.equals(loginuser.getUserid())) {
			
			ReviewVO rvo = new ReviewVO();
			
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) {
				// "POST" 방식이라면
				
				InterReviewDAO rdao = new ReviewDAO();
				
				int n = rdao.revDeleteOne(rvo);
				
				String message = "";
				
				if(n==1) {
					message="해당 리뷰가 삭제되었습니다.";
				}
				else {
					message="리뷰삭제를 실패하였습니다.";
				}
				
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("message", message);
				
				String json = jsonObj.toString();
				request.setAttribute("json", json);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/board/jsonview.jsp");
				
			}
			
		
		}
		
		
	}

}

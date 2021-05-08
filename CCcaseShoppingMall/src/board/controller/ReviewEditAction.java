package board.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;


public class ReviewEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			String rvtitle = request.getParameter("rvtitle");
			String rvcontent = request.getParameter("rvcontent");
			String rregisterdate =request.getParameter("rregisterdate");
			String fk_userid  =request.getParameter("fk_userid");
			String reviewno = request.getParameter("reviewno");
			String satisfaction = request.getParameter("satisfaction");
			
			InterReviewDAO rdao = new ReviewDAO();
			
			try {
			int n = rdao.revEditOneView(reviewno);
			
			String message = "";
			String loc = "";
			
			if(n==1) {
				
				message = "글을 성공적으로 수정하였습니다.";
				loc="request.getContextPath()+board/reviewOneDetail.cc?reviewno="+reviewno;
				
			}
			else {
				message="글 수정에 실패하였습니다.";
				loc="javascript:history.back()";
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			} catch(SQLException e) {
				e.printStackTrace();
				
				super.setRedirect(true);
				super.setViewPage(request.getContextPath() + "/error.cc");
			}
		}
		else {
			String message = "비정상적인 경로를 통해 들어왔습니다.!!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
		}
	}

}

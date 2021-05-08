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
			
		try {		
				InterReviewDAO rdao = new ReviewDAO();
				String reviewno = request.getParameter("reviewno");
				
				int n = rdao.revDeleteOne(reviewno);
				
				String message= "";
				String loc = "";
				
				System.out.println(reviewno);
				System.out.println(n);
				
				if(n==1) {
					message = "삭제되었습니다.";
					loc=request.getContextPath() + "/board/reviewList.cc"; // 
				}
				else {
					message = "삭제에 실패하였습니다.";
					loc = "javascript:history.back()";
				}
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				// super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
		} catch(SQLException e) {
			e.printStackTrace();
		}
		super.setViewPage(request.getContextPath() + "/error.cc");
	}

}

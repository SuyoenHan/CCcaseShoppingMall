package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;

public class ReviewEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String userid = request.getParameter("userid");
		
		if(loginuser != null && userid.equals(loginuser.getUserid())) {
		
			String method = request.getMethod();
			
			if(!"GET".equalsIgnoreCase(method)) {
				// "POST" 방식이라면 update
				
				
				String reviewno = request.getParameter("reviewno");
				String rvtitle = request.getParameter("rvtitle");
				String satisfaction = request.getParameter("sastisfaction");
				String reviewimage1 = request.getParameter("reviewimage1");
				String reviewimage2 = request.getParameter("reviewimage2");
				String reviewimage3 = request.getParameter("reviewimage3");
				String fk_pname = request.getParameter("fk_pname");
				String rregisterdate = request.getParameter("rregisterdate");
				
				// !!!! 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드) 작성하기 !!!! //
				String rvcontent = request.getParameter("rvcontent");
				rvcontent=rvcontent.replaceAll("<", "&lt;"); // textarea에 장난치지 못하도록 < 를 바꾸어줌
			   	rvcontent=rvcontent.replaceAll(">", "&gt;");
			   	rvcontent=rvcontent.replaceAll("\r\n", "<br>");
				
			   	
			   	ReviewVO rvo = new ReviewVO();
			   	rvo.setReviewno(Integer.parseInt(reviewno));
			   	rvo.setRvtitle(rvtitle);
			   	rvo.setRvcontent(rvcontent);
			   	rvo.setSatisfaction(Integer.parseInt(satisfaction));
			   	rvo.setFk_pname(fk_pname);
			   	rvo.setReviewimage1(reviewimage1);
			   	rvo.setReviewimage2(reviewimage2);
			   	rvo.setReviewimage3(reviewimage3);
			   	rvo.setRregisterdate(rregisterdate);
			   	
				InterReviewDAO rdao = new ReviewDAO();
				
				int n = rdao.revEditUpdate(rvo);
				
				String message="";
				String loc="";
				
				if(n == 1) {
					message="리뷰 수정이 완료되었습니다.";
					loc=request.getContextPath()+"board/reviewList.cc";
					
				}
				else {
					message = "리뷰 수정이 실패되었습니다.";
		   	    	loc ="javascript:history.back()";
				}
				
				request.setAttribute("message", message);
		        request.setAttribute("loc", loc);
		         
		        super.setViewPage("/WEB-INF/msg.jsp");
				
			}
			else {
				
				InterReviewDAO rdao = new ReviewDAO();
				
				String reviewno = request.getParameter("reviewno");
				
				ReviewVO rvo = rdao.revEditOneView(reviewno);
				
				request.setAttribute("rvo", rvo);
				
				// super.setRedirect(false);
				super.setViewPage("/WEB-INF/board/reviewEdit.jsp");
				
			}
			
			
			
		}
		
	}

}

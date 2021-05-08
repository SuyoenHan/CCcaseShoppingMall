package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.EventDAO;
import board.model.EventPartDAO;
import board.model.InterEventDAO;
import board.model.InterEventPartDAO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class GawibawiboEventAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

			
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		request.setAttribute("userid", loginuser.getUserid());
		
		
		String eventno = request.getParameter("eventno");
		request.setAttribute("eventno", eventno);
		InterEventDAO edao= new EventDAO();
		int m= edao.checkEventno(eventno);
		/*
	 		m==1인경우 해당 eventno 존재
	 		m==0인경우 해당 eventno 존재하지 않음
		*/
		
		if(m==0) {
			eventno="1";
		}
		
		String goBackURL= request.getParameter("goBackURL");
		request.setAttribute("goBackURL", goBackURL);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/board/eventGawiBawiBoDetail.jsp");
	     
		
		
	}

}

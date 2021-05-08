package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.AdminVO;
import board.model.EventDAO;
import board.model.EventVO;
import board.model.InterEventDAO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class CardGameEventAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		AdminVO adminUser = (AdminVO)session.getAttribute("adminUser");	
		
		if(loginuser!=null) { // 로그인한 경우
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
			
			EventVO evo= edao.eventDetail(eventno);
			String fk_adminid= evo.getFk_adminid();
			String title= evo.getTitle();
			String startdate= evo.getStartdate();
			String enddate= evo.getEnddate();
			String registerdate= evo.getRegisterdate();
			
			request.setAttribute("fk_adminid", fk_adminid);
			request.setAttribute("title", title);
			request.setAttribute("startdate", startdate);
			request.setAttribute("enddate", enddate);
			request.setAttribute("registerdate", registerdate);
			
			EventVO epvo= edao.prevEvent(eventno);			
			request.setAttribute("epvo", epvo);
			
			EventVO envo= edao.nextEvent(eventno);
			request.setAttribute("envo", envo);
			
			String goBackURL= request.getParameter("goBackURL");
			request.setAttribute("goBackURL", goBackURL);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/eventCardGame.jsp");
			return;
		}
		else if(adminUser!=null) {
			
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
			
			EventVO evo= edao.eventDetail(eventno);
			String fk_adminid= evo.getFk_adminid();
			String title= evo.getTitle();
			String startdate= evo.getStartdate();
			String enddate= evo.getEnddate();
			String registerdate= evo.getRegisterdate();
			
			request.setAttribute("fk_adminid", fk_adminid);
			request.setAttribute("title", title);
			request.setAttribute("startdate", startdate);
			request.setAttribute("enddate", enddate);
			request.setAttribute("registerdate", registerdate);
			
			EventVO epvo= edao.prevEvent(eventno);			
			request.setAttribute("epvo", epvo);
			
			EventVO envo= edao.nextEvent(eventno);
			request.setAttribute("envo", envo);
			
			String goBackURL= request.getParameter("goBackURL");
			request.setAttribute("goBackURL", goBackURL);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/eventCardGame.jsp");
		}
		else { // 로그인하지 않은 경우
			
			String message="로그인 후 이용 가능합니다.";
			String loc="javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");	
			return;	
		}
	}

}

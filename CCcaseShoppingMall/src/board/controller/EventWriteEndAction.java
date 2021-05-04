package board.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.*;
import common.controller.AbstractController;

public class EventWriteEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			// **** POST 방식으로 넘어온 것이라면 **** //
			
			String title = request.getParameter("title"); 
			String fk_adminid = request.getParameter("fk_adminid"); 
			String startdate = request.getParameter("startdate");
			String enddate = request.getParameter("enddate"); 
			String registerdate = request.getParameter("registerdate"); 
			String content = request.getParameter("content");
			
			EventVO evo = new EventVO(title, fk_adminid, startdate, enddate, registerdate, content);
			
			InterEventDAO edao = new EventDAO();
			
			try {
				int n = edao.writeEvent(evo);
				
				String message = "";
				String loc = "";

				if(n==1) {
					message = "이벤트 등록 성공";
					loc = request.getContextPath()+"/board/eventList.cc";  // 글 목록으로 이동한다.
				}
				else {
					message = "이벤트 등록 실패";
					loc = "javascript:history.back()";  // 이전페이지로 이동
				}
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
			}catch(SQLException e) {
				e.printStackTrace();
				
				super.setRedirect(true);
				super.setViewPage(request.getContextPath()+"/error.cc");
			}
		}// end of if("POST".equalsIgnoreCase(method))-----------------------------
		else {
			String message = "비정상적인 경로를 통해 들어왔습니다.!!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
		}
	}
}


package board.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.*;
import common.controller.AbstractController;

public class EventEditEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			// **** POST 방식으로 넘어온 것이라면 **** //
			
			String title = request.getParameter("title");
			String enddate = request.getParameter("enddate");
			String content = request.getParameter("content");
			int eventno = Integer.parseInt(request.getParameter("eventno"));
			
			EventVO evo = new EventVO(eventno, title, enddate, content);
			
			InterEventDAO edao = new EventDAO();

			try {
				int n = edao.editEvent(evo);

				String message = "";
				String loc = "";
				if(n==1) {

					message = "글 수정 성공";
					loc = request.getContextPath()+"/board/qnaDetail.cc?qnano="+eventno;  // 글 목록으로 이동한다.
				}
				else {
					message = "글 수정 실패";
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

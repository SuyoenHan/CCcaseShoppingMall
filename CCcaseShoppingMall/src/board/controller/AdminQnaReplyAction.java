package board.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.InterQnaDAO;
import board.model.QnaDAO;
import board.model.QnaVO;
import common.controller.AbstractController;

public class AdminQnaReplyAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			// **** POST 방식으로 넘어온 것이라면 **** //
			
			int fk_qnano = Integer.parseInt(request.getParameter("fk_qnano"));
			String fk_adminid = request.getParameter("fk_adminid"); 
			String cmtcontent = request.getParameter("cmtcontent");
			
			QnaVO qna = new QnaVO(fk_qnano, fk_adminid, cmtcontent);
			
			InterQnaDAO qdao = new QnaDAO();
			
			try {
				int n = qdao.replyQna(qna);
				
				String message = "";
				String loc = "";

				if(n==1) {
					message = "답글 쓰기 성공";
					loc = request.getContextPath()+"/board/qnaList.cc";  // 글 목록으로 이동한다.
				}
				else {
					message = "답글 쓰기 실패";
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

package board.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.InterQnaDAO;
import board.model.QnaDAO;
import common.controller.AbstractController;

public class AdminQnaRepDelAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int cmtno = Integer.parseInt(request.getParameter("cmtno"));
		
		InterQnaDAO qdao = new QnaDAO();

		try {
			int n = qdao.deleteQnaRep(cmtno);
			
			String message = "";
			String loc = "";
			
			if(n==1) {
				message = "삭제 성공";
				loc = request.getContextPath()+"/board/qnaList.cc";  // 글 목록으로 이동
			}
			else {
				message = "삭제 실패";
				loc = "javascript:history.back()";  // 이전페이지로 이동
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}catch(SQLException e) {
			e.printStackTrace();
			
//			super.setRedirect(false);
			super.setViewPage(request.getContextPath()+"/error.cc");
		}
		
	}

}

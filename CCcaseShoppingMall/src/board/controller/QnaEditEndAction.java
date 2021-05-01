package board.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.InterQnaDAO;
import board.model.QnaDAO;
import board.model.QnaVO;
import common.controller.AbstractController;

public class QnaEditEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			// **** POST 방식으로 넘어온 것이라면 **** //
			
			String qtitle = request.getParameter("qtitle");
			String fk_productid = request.getParameter("fk_productid");
			String qcontent = request.getParameter("qcontent");
			int qnano = Integer.parseInt(request.getParameter("qnano"));
			
			QnaVO qna = new QnaVO(qnano, qtitle, fk_productid, qcontent);
			
			InterQnaDAO qdao = new QnaDAO();

			try {
				int n = qdao.editQna(qna);

				String message = "";
				String loc = "";
				if(n==1) {

					message = "글 수정 성공";
					loc = request.getContextPath()+"/board/qnaDetail.cc?qnano="+qnano;  // 글 목록으로 이동한다.
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

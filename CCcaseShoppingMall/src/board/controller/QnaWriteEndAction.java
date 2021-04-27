package board.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.*;
import common.controller.AbstractController;

public class QnaWriteEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			// **** POST 방식으로 넘어온 것이라면 **** //
			
			String qtitle = request.getParameter("qtitle"); 
			String fk_userid = request.getParameter("fk_userid"); 
			String qemail = request.getParameter("qemail"); 
			String fk_productid = request.getParameter("fk_productid");
			String qstatus = request.getParameter("qstatus"); 
			String qnapwd = request.getParameter("qnapwd"); 
			String qcontent = request.getParameter("qcontent");
			
			QnaVO qna = new QnaVO(qtitle, fk_userid, qemail, fk_productid, qstatus, qnapwd, qcontent);
			
			InterQnaDAO qdao = new QnaDAO();
			
			try {
				int n = qdao.writeQna(qna);
				
				String message = "";
				String loc = "";
				
				if(n==1) {
					message = "글쓰기 성공";
					loc = request.getContextPath()+"/qnaList.cc";  // 글 목록으로 이동한다.
				}
				else {
					message = "글쓰기 실패";
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
		}
	}// end of if("POST".equalsIgnoreCase(method))-----------------------------
}


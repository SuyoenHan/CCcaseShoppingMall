package member.controller;




import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import board.model.InterQnaDAO;

import board.model.QnaDAO;
import board.model.QnaVO;
import common.controller.AbstractController;


public class MemberWriteListMainAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String userid = request.getParameter("userid");
		
         InterQnaDAO pdao = new QnaDAO();
         
         List<QnaVO> allList= pdao.writeAllList(userid);
         
         request.setAttribute("allList", allList);
        // System.out.println(allList);
         
		super.setViewPage("/WEB-INF/member/memberWriteListMain.jsp");
	}

}

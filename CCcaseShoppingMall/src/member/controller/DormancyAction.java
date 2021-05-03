package member.controller;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;


import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;



public class DormancyAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

			String userid = request.getParameter("userid");

			
			InterMemberDAO mdao = new MemberDAO();
			
			int n = mdao.dormancyClear(userid);
			request.setAttribute("n",n);
			
			
				
		super.setViewPage("/WEB-INF/login/dormancy.jsp");

	}

}

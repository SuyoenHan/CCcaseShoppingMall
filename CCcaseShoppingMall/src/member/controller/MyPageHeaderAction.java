package member.controller;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;


import common.controller.AbstractController;

public class MyPageHeaderAction extends AbstractController {
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String userid =request.getParameter("userid");
		System.out.println(userid);
		
		super.setViewPage("/WEB-INF/member/myPageHeader.jsp");
	
	}

}

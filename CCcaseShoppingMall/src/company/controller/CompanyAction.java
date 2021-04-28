package company.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class CompanyAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String uri= request.getRequestURI();		
		int index= uri.lastIndexOf("/");
		
		uri= uri.substring(index+1);
		super.setRedirect(false);
		
		if("location.cc".equalsIgnoreCase(uri)) {
			super.setViewPage("/WEB-INF/company/location.jsp");
		}
		else {  // get방식으로 조작하는 경우에도 회사소개 페이지로 보내버림
			super.setViewPage("/WEB-INF/company/companyInfo.jsp");
		}
		
	}

}

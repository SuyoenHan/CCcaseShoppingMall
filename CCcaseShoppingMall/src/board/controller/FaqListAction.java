package board.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.*;
import common.controller.AbstractController;


public class FaqListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String method = request.getMethod();
		
		//GET 방식일때 select 되어진 값 보여주기
		//("GET".equalsIgnoreCase(method)) {
		
			InterFaqDAO fdao = new FaqDAO();
			
			List<FaqVO> faqList = fdao.faqAllView();
			
			request.setAttribute("faqList", faqList);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/faqMain.jsp");
	//	}
	/*
	 * else { //post 방식일때 update해주기
	 * 
	 * InterFaqDAO fdao = new FaqDAO();
	 * 
	 * HttpSession session = new
	 * 
	 * int n = fdao.faqUpdate(adminid);
	 * 
	 * 
	 * }
	 */
		
		//하.. 모르겠당.. adminid값 어떻게 받아야징..?내일 고민해야겠다..
		
		
	}
	
	
	

}

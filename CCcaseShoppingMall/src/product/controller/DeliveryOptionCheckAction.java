package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class DeliveryOptionCheckAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method= request.getMethod();
		
		// POST 방식일때만 배송옵션 검사 진행
		if("POST".equalsIgnoreCase(method)) {
			
			String pnum= request.getParameter("pnum");
			
			// pnum에 해당하는 배송옵션 
			
			
			
			
		
		
		}
		
		super.setRedirect(false);
		
	}

}

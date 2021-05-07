package order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class NewOrderUpdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String userid = request.getParameter("userid");
		String finalPrice = request.getParameter("finalPrice");
		
		request.setAttribute("userid", userid);
		request.setAttribute("finalPrice", finalPrice);
		
		// userid, finalPrice 넘어오는것까지 확인
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/order/newOrderUpdate.jsp");
		
		
		
	}

}

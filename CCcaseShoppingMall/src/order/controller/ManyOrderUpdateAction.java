package order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;


public class ManyOrderUpdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String userid = request.getParameter("userid");
		String finalamount = request.getParameter("finalamount");
		
		request.setAttribute("userid", userid);
		request.setAttribute("finalamount", finalamount);
		
		
	//	super.setRedirect(false);
	//	super.setViewPage("/WEB-INF/order/manyOrderUpdate.jsp");
	}

}

package order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import order.model.InterOrderDAO;
import order.model.OrderDAO;
import order.model.OrderVO;

public class PayOrderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {


		String pnum = request.getParameter("pnum");
		String cnt = request.getParameter("cnt");
		
		InterOrderDAO odao = new OrderDAO();
		OrderVO ovo = odao.getOrderDetail(pnum); 
		
		request.setAttribute("ovo", ovo);
		request.setAttribute("cnt", cnt);	
		
		super.setViewPage("/WEB-INF/order/payOrderMain.jsp");
		
	}

}

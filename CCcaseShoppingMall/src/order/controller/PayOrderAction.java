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

		super.setViewPage("/WEB-INF/order/payOrderMain.jsp");
		
		String productid = request.getParameter("productid");
		String pcolor = request.getParameter("pcolor");
		
		InterOrderDAO odao = new OrderDAO();
		OrderVO ovo = odao.getOrderDetail(productid, pcolor);
		
		request.setAttribute("ovo", ovo);
		

	}

}

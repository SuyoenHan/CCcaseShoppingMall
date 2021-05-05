package order.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import order.model.InterOrderDAO;
import order.model.OrderDAO;
import order.model.OrderVO;

public class ShipStatusAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String orderno =request.getParameter("orderno");
		
		
	String method = request.getMethod();
		if("POST".equalsIgnoreCase(method)) {
			
			InterOrderDAO odao = new OrderDAO();
			
			List<OrderVO> ovoList = odao.shipStatusView(orderno);
			
			request.setAttribute("ovoList", ovoList);
			
			String orderno1 = ovoList.get(Integer.parseInt("orderno"));
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/order/shipStatus.jsp");
			
		  } else { 
			  // GET 방식이라면 
			  String message = "비정상적인 경로로 들어왔습니다"; String loc ="javascript:history.back()";
		  
		       request.setAttribute("message", message);
		       request.setAttribute("loc", loc);
		 
			  super.setRedirect(false); 
			  super.setViewPage("/WEB-INF/msg.jsp"); }
				 
		
		
	}

}

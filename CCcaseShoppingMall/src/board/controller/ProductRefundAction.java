package board.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.ChRefundDAO;
import board.model.InterChRefundDAO;
import common.controller.AbstractController;
import order.model.InterOrderDAO;
import order.model.OrderDAO;

public class ProductRefundAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String method = request.getMethod();
		
		if(!"post".equalsIgnoreCase(method)) { // get방식일때
			
			String orderno = request.getParameter("orderno");
			String productname = request.getParameter("productname");
			String modelname = request.getParameter("modelname");
			String odetailno = request.getParameter("odetailno");
			
			request.setAttribute("odetailno", odetailno);
			request.setAttribute("orderno", orderno);
			request.setAttribute("productname", productname);
			request.setAttribute("modelname", modelname);
			
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/order/refundProduct.jsp");
		}
		else { //POST방식일때

			String odetailno = request.getParameter("odetailno");
			String sortno = request.getParameter("sortno");
			String whycontent = request.getParameter("whycontent");
			
			// 주문테이블의 배송상태를=> 환불완료로 바꿔주기(update)
			InterOrderDAO iodao = new OrderDAO();
			int n = iodao.updaterefundstatus(odetailno);

			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("fk_odetailno", odetailno);
			paraMap.put("sortno", sortno);
			paraMap.put("whycontent", whycontent);
		
			// 교환및환불 테이블의 insert해주기
			InterChRefundDAO icrdao = new ChRefundDAO();
			int m = icrdao.insertChRefund(paraMap);

			
			if(n*m==1) {
				String message = "환불접수가 완료되었습니다.";
				String loc ="/order/myOrderList.cc";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/adminMsg.jsp");
			}
		}
		
		
	}

}

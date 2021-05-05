package order.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.ChRefundDAO;
import board.model.InterChRefundDAO;
import common.controller.AbstractController;
import order.model.InterOrderDAO;
import order.model.OrderDAO;

public class ProductChangeAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String method = request.getMethod();
		
		if(!"post".equalsIgnoreCase(method)) { // get방식일때
			
			String orderno = request.getParameter("orderno");
			String productname = request.getParameter("productname");
			String modelname = request.getParameter("modelname");
			String pcolor = request.getParameter("pcolor");
			String odetailno = request.getParameter("odetailno");
			
			request.setAttribute("odetailno", odetailno);
			request.setAttribute("orderno", orderno);
			request.setAttribute("productname", productname);
			request.setAttribute("modelname", modelname);
			request.setAttribute("pcolor", pcolor);
			
			// 옵션에서 색상 select태그 알아오기
			// 색상 드롭박스 만들어주기
			List<String> colorList = new ArrayList<>();
			colorList.add("RED");
			colorList.add("ORANGE");
			colorList.add("YELLOW");
			colorList.add("GREEN");
			colorList.add("BLUE");
			colorList.add("NAVY");
			colorList.add("PURPLE");
			colorList.add("WHITE");
			colorList.add("BLACK");
			colorList.add("PINK");
			colorList.add("GRAY");
			
			request.setAttribute("colorList", colorList);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/order/changeProduct.jsp");
		}
		else {
			
			String orderno = request.getParameter("orderno");
			String fk_odetailno = request.getParameter("odetailno");
			String sortno = request.getParameter("sortno");
			String whycontent = request.getParameter("whycontent");
			
			// 주문테이블의 배송상태를=> 교환완료로 바꿔주기(update)
			InterOrderDAO iodao = new OrderDAO();
			int n = iodao.updatestatus(orderno);
			
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("fk_odetailno", fk_odetailno);
			paraMap.put("sortno", sortno);
			paraMap.put("whycontent", whycontent);
			
			// 교환및환불 테이블의 insert해주기
			InterChRefundDAO icrdao = new ChRefundDAO();
			int m = icrdao.insertChRefund(paraMap);
			
		}
	}

}

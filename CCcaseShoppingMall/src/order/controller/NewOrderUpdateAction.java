package order.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import order.model.InterOrderDAO;
import order.model.OrderDAO;

public class NewOrderUpdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String userid = request.getParameter("userid");
		String finalPrice = request.getParameter("finalPrice");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("finalPrice", finalPrice);
		
		InterOrderDAO odao = new OrderDAO();
		int n = odao.insertNewOrder(paraMap);	// DB에 새 주문 INSERT
		
		String message = "";
		String loc ="";
		
		if(n==1) {
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			

			message=loginuser.getName()+"님의 "+finalPrice+"원 결제가 완료되었습니다.";
			loc=request.getContextPath()+"/newOrderUpdate.cc";
		}
		else {
			message="결제가 실패했습니다.";
			loc = "javascript:history.back()";
		}
		
		request.setAttribute("message", message);
		request.setAttribute("loc", loc);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/order/newOrderUpdate.jsp");
		
		
		
	}

}

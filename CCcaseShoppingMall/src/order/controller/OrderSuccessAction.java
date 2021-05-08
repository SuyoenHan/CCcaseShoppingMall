package order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;


public class OrderSuccessAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		// 아임포트 결제창을 사용하기 위한 전제조건은 먼저 로그인을 해야 하는 것이다. 
		if( loginuser != null ) {
			// 로그인을 했으면
			
				String userid = request.getParameter("userid");
				String finalamount = request.getParameter("finalamount");
				
				request.setAttribute("userid", userid);
				request.setAttribute("finalamount", finalamount);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/order/paymentGateway.jsp");
		}
		else {
			// 로그인을 안 했으면
			String message = "결제하기 위해서는 먼저 로그인을 하세요!!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}		
	}

}

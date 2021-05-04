package order.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import order.model.*;

public class MyOrderListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session =request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		  
	    	  
			if(loginuser!=null) {
				String userid = loginuser.getUserid();
				
				InterOrderDAO odao = new OrderDAO();
				List<OrderVO> orderList =odao.myOrderList(userid);
				
				request.setAttribute("orderList", orderList);	
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/order/myOrderList.jsp");
			
			}
			else {
				String message = "로그인을 먼저 하세요";
				String loc= request.getContextPath()+"/login/loginform.cc";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
		
		
	}
}

package order.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import order.model.InterOrderDAO;
import order.model.OrderDAO;
import order.model.OrderVO;

public class ShipStatusAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String orderno =request.getParameter("orderno");
		
		
		HttpSession session =request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임. 
		super.goBackURL(request);
    	  
		if(loginuser!=null) {
			String userid = loginuser.getUserid();
		
		
			   String method = request.getMethod();
				if("POST".equalsIgnoreCase(method)) {
					
					InterOrderDAO odao = new OrderDAO();
					
					List<OrderVO> ovoList = odao.shipStatusView(orderno);
					
					request.setAttribute("ovoList", ovoList);
					
					request.setAttribute("orderno", orderno);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/order/shipStatus.jsp");
					
				  } else { 
					  // GET 방식이라면 
					  String message = "비정상적인 경로로 들어왔습니다"; String loc ="javascript:history.back()";
				  
				       request.setAttribute("message", message);
				       request.setAttribute("loc", loc);
				 
					  super.setRedirect(false); 
					  super.setViewPage("/WEB-INF/msg.jsp"); 
					  
				  }
				 
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

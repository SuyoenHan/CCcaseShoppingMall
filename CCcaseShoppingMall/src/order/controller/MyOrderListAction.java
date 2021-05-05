package order.controller;


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
		
			// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임. 
			super.goBackURL(request);
	    	  
			if(loginuser!=null) {
				String userid = loginuser.getUserid();
				
				
				// === Ajax(JSON)를 사용하여  주문목록 "더보기" 방식으로 페이징처리해서 보여주겠다. === // 
				InterOrderDAO odao = new OrderDAO();
				
				int totalOrderListCount = odao.totalOrderListCount(userid);//  
				
				//System.out.println("~~확인용 totalHITCount => "+ totalOrderListCount);
				//"~~확인용 totalHITCount => 36
				
				request.setAttribute("totalOrderListCount", totalOrderListCount);
				
				
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

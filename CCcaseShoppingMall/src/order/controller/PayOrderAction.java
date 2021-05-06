package order.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import order.model.InterOrderDAO;
import order.model.OrderDAO;


public class PayOrderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO)session.getAttribute("loginuser");
		
		if(mvo==null) {
			String message = "로그인 후 가능합니다.";
			String loc="javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		else {
		String pnum = request.getParameter("pnum");
		String cnt = request.getParameter("cnt");
		int iCnt = Integer.parseInt(cnt);
		
		int totalpoint = mvo.getTotalpoint();
		int fk_grade = mvo.getFk_grade();
			
		
		InterOrderDAO odao = new OrderDAO();
	    Map<String,String> paraMap = odao.getOrderDetail(pnum);
	    
	    int price = Integer.parseInt(paraMap.get("price"));
	    double salepercent = Double.parseDouble(paraMap.get("salepercent"));
	    
	    // 판매가 구하기
	    double saleprice;
	    
	    if(salepercent!=0) {
	    	saleprice = price*(1-salepercent); 
	    }
	    else {
	    	saleprice = Double.parseDouble(paraMap.get("price"));
	    }
	    
	    // 총상품가격 구하기
	    int totalProPrice = iCnt * (int)saleprice;
	    
	    // 예상적립금 구하기
	    double expectPercent;
		
		if(fk_grade==0) {
			expectPercent=0.05;
		}
		else if(fk_grade==1) {
			expectPercent=0.1;
		}
		else {
			expectPercent=0.15;
		}
				
		int expectPoint = (int)(saleprice *expectPercent);
		
		int shipfee = 0;
		
		// 배송비 구하기
		if("0".equalsIgnoreCase(paraMap.get("doption"))) {
			shipfee =0;
		}
		else {
			shipfee=3000;
		}
		
		request.setAttribute("shipfee", shipfee);
		
		request.setAttribute("expectPoint", expectPoint); // 예상적립금
	    request.setAttribute("totalpoint", totalpoint);   // 현재 회원이 보유한 포인트
	    request.setAttribute("saleprice", saleprice);
	    request.setAttribute("paraMap", paraMap);
	    request.setAttribute("cnt", cnt);
		request.setAttribute("totalProPrice", totalProPrice);
	    
		super.setViewPage("/WEB-INF/order/payOrderMain.jsp");
		
		}
	}

}

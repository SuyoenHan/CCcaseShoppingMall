package order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.*;

public class GetCouponSaleAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String cpno = request.getParameter("cpno");
		//System.out.println(cpno);
		if(cpno!=null) {
			
			
			InterCouponDAO icdao = new CouponDAO();
			
			// 쿠폰번호를 가지고 할인율을 가져오는 메소드
			String cpdiscount = icdao.getCouponsale(cpno);
			
			// System.out.println(cpdiscount);
			
			JSONObject jsobj = new JSONObject();
	        String json = "";
	        
	        jsobj.put("cpdiscount", cpdiscount);
	        json = jsobj.toString();
			
	        request.setAttribute("json", json);
	        
	        super.setRedirect(false);
	        super.setViewPage("/WEB-INF/jsonview.jsp");
		}
		else {
			String message = "존재하지 않는 쿠폰입니다. 다시 확인해주세요";
			String loc = "javascript:history.go(0)";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			
		}
	}

}

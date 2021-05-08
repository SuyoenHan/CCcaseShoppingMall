package member.controller;

import javax.servlet.http.HttpServletRequest;


import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.CouponDAO;
import member.model.InterCouponDAO;

import order.model.InterOrderDAO;
import order.model.OrderDAO;

public class MyPageHeaderAction extends AbstractController {
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String userid =request.getParameter("userid");
		
		InterCouponDAO cdao = new CouponDAO();
		int acnt = cdao.countAvalCpQty("0", userid);
		
		InterOrderDAO odao =new OrderDAO();
		int ocnt = odao.countOrder(userid);
		
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("acnt", acnt);
		jsonObj.put("ocnt", ocnt);
		
	    String json = jsonObj.toString(); 
	    request.setAttribute("json", json);
	    
	//	super.setRedirect(false);
	    super.setViewPage("/WEB-INF/jsonview.jsp");
	
	}

}

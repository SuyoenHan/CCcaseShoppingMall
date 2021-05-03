package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import product.model.*;

public class DeliveryOptionCheckAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method= request.getMethod();
		
		// POST 방식일때만 배송옵션 검사 진행
		if("POST".equalsIgnoreCase(method)) {
			
			String pnum= request.getParameter("pnum");
			
			// pnum에 해당하는 배송옵션 
			InterProductDetailDAO pddao= new ProductDetailDAO();
			int dOption= pddao.getDOptionByPnum(pnum);
			
			JSONObject jsonObj= new JSONObject();
			jsonObj.put("dOption", dOption);
			
			String json= jsonObj.toString();
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
	}

}

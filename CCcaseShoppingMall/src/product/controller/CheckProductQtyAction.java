package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import product.model.InterProductDetailDAO;
import product.model.ProductDetailDAO;

public class CheckProductQtyAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method= request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) { // get방식
			String message="잘못된 경로로 들어왔습니다.";
			String loc="javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");	
			return;	
		}
		else { // post방식
			
			String pnum= request.getParameter("pnum");
			String cnt= request.getParameter("cnt");
			int n=0;
			
			InterProductDetailDAO pddao= new ProductDetailDAO();
			int qty= pddao.getQtyByPnum(pnum);
			
			if(Integer.parseInt(cnt)<=qty) { // 주문수량보다 재고량이 더 많거나 같은 경우
				n=1;
			}
			else {   // 주문수량보다 재고량이 적은경우
				n=0;
			}
			
			JSONObject jsonobject= new JSONObject();
			jsonobject.put("n", n);
			jsonobject.put("qty", qty);
			
			String json=jsonobject.toString();
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
		
	}

}

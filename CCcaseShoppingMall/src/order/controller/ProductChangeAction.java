package order.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class ProductChangeAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String method = request.getMethod();
		
		if(!"post".equalsIgnoreCase(method)) { // get방식일때
			
			String orderno = request.getParameter("orderno");
			String productname = request.getParameter("productname");
			String modelname = request.getParameter("modelname");
			String pcolor = request.getParameter("pcolor");
			
			request.setAttribute("orderno", orderno);
			request.setAttribute("productname", productname);
			request.setAttribute("modelname", modelname);
			request.setAttribute("pcolor", pcolor);
			
			// 옵션에서 색상 select태그 알아오기
			// 색상 드롭박스 만들어주기
			List<String> colorList = new ArrayList<>();
			colorList.add("RED");
			colorList.add("ORANGE");
			colorList.add("YELLOW");
			colorList.add("GREEN");
			colorList.add("BLUE");
			colorList.add("NAVY");
			colorList.add("PURPLE");
			colorList.add("WHITE");
			colorList.add("BLACK");
			colorList.add("PINK");
			colorList.add("GRAY");
			
			request.setAttribute("colorList", colorList);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/order/changeProduct.jsp");
		}
		else {
			
			request.getParameter("orderno");
			
			
		}
	}

}

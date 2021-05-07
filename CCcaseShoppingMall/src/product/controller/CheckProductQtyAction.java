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
			
			String str_pnumArr= request.getParameter("str_pnumArr");
			String str_cntArr= request.getParameter("str_cntArr");
			String str_productnameArr= request.getParameter("str_productnameArr");
			String str_pcolorArr= request.getParameter("str_pcolorArr");
			
			InterProductDetailDAO pddao= new ProductDetailDAO();
			JSONObject jsonobject= new JSONObject();
			
			
			if(str_productnameArr==null) {
				int qty= pddao.getQtyByPnum(str_pnumArr);
				if(Integer.parseInt(str_cntArr)>qty) {
					jsonobject.put("n", 1);
					jsonobject.put("qty", qty);
				}
				else {
					jsonobject.put("n", 0);
				}
			}
			else {
				String[] pnumArr= str_pnumArr.split(",");
				String[] cntArr= str_cntArr.split(",");
				String[] productnameArr= str_productnameArr.split(",");
				String[] pcolorArr= str_pcolorArr.split(",");
				
				for(int i=0;i<pnumArr.length;i++) {
					int qty= pddao.getQtyByPnum(pnumArr[i]);
					if(Integer.parseInt(cntArr[i])>qty) { // 주문수량보다 재고량이 더 많거나 같은 경우
					    jsonobject.put("n", 1);
						jsonobject.put("productname", productnameArr[i]);
					    jsonobject.put("pcolor", pcolorArr[i]);
						jsonobject.put("qty", qty);
						break;
					}
				}
				
			}
			
			
			String json=jsonobject.toString();
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
		
	}

}

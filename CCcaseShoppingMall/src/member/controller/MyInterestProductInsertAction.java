package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.*;

public class MyInterestProductInsertAction extends AbstractController {

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
			
			String fk_productid= request.getParameter("productid");
			String fk_pnum= request.getParameter("pnum"); // 색상선택 안한 경우 "-"
			String fk_userid= request.getParameter("userid");
			
			if(fk_userid !=null) {
				InterestProductVO ipvo= new InterestProductVO();
				ipvo.setFk_pnum(fk_pnum);
				ipvo.setFk_productid(fk_productid);
				ipvo.setFk_userid(fk_userid);
				
				InterInterestProductDAO ipdao= new InterestProductDAO();
				int n= ipdao.insertInterestProduct(ipvo);
				
				String message="";
				if(n==1) {
					message="관심상품에 추가했습니다.";
				}
				else if(n==2) {
					message="관심상품에 등록되어져 있는 상품입니다.";
				}
				else {
					message="관심상품 추가에 실패했습니다.";
				}
				
				JSONObject jsonObject= new JSONObject();
				jsonObject.put("message", message);
				jsonObject.put("n", n);
				
				String json= jsonObject.toString();
				request.setAttribute("json", json);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/jsonview.jsp");
			}
		} // end of else-----------------------------------
	}

}

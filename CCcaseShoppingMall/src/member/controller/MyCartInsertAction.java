package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.CartDAO;
import member.model.CartVO;
import member.model.InterCartDAO;

public class MyCartInsertAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String fk_productid= request.getParameter("productid");
		String fk_pnum= request.getParameter("pnum"); // 색상선택 안한 경우 ""
		String cinputcnt= request.getParameter("pcnt");
		String fk_userid= request.getParameter("userid");
		
		if(fk_userid !=null) {
			CartVO ctvo= new CartVO();
			ctvo.setCinputcnt(Integer.parseInt(cinputcnt));
			ctvo.setFk_pnum(fk_pnum);
			ctvo.setFk_productid(fk_productid);
			ctvo.setFk_userid(fk_userid);
			
			InterCartDAO ctdao= new CartDAO();
			int n= ctdao.insertWishList(ctvo);
			
			 /* 
	    		insert 성공: n==1
	    		insert 실패: n==0
			*/
			
			String message="";
			if(n==1) {
				message="장바구니에 담았습니다.";
			}
			else {
				message="장바구니에 상품 담기가 실패되었습니다.";
			}
			
			JSONObject jsonObject= new JSONObject();
			jsonObject.put("message", message);
			jsonObject.put("n", n);
			
			String json= jsonObject.toString();
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
	}

}

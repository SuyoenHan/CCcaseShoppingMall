package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.CartDAO;
import member.model.CartVO;
import member.model.InterCartDAO;

public class MyCartDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method= request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) { // get방식으로 들어온 경우
			
			String message="잘못된 경로로 들어왔습니다.";
			String loc="javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");	
			return;	
		}
		else { // post방식으로 들어온 경우
			
			String scartno= request.getParameter("cartno");
			String fk_productid= request.getParameter("productid");
			String fk_pnum= request.getParameter("pnum"); // 색상선택 안한 경우 "-"
			String cinputcnt= request.getParameter("pcnt");
			String fk_userid= request.getParameter("userid");
			
			
			if(scartno!="null") {
				
				int cartno= Integer.parseInt(scartno);
				InterCartDAO ctdao= new CartDAO();
				int n= ctdao.deleteOneRow(cartno);
				
				CartVO ctvo= new CartVO();
				ctvo.setCinputcnt(Integer.parseInt(cinputcnt));
				ctvo.setFk_pnum(fk_pnum);
				ctvo.setFk_productid(fk_productid);
				ctvo.setFk_userid(fk_userid);
				
				n= ctdao.insertUpdateWishList(ctvo);
				
				JSONObject jsonObject= new JSONObject();
				jsonObject.put("n", n);
				
				String json= jsonObject.toString();
				request.setAttribute("json", json);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/jsonview.jsp");
			}
		}
	}

}

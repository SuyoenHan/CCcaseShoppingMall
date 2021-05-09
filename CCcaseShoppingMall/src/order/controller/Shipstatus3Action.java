package order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.MemberVO;
import order.model.InterOrderDAO;
import order.model.OrderDAO;
import order.model.OrderVO;

public class Shipstatus3Action extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {


		HttpSession session =request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임. 
		super.goBackURL(request);
  	  
		if(loginuser!=null) {
			 String odetailno = request.getParameter("odetailno");
			
			
			// === Ajax(JSON)를 사용하여  리뷰테이블 odetailno select. === // 
			InterOrderDAO odao = new OrderDAO();
			
			int n = odao.reviewExist(odetailno);//  
			//n==1  이면 리뷰 odetailno 존재
			//n==0 이면 존재 안함
			
			
		      JSONObject jsonObj = new JSONObject();
		      jsonObj.put("n", n ); // {"bool":true}{"bool":false}
		     
		      String json = jsonObj.toString(); //       

		      request.setAttribute("json", json);

//		      super.setRedirect(false);
		      super.setViewPage("/WEB-INF/jsonview.jsp");
			
		
		}
		else {
			String message = "로그인을 먼저 하세요";
			String loc= request.getContextPath()+"/login/loginform.cc";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}

}

package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;


public class UnavailableCouponAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
			// == 해당계정으로 로그인 했을 때만 조회가 가능하도록 한다. == //
			HttpSession session = request.getSession();
			MemberVO loginuser =  (MemberVO) session.getAttribute("loginuser");
			
			// 로그인된 계정으로 접속 했을 경우
			if(loginuser != null) {
				
				String userid = request.getParameter("userid");
				
				InterCouponDAO cdao = new CouponDAO();
				
				// 아이디를 가지고 해당 쿠폰 정보 조회해오기
				CouponVO cvo = cdao.selectCouponByUserid(userid);
				
				// 쿠폰 개수 조회하기
				int cnt = cdao.countCouponQty("1");
				
				request.setAttribute("cpList", cvo);
				request.setAttribute("cnt", cnt);
				
				// super.setRedirect(false);
				super.setViewPage("/WEB-INF/member/AvailableCoupon.jsp");
				
			}
			else {
				// 로그인을 안한 경우 또는 보려는 정보와 다른계정으로 로그인되어져 있는 경우
				 String message = "잘못된 접근입니다.";
		         String loc = "javascript:history.back()";
		         
		         request.setAttribute("message", message);
		         request.setAttribute("loc", loc);
		         
		      //   super.setRedirect(false);
		         super.setViewPage("/WEB-INF/msg.jsp");
			}
		
	}

}

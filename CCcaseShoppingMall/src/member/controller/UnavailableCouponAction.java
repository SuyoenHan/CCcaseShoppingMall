package member.controller;

import java.util.*;

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
				String currentShowPageNo = request.getParameter("currentShowPageNo");
				
				if(currentShowPageNo == null) {
					currentShowPageNo = "1";
				}
				
				try {
					Integer.parseInt(currentShowPageNo);
				} catch (NumberFormatException e) {
						currentShowPageNo = "1";
				}
				
				String userid = loginuser.getUserid();
				
				InterCouponDAO cdao = new CouponDAO();
				
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("userid", userid);
				paraMap.put("currentShowPageNo", currentShowPageNo);
				paraMap.put("cpstatus", "1"); // 사용불가능 쿠폰 목록을 보기 위함 (소멸쿠폰은 2번이다 => CouponDAO에서 처리함)
				
				// 아이디를 가지고 해당 쿠폰 정보 조회해오기
				List<CouponVO> cpList = cdao.selectCouponList(paraMap);
				
				
				// 사용가능쿠폰 개수 조회하기
				int acnt = cdao.countAvalCpQty("0");
				
				// 사용불가쿠폰 개수 조회하기
				int ucnt = cdao.countUnavalCpQty("1");
				
				request.setAttribute("cpList", cpList);
				request.setAttribute("acnt", acnt);
				request.setAttribute("ucnt", ucnt);
				
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

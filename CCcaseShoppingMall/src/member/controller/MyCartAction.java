package member.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;
import product.model.*;

public class MyCartAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session= request.getSession();
		MemberVO loginuser= (MemberVO)session.getAttribute("loginuser");
		
		
		if(loginuser!=null) { // 로그인 한 경우
			
			String userid= loginuser.getUserid();
			
			InterCartDAO ctdao= new CartDAO();
			InterProductDAO pdao= new ProductDAO();
			InterMemberGradeDAO mgdao= new MemberGradeDAO();
			InterProductDetailDAO pddao= new ProductDetailDAO();
			
			double pointPercent=mgdao.getPointPercent(loginuser.getUserid()); // 로그인한 회원의 적립률
			request.setAttribute("pointPercent", pointPercent);
			
			List<Map<String, String>> cartInfoList= ctdao.selectCartInfo(userid); //색깔 고르지 않은 경우 pnum="-1"
			
			/*
		 		특정회원의 장비구니 정보가 없는 경우: cartInfoList.size()==0
		 		특정회원의 장비구니 정보가 존재하는 경우: cartInfoList.size()>0
			*/
			
			if(cartInfoList.size()==0) { // 장바구니 목록이 존재하지 않는 경우
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/member/emptyMyCart.jsp");
				return;
			}
			else { // 장바구니 목록이 존재하는 경우
			
				List<Map<String, String>> cartRequiredInfoList = new ArrayList<>();
				
				for(Map<String, String> cartInfoMap : cartInfoList) {
					
					String productid= cartInfoMap.get("fk_productid");
					String pnum= cartInfoMap.get("fk_pnum");
					String cinputcnt= cartInfoMap.get("cinputcnt");
					
					Map<String,String> onePInfo= pdao.getOnePInfo(productid);
					onePInfo.put("cinputcnt", cinputcnt);
					
					Map<String,String> colorDeliveryMap= pddao.getColorDelivery(pnum);
					
					if(colorDeliveryMap.size()>0) {  // 색상을 선택한 경우
						onePInfo.put("pnum", colorDeliveryMap.get("pnum"));
						onePInfo.put("pcolor", colorDeliveryMap.get("pcolor"));
						onePInfo.put("doption", colorDeliveryMap.get("doption"));
					}
					else { // 색상을 선택하지 않은 경우
						onePInfo.put("pnum", "-1"); 
						onePInfo.put("pcolor", "-");
						onePInfo.put("doption", "색상에 따라 상이");
					}
					
					// 예상적립금
					int point= (int)((Integer.parseInt(cinputcnt)*Integer.parseInt(onePInfo.get("saleprice")))*pointPercent);
					onePInfo.put("point",String.valueOf(point));
					
					
					// 합계금액
					int totalPrice= Integer.parseInt(cinputcnt)*Integer.parseInt(onePInfo.get("saleprice"));
					onePInfo.put("totalPrice",String.valueOf(totalPrice));
					
					cartRequiredInfoList.add(onePInfo);
					
				} // end of for------------------------------------------------------
				
			
				request.setAttribute("cartRequiredInfoList", cartRequiredInfoList);
				request.setAttribute("name", loginuser.getName());
			} // end of else----------------------------------------------------------

			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/myCart.jsp");
			return;
			
		}
			
		else { // 로그인 하지 않은 경우
			String message="로그인 후 이용 가능합니다.";
			String loc="javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");	
			return;
		}
		
			
	
	}

}

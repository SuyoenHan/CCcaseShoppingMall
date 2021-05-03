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
			
			int pointPercent=mgdao.getPointPercent(loginuser.getUserid()); // 로그인한 회원의 적립률
			request.setAttribute("pointPercent", pointPercent);
			
			List<Map<String, String>> cartInfoList= ctdao.selectCartInfo(userid);
			
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
			
				List<Map<String, String>> cartRequiredInfo = new ArrayList<>();
				
				for(Map<String, String> cartInfoMap : cartInfoList) {
					
					String productid= cartInfoMap.get("fk_productid");
					String pnum= cartInfoMap.get("fk_pnum");
					Map<String,String> onePInfo= pdao.getOnePInfo(productid);
					
					// int dOption= pddao.getDOptionByPnum(pnum);
					//onePInfo.put("dOption", String.valueOf(dOption));
					
					// cartRequiredInfo.add(onePInfo);
				}
				
				
				
				
				
				
				
				
				
			}
			
			
			
			
			
			
			
			
			
			
			
			request.setAttribute("name", loginuser.getName());
			
			
			
			
			
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

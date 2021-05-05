package member.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.CartDAO;
import member.model.InterCartDAO;
import member.model.InterInterestProductDAO;
import member.model.InterMemberGradeDAO;
import member.model.InterestProductDAO;
import member.model.MemberGradeDAO;
import member.model.MemberVO;
import product.model.InterProductDAO;
import product.model.InterProductDetailDAO;
import product.model.ProductDAO;
import product.model.ProductDetailDAO;

public class MyInterestProductAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session= request.getSession();
		MemberVO loginuser=(MemberVO)session.getAttribute("loginuser");
		
		if(loginuser!=null) { // 로그인 한 경우
			
			String userid= loginuser.getUserid();
			
			InterInterestProductDAO ipdao= new InterestProductDAO();
			InterProductDAO pdao= new ProductDAO();
			InterMemberGradeDAO mgdao= new MemberGradeDAO();
			InterProductDetailDAO pddao= new ProductDetailDAO();
			
			double pointPercent=mgdao.getPointPercent(userid); // 로그인한 회원의 적립률
			request.setAttribute("pointPercent", pointPercent);
			
			List<Map<String, String>> interestPInfoList= ipdao.selectInterestPInfo(userid); //색깔 고르지 않은 경우 pnum="-"
			
			/*
		 		특정회원의 관심상품 정보가 없는 경우: interestPInfoList.size()==0
		 		특정회원의 관심상품 정보가 존재하는 경우: interestPInfoList.size()>0
			*/
			
			if(interestPInfoList.size()==0) { // 관심상품 목록이 존재하지 않는 경우
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/member/emptyMyInterestProduct.jsp");
				return;
			}
			else { // 관심상품 목록이 존재하는 경우
			
				List<Map<String, String>> interestPRequiredInfoList = new ArrayList<>();
				
				for(Map<String, String> interestPInfoMap: interestPInfoList) {
					
					String productid= interestPInfoMap.get("fk_productid");
					String pnum= interestPInfoMap.get("fk_pnum"); // null인 경우 "-" 처리
					String interestno= interestPInfoMap.get("interestno");
					
					Map<String,String> onePInfo= pdao.getOnePInfo(productid);
					onePInfo.put("interestno", interestno);
					
					Map<String,String> colorDeliveryMap= pddao.getColorDelivery(pnum);
					
					if(colorDeliveryMap.size()>0) {  // 색상을 선택한 경우
						onePInfo.put("pnum", colorDeliveryMap.get("pnum"));
						onePInfo.put("pcolor", colorDeliveryMap.get("pcolor"));
						onePInfo.put("doption", colorDeliveryMap.get("doption"));
					}
					else { // 색상을 선택하지 않은 경우
						onePInfo.put("pnum", "-"); 
						onePInfo.put("pcolor", "-");
						onePInfo.put("doption", "색상에 따라 상이");
					}					
					
					// 예상적립금
					int point= (int)(Integer.parseInt(onePInfo.get("saleprice"))*pointPercent);
					onePInfo.put("point",String.valueOf(point));
					
					interestPRequiredInfoList.add(onePInfo);
				
				} // end of for------------------------------------------------------
			
				request.setAttribute("interestPRequiredInfoList", interestPRequiredInfoList);
				
			}// end of else-----------------------------------------------------------
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/myInterestProduct.jsp");
			
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

package order.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import order.model.InterOrderDAO;
import order.model.OrderDAO;


public class PayOrderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO)session.getAttribute("loginuser");
		
		if(mvo==null) {
			String message = "로그인 후 가능합니다.";
			String loc="javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		else {
			
			String cartno = request.getParameter("cartno");
			String pnum = request.getParameter("pnum");
			String cnt = request.getParameter("cnt");
			String fk_userid = mvo.getUserid();
			
			String[] cartnoArr = new String[0];
			String[] pnumArr = new String[0];
			String[] cntArr = new String[0];
			
			if(cartno!=null && cartno.indexOf(",") != -1) {
				cartnoArr = cartno.split(",");
			}
			
			if(pnum.indexOf(",") != -1) {
				pnumArr = pnum.split(",");
				
			}
			
			if(cnt.indexOf(",") != -1) {
				cntArr = cnt.split(",");
			}
			
			
			// 장바구니에서 여러개의 상품이 넘어온경우
			if(cartno!=null && pnumArr.length!= 1) { 
				
				InterOrderDAO odao = new OrderDAO();
				
				List<Map<String,String>> orderPageList= new ArrayList<>();
				
				// 총상품가격
				int totalProPrice=0;
				
				// 이용자의 보유중 point
				int totalpoint = mvo.getTotalpoint();
				
				// 이용자의 등급
				int fk_grade = mvo.getFk_grade();
				
				// 배송료
				int allShipfee = 0;
				
				
				// 예상적립금 구하기
			    double expectPercent;
				
				if(fk_grade==0) {
					expectPercent=0.05;
				}
				else if(fk_grade==1) {
					expectPercent=0.1;
				}
				else {
					expectPercent=0.15;
				}
				
				for(int i=0; i<pnumArr.length; i++) {
					
					// pnum을 가지고, 주문페이지에서 필요한 정보 뽑아오기(select)
					Map<String,String> productMap = odao.manyOrderPageInfo(pnumArr[i]);
					
					productMap.put("cartnoArr", cartnoArr[i]);
					productMap.put("cntArr", cntArr[i]);
					
					
					int saleprice = Integer.parseInt(productMap.get("saleprice"));
					
					int oneExpectpoint = (int)(saleprice *expectPercent);
					
					productMap.put("oneExpectpoint", String.valueOf((oneExpectpoint)));
					
					// 총 상품 가격
					totalProPrice += Integer.parseInt(cntArr[i]) * saleprice;

					// 배송비 구하기
					if("0".equalsIgnoreCase(productMap.get("doption"))) {
						allShipfee += 0;
					}
					else {
						allShipfee = 3000;
					}
					
					orderPageList.add(productMap);
					
					
				} // end of for -------------------
				

				int allExpectPoint = (int)(totalProPrice *expectPercent);
				
				int listSize = orderPageList.size();
				
				request.setAttribute("listSize", listSize);
				request.setAttribute("fk_userid", fk_userid); //id
				request.setAttribute("totalProPrice", totalProPrice); //총 상품가격
				request.setAttribute("totalpoint", totalpoint); //이용자의 보유중 포인트
				request.setAttribute("allShipfee", allShipfee); //전체상품에 대한 배송료
				request.setAttribute("allExpectPoint", allExpectPoint); // 전체상품에 대한 예상적립금
				request.setAttribute("orderPageList", orderPageList);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/order/manyOrderPage.jsp");
				

			}
			else { // 장바구니에서 한개의 상품이 넘어오거나, 제품상세에서 즉시구매를 클릭했을 경우
			
				int iCnt = Integer.parseInt(cnt);
				
				int totalpoint = mvo.getTotalpoint();
				int fk_grade = mvo.getFk_grade();
					
				InterOrderDAO odao = new OrderDAO();
			    Map<String,String> paraMap = odao.oneOrderPageInfo(pnum);
			    
			    int price = Integer.parseInt(paraMap.get("price"));
			    double salepercent = Double.parseDouble(paraMap.get("salepercent"));
			    
			    // 판매가 구하기
			    double saleprice;
			    
			    if(salepercent!=0) {
			    	saleprice = price*(1-salepercent); 
			    }
			    else {
			    	saleprice = Double.parseDouble(paraMap.get("price"));
			    }
			    
			    // 총상품가격 구하기
			    int totalProPrice = iCnt * (int)saleprice;
			    
			    // 예상적립금 구하기
			    double expectPercent;
				
				if(fk_grade==0) {
					expectPercent=0.05;
				}
				else if(fk_grade==1) {
					expectPercent=0.1;
				}
				else {
					expectPercent=0.15;
				}
						
				int expectPoint = (int)(totalProPrice *expectPercent);
				
				int shipfee = 0;
				
				// 배송비 구하기
				if("0".equalsIgnoreCase(paraMap.get("doption"))) {
					shipfee =0;
				}
				else {
					shipfee=3000;
				}
				
				request.setAttribute("shipfee", shipfee);
				request.setAttribute("cartno", cartno);
				request.setAttribute("expectPoint", expectPoint); // 예상적립금
			    request.setAttribute("totalpoint", totalpoint);   // 현재 회원이 보유한 포인트
			    request.setAttribute("saleprice", saleprice);
			    request.setAttribute("paraMap", paraMap);
			    request.setAttribute("cnt", cnt);
				request.setAttribute("totalProPrice", totalProPrice);
			    
				super.setViewPage("/WEB-INF/order/oneOrderPage.jsp");
			}
		}
	}

}

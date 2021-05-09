package order.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.MemberVO;
import order.model.InterOrderDAO;
import order.model.OrderDAO;


public class ManyOrderUpdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO)session.getAttribute("loginuser");
		

        
        
        if(mvo!=null) { // 로그인을 한경우
    		JSONObject jsobj = new JSONObject();
            String json = "";
        	
        	String pnum_es = request.getParameter("pnum_es");
        	String odqty_es = request.getParameter("odqty_es");
        	String pdetailprice_es = request.getParameter("pdetailprice_es");
        	String cartno_es = request.getParameter("cartno_es");
        	String totalPrice = request.getParameter("totalPrice");   // 총상품액 
        	String allShipfee = request.getParameter("allShipfee");   // 총배송료
        	String totalpoint = request.getParameter("totalpoint");   //예상적립금
        	String qUsepoint = request.getParameter("qUsepoint");     //사용포인트
        	String finalamount = request.getParameter("finalamount"); // 총주문금액
        	String userid = mvo.getUserid();
        	String cpno = request.getParameter("cpno");
        	
        	
        	if(pnum_es != null && odqty_es!= null && pdetailprice_es!= null && cartno_es !=null) {
        		

	        	String[] pnumArr = pnum_es.split(",");
	        	String[] odqtyArr = odqty_es.split(",");
	        	String[] pdetailpriceArr = pdetailprice_es.split(",");
	        	String[] cartnoArr = cartno_es.split(",");
	        	
	        	/*
	        	for(int i=0; i<pnumArr.length; i++) {
	         	   
	                System.out.println("확인용 pnum : "+pnumArr[i]);
	                System.out.println("~~~~ 확인용 pnum: " + pnumArr[i] + ", oqty: " + odqtyArr[i] + ", pdetailprice: " + pdetailpriceArr[i] + ", cartno: " + cartnoArr[i]);
	                
	             }// end of for--------------------------------------
	        	*/
	        	
	        	Map<String, Object> paraMap = new HashMap<String, Object>();
	        	
	        	paraMap.put("pnumArr", pnumArr);
	        	paraMap.put("odqtyArr", odqtyArr);
	        	paraMap.put("pdetailpriceArr", pdetailpriceArr);
	        	paraMap.put("cartnoArr", cartnoArr);
	        	paraMap.put("totalPrice", totalPrice);
	        	paraMap.put("allShipfee", allShipfee);
	        	paraMap.put("totalpoint", totalpoint);
	        	paraMap.put("qUsepoint", qUsepoint);
	        	paraMap.put("finalamount", finalamount);
	        	paraMap.put("fk_userid", userid);
	        	paraMap.put("cpno", cpno);
	        	
	        	// 전표를 생성해주는 메소드 호출하기
				InterOrderDAO iodao = new OrderDAO();
				String orderno = iodao.getOrderno();
				
				paraMap.put("orderno", orderno);
				
				// 장바구니에 여러 제품이 들어왔을 경우 주문했을때 테이블 작업
				int success = iodao.manyOrderAdd(paraMap);
	        	
				jsobj.put("success", success);
				
				if(success == 1) {
		              
		              // 세션에 저장되어져 있는 mvo 정보를 갱신
					  mvo.setTotalpoint(mvo.getTotalpoint()+Integer.parseInt(totalpoint)-Integer.parseInt(qUsepoint));
		              
		              ////////// === 주문이 완료되었다는 email 보내기 시작 === ///////////
					  /*
					  GoogleMail mail = new GoogleMail();
					  
					  String emailContents = mvo.getName()+"고객님의 주문이 완료됐습니다.";
					  
					  mail.sendmail(mvo.getEmail(), certificationCode);
					  */
				}
	        	
				json = jsobj.toString();
		        request.setAttribute("json", json);
		        
		        super.setRedirect(false);
		        super.setViewPage("/WEB-INF/jsonview.jsp");
        	}
        	
        }
        else { // 로그인을 안한경우
        	String message = "로그인 후 이용바랍니다.";
			String loc = request.getContextPath()+"/home.cc";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
        }
        
        
	}

}

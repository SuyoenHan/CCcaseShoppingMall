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

public class OneOrderUpdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO)session.getAttribute("loginuser");
		
		JSONObject jsobj = new JSONObject();
        String json = "";
		
		if(mvo!=null) {
		
			String fk_userid = mvo.getUserid();
			String totalPrice = request.getParameter("totalPrice");
			String shipfee = request.getParameter("shipfee");
			String expectPoint = request.getParameter("expectPoint");
			String qUsepoint = request.getParameter("qUsepoint");
			String finalamount = request.getParameter("finalamount");
			String pnum = request.getParameter("pnum");
			String odqty = request.getParameter("odqty");
			String cartno = request.getParameter("cartno");
			String pdetailprice = request.getParameter("pdetailprice");
			
			
			
			// 0. 주문테이블에 입력되어야 할 주문전표를 채번(select)
		    // 1. 주문테이블에 insert(채번번호,fk_userid,totalPrice,shipstartdate,depositdate,finalamount)
	        // 2. 주문상세테이블에  insert(odetailno,채번번호,fk_pnum,odqty,shipstatus,pdetailprice)
	        // 3. 제품상세테이블에서 제품상세번호에 해당하는 제품 재고량 감소update(pnum,pqty )
	        // 4. 이용자가 포인트를 사용한 경우.. => 포인트 차감시키기, + 또는 적립금 넣어주기
	        //  update이며 , tbl_member에서(where userid,totalpoint) 
	        // 5. 장바구니에서 해당 제품 삭제 tbl_cart delete(cartno필요,fk_userid)
	        // 모든처리가 성공되었을 시 commit하기 (수동커밋)
	        // 6. SQL오류 발생 시 rollback하기
			
			if(cartno=="") { // 즉시구매를 통해 주문을 한 경우
				
				
				Map<String, String> para2Map = new HashMap<String, String>();
				para2Map.put("fk_userid", fk_userid);
				para2Map.put("totalPrice", totalPrice);
				para2Map.put("shipfee", shipfee);
				para2Map.put("expectPoint", expectPoint);
				para2Map.put("qUsepoint", qUsepoint);
				para2Map.put("finalamount", finalamount);
				para2Map.put("pnum", pnum);
				para2Map.put("odqty", odqty);
				para2Map.put("pdetailprice", pdetailprice);
				
				// 전표를 생성해주는 메소드 호출하기
				InterOrderDAO iodao = new OrderDAO();
				String orderno = iodao.getOrderno();
				
				// 주문테이블에 insert 및  다른 테이블에 update 등등
				para2Map.put("orderno", orderno);
				
				int success = iodao.orderAdd(para2Map);
				
				jsobj.put("success", success);
				
				if(success == 1) {
		              
		              // 세션에 저장되어져 있는 mvo 정보를 갱신
					  mvo.setTotalpoint(mvo.getTotalpoint()+Integer.parseInt(expectPoint)-Integer.parseInt(qUsepoint));
		              
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
			else { // 장바구니를 통해 하나의 상품만 주문을 한경우
				
				Map<String, String> para2Map = new HashMap<String, String>();
				para2Map.put("fk_userid", fk_userid);
				para2Map.put("totalPrice", totalPrice);
				para2Map.put("shipfee", shipfee);
				para2Map.put("expectPoint", expectPoint);
				para2Map.put("qUsepoint", qUsepoint);
				para2Map.put("finalamount", finalamount);
				para2Map.put("pnum", pnum);
				para2Map.put("odqty", odqty);
				para2Map.put("pdetailprice", pdetailprice);
				para2Map.put("cartno", cartno);
				
				// 전표를 생성해주는 메소드 호출하기
				InterOrderDAO iodao = new OrderDAO();
				String orderno = iodao.getOrderno();
				
				// 주문테이블에 insert 및  다른 테이블에 update 등등
				para2Map.put("orderno", orderno);
				
				int success = iodao.oneCartorder(para2Map);
				
				jsobj.put("success", success);
				
				if(success == 1) {
		              
		              // 세션에 저장되어져 있는 mvo 정보를 갱신
					  mvo.setTotalpoint(mvo.getTotalpoint()+Integer.parseInt(expectPoint)-Integer.parseInt(qUsepoint));
		              
		              ////////// === 주문이 완료되었다는 email 보내기 시작 === ///////////
					  /*
					  GoogleMail mail = new GoogleMail();
					  
					  String emailContents = mvo.getName()+"고객님의 주문이 완료됐습니다.";
					  
					  mail.sendmail(mvo.getEmail(), certificationCode);
					  */
				}
				// System.out.println("success"+success);
				json = jsobj.toString();
				
		        request.setAttribute("json", json);
		        
		        super.setRedirect(false);
		        super.setViewPage("/WEB-INF/jsonview.jsp");
			}
			
		}
		else {// 로그인 안했을경우
			
			
			String message = "로그인 후 이용바랍니다.";
			String loc = request.getContextPath()+"/home.cc";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			
		}
		
	
	}	
}

package order.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import order.model.*;

public class OrderListDisplayJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String fk_userid = request.getParameter("fk_userid"); // 로그인된 userid
		String start = request.getParameter("start"); 
		String len = request.getParameter("len");
	 /*
	        맨 처음에는 fk_userid 를  start("1") 부터 len("8")개를 보여준다.
	        더보기... 버튼을 클릭하면  fk_userid 를  start("9") 부터 len("8")개를 보여준다.
	        또  더보기... 버튼을 클릭하면  fk_userid 를   start("17") 부터 len("8")개를 보여준다.      
	 */
		InterOrderDAO odao = new OrderDAO();
		
		Map<String,String>paraMap = new HashMap<>(); //DB에 보내줄 값 MAP에 넣어주기
		paraMap.put("fk_userid", fk_userid);// 
		paraMap.put("start", start); // start "1" "9" "17" "25" "33"
		
		try {
			String end = String.valueOf( Integer.parseInt(start) + Integer.parseInt(len) -1 ) ;  //Map에 담아주기 위해 데이터 타입이 String이어야 하기 때문에 int로 바꾸어준 것을 String 으로 다시바꾸어 준다                   
			paraMap.put("end",end);   // end => start + len -1;
									  // end => "8" "16" "24" "32" "40"	
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
					
		
		List<OrderVO> orderList = odao.selectByOrderList(paraMap);  //Map으로 리턴해주어도 되는데 VO로 해보았음. VO 리턴 타입 객체가 여러개라는부분(ProductVO ,SpecVO,CategoryVO)..!처음배우니까 잘 보기!
		
		
		JSONArray jsonArr =new JSONArray();  // []내부적으로 자바스크립트의 배열이 나옴.
		
		if( orderList.size() > 0 ) { //DAO 에 prodList 초기치를 null 이 아니라 new로 해왔기 때문에 null이 들어오지 않는다.따라서 검사할때 size가 0이 아닌지 로 알아봐야한다.
			
			for(OrderVO ovo:orderList) {
				
				JSONObject jsonObj = new JSONObject(); // {} {} {} ...{} 객체가 여러번 나오게 된다.
				
				jsonObj.put("orderno", ovo.getOrderno());
	            jsonObj.put("fk_userid", ovo.getFk_userid());
	            jsonObj.put("totalPrice", ovo.getTotalPrice());
	            jsonObj.put("orderdate", ovo.getOrderdate());
	            jsonObj.put("shipstatus", ovo.getShipstatus());
	            jsonObj.put("shipfee", ovo.getShipfee());
	            jsonObj.put("finalamount", ovo.getFinalamount());
	            
	            jsonObj.put("pimage1", ovo.getPvo().getPimage1());
	            jsonObj.put("modelname", ovo.getPvo().getModelname());
	            jsonObj.put("fk_cnum", ovo.getPvo().getFk_cnum());
	            jsonObj.put("productname", ovo.getPvo().getProductname());
				
	            jsonObj.put("pcolor", ovo.getPdvo().getPcolor());
	            jsonObj.put("pnum", ovo.getPdvo().getPnum());
	            
	            jsonObj.put("odqty", ovo.getOdvo().getOdqty());
	            jsonObj.put("odetailno", ovo.getOdvo().getOdetailno());
	            
	            jsonArr.put(jsonObj);
	            
	            
			}//end of for----------------------------------------
		
			String json = jsonArr.toString(); //문자열로 변환
			
			request.setAttribute("json", json);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}
		 else {
	         // DB에서 조회된 것이 없다라면 (예를 들어 sname이 BEST인 경우는 DB에 없다)
	         
	         String json = jsonArr.toString(); // 문자열로 변환
	        
	         // *** 만약에  select 되어진 정보가 없다라면 [] 로 나오므로 null 이 아닌 요소가 없는 빈배열이다. *** --   
	         //   System.out.println("~~~~ 확인용 json => " + json);
	         //   ~~~~ 확인용 json => []
	         
	         request.setAttribute("json", json);
	         
	      //   super.setRedirect(false);
	         super.setViewPage("/WEB-INF/jsonview.jsp");
	         

		}
		
		
	}

}

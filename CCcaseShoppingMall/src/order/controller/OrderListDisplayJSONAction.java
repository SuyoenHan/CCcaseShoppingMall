package order.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.MemberVO;
import order.model.*;

public class OrderListDisplayJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session =request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		
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
	            jsonObj.put("Pnum", ovo.getPdvo().getPnum());
	            
	            jsonObj.put("odqty", ovo.getOdvo().getOdqty());
	            // jsonObj ==> {"pnum":1, "pname":"스마트TV", "code":"100000" , "pcompany":"삼성", .... ,"pinputdate":"2021-04-23", "discoutPercent":15}
	            // jsonObj ==> {"pnum":2, "pname":"노트북", "code":"100000" , "pcompany":"엘지", .... ,"pinputdate":"2021-04-23", "discoutPercent":10}
	            
	            jsonArr.put(jsonObj);
	            /*
	                [
	                	{"pnum":1, "pname":"스마트TV", "code":"100000" , "pcompany":"삼성", .... ,"pinputdate":"2021-04-23", "discoutPercent":15}
	                   ,{"pnum":2, "pname":"노트북", "code":"100000" , "pcompany":"엘지", .... ,"pinputdate":"2021-04-23", "discoutPercent":10}
	                   ,{.....}
	                   ,{.....}
	                   ,  ...
	                   ,{.....}
	                ] 
	            */
	            
	            
			}//end of for----------------------------------------
		
			String json = jsonArr.toString(); //문자열로 변환
			
		//	System.out.println("~~~ 확인용 json => "+ json);
		
      /*
           ~~~~ 확인용 json => [{"pnum":1,"code":"100000","pname":"스마트TV","pcompany":"삼성","saleprice":800000,"discoutPercent":34,"point":50,"pinputdate":"2021-04-23","pimage1":"tv_samsung_h450_1.png","pqty":100,"pimage2":"tv_samsung_h450_2.png","pcontent":"42인치 스마트 TV. 기능 짱!!","price":1200000,"sname":"HIT"}
                             ,{"pnum":2,"code":"100000","pname":"노트북","pcompany":"엘지","saleprice":750000,"discoutPercent":17,"point":30,"pinputdate":"2021-04-23","pimage1":"notebook_lg_gt50k_1.png","pqty":150,"pimage2":"notebook_lg_gt50k_2.png","pcontent":"노트북. 기능 짱!!","price":900000,"sname":"HIT"}
                             ,{"pnum":3,"code":"200000","pname":"바지","pcompany":"S사","saleprice":10000,"discoutPercent":17,"point":5,"pinputdate":"2021-04-23","pimage1":"cloth_canmart_1.png","pqty":20,"pimage2":"cloth_canmart_2.png","pcontent":"예뻐요!!","price":12000,"sname":"HIT"}
                             ,{"pnum":4,"code":"200000","pname":"남방","pcompany":"버카루","saleprice":13000,"discoutPercent":14,"point":10,"pinputdate":"2021-04-23","pimage1":"cloth_buckaroo_1.png","pqty":50,"pimage2":"cloth_buckaroo_2.png","pcontent":"멋져요!!","price":15000,"sname":"HIT"}
                             ,{"pnum":5,"code":"300000","pname":"세계탐험보물찾기시리즈","pcompany":"아이세움","saleprice":33000,"discoutPercent":6,"point":20,"pinputdate":"2021-04-23","pimage1":"book_bomul_1.png","pqty":100,"pimage2":"book_bomul_2.png","pcontent":"만화로 보는 세계여행","price":35000,"sname":"HIT"}
                             ,{"pnum":6,"code":"300000","pname":"만화한국사","pcompany":"녹색지팡이","saleprice":120000,"discoutPercent":8,"point":60,"pinputdate":"2021-04-23","pimage1":"book_koreahistory_1.png","pqty":80,"pimage2":"book_koreahistory_2.png","pcontent":"만화로 보는 이야기 한국사 전집","price":130000,"sname":"HIT"}
                             ,{"pnum":7,"code":"100000","pname":"노트북1","pcompany":"DELL","saleprice":1000000,"discoutPercent":17,"point":60,"pinputdate":"2021-04-23","pimage1":"1.jpg","pqty":100,"pimage2":"2.jpg","pcontent":"1번 노트북","price":1200000,"sname":"HIT"}
                             ,{"pnum":8,"code":"100000","pname":"노트북2","pcompany":"에이서","saleprice":1000000,"discoutPercent":17,"point":60,"pinputdate":"2021-04-23","pimage1":"3.jpg","pqty":100,"pimage2":"4.jpg","pcontent":"2번 노트북","price":1200000,"sname":"HIT"}]
       
       
           ~~~~ 확인용 json => [{"pnum":36,"code":"100000","pname":"노트북30","pcompany":"삼성전자","saleprice":1000000,"discoutPercent":17,"point":60,"pinputdate":"2021-04-23","pimage1":"59.jpg","pqty":100,"pimage2":"60.jpg","pcontent":"30번 노트북","price":1200000,"sname":"HIT"}
                             ,{"pnum":35,"code":"100000","pname":"노트북29","pcompany":"레노버","saleprice":1000000,"discoutPercent":17,"point":60,"pinputdate":"2021-04-23","pimage1":"57.jpg","pqty":100,"pimage2":"58.jpg","pcontent":"29번 노트북","price":1200000,"sname":"HIT"}
                             ,{"pnum":34,"code":"100000","pname":"노트북28","pcompany":"아수스","saleprice":1000000,"discoutPercent":17,"point":60,"pinputdate":"2021-04-23","pimage1":"55.jpg","pqty":100,"pimage2":"56.jpg","pcontent":"28번 노트북","price":1200000,"sname":"HIT"}
                             ,{"pnum":33,"code":"100000","pname":"노트북27","pcompany":"애플","saleprice":1000000,"discoutPercent":17,"point":60,"pinputdate":"2021-04-23","pimage1":"53.jpg","pqty":100,"pimage2":"54.jpg","pcontent":"27번 노트북","price":1200000,"sname":"HIT"}
                             ,{"pnum":32,"code":"100000","pname":"노트북26","pcompany":"MSI","saleprice":1000000,"discoutPercent":17,"point":60,"pinputdate":"2021-04-23","pimage1":"51.jpg","pqty":100,"pimage2":"52.jpg","pcontent":"26번 노트북","price":1200000,"sname":"HIT"}
                             ,{"pnum":31,"code":"100000","pname":"노트북25","pcompany":"삼성전자","saleprice":1000000,"discoutPercent":17,"point":60,"pinputdate":"2021-04-23","pimage1":"49.jpg","pqty":100,"pimage2":"50.jpg","pcontent":"25번 노트북","price":1200000,"sname":"HIT"}
                             ,{"pnum":30,"code":"100000","pname":"노트북24","pcompany":"한성컴퓨터","saleprice":1000000,"discoutPercent":17,"point":60,"pinputdate":"2021-04-23","pimage1":"47.jpg","pqty":100,"pimage2":"48.jpg","pcontent":"24번 노트북","price":1200000,"sname":"HIT"}
                             ,{"pnum":29,"code":"100000","pname":"노트북23","pcompany":"DELL","saleprice":1000000,"discoutPercent":17,"point":60,"pinputdate":"2021-04-23","pimage1":"45.jpg","pqty":100,"pimage2":"46.jpg","pcontent":"23번 노트북","price":1200000,"sname":"HIT"}]    
      */
			
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

package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import board.model.EventPartDAO;
import board.model.InterEventPartDAO;
import common.controller.AbstractController;


public class GawibawibopointUpdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			
			String userid = request.getParameter("userid");
			
			InterEventPartDAO epdao = new EventPartDAO();
			
			int n = epdao.updateUserPoint(userid);
			
			String msg = "";
		      
		      if(n==1) {
		         msg = "당첨!! 축하드립니다~~ "+userid+"님 500point 적립!";
		      }
		      
		      
		      JSONObject jsonObj = new JSONObject();
		      jsonObj.put("msg", msg ); // {"msg : "해당제품에 \n좋아요를 클릭 하셨습니다} 또는 {"msg : "이미 좋아요를 클릭하셨기에\n 두번 이상 좋아요는 불가합니다."} 
		      jsonObj.put("n", n );
		      
		      String json = jsonObj.toString(); // " {"msg : "해당제품에 \n좋아요를 클릭 하셨습니다} " 또는 " {"msg : "이미 좋아요를 클릭하셨기에\n 두번 이상 좋아요는 불가합니다."} "         
		      
		      request.setAttribute("json", json);
			
//		      super.setRedirect(false);
		      super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}
	}

}

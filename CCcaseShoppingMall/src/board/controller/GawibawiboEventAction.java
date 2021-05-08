package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import board.model.EventPartDAO;
import board.model.InterEventDAO;
import board.model.InterEventPartDAO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class GawibawiboEventAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			String eventno = request.getParameter("eventno");
			String userid = request.getParameter("userid");
			
			InterEventPartDAO epdao = new EventPartDAO();
			
			int n = epdao.insertUser(eventno,userid);
			
			String msg = "";
		      
		      if(n==1) {
		         msg = "해당 이벤트에 참여 완료!!";
		      }
		      else {
		         msg = "이미 이벤트에 참여하셨습니다. 중복 이벤트 참여는 불가합니다.";
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

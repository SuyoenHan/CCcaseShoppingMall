package board.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import board.model.*;
import common.controller.AbstractController;

public class LikeAddAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String userid = request.getParameter("userid");
		String reviewno = request.getParameter("reviewno");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("reviewno",reviewno);
		
		InterReviewDAO rdao = new ReviewDAO();
		
		int n = rdao.likeAdd(paraMap);
		
		String msg = "";
		
		if(n==1) {
			msg = "도움이 됐어요를 클릭하셨습니다.";
		}
		else {
			msg = "두번 이상 클릭은 불가합니다.";
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("msg", msg);
		
		String json = jsonObj.toString();
		
		request.setAttribute("json", json);
		
//		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}

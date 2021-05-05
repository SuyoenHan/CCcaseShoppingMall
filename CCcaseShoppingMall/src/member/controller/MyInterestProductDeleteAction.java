package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.*;

public class MyInterestProductDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method= request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) { // get방식으로 들어온 경우
			
			String message="잘못된 경로로 들어왔습니다.";
			String loc="javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");	
			return;	
		}
		else { // post방식으로 들어온 경우
			
			String sinterestno= request.getParameter("interestno");
			int interestno= Integer.parseInt(sinterestno);
			
			InterInterestProductDAO ipdao= new InterestProductDAO();
			int n= ipdao.deleteOneRow(interestno);
			
			JSONObject jsonObject= new JSONObject();
			jsonObject.put("n", n);
			
			String json= jsonObject.toString();
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
		
		
		
	}

}

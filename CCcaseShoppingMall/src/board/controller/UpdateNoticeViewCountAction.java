package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import board.model.*;
import common.controller.AbstractController;

public class UpdateNoticeViewCountAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		
		if("POST".equalsIgnoreCase(method)) {
			
			String noticeno = request.getParameter("noticeno");
			
			InterNoticeDAO ndao = new NoticeDAO();
			
				int n = ndao.updateViewCount(noticeno);
				String viewCount = ndao.selectNoticeViewCount(noticeno);
				
				JSONObject jsobj = new JSONObject(); 
		        jsobj.put("n", n);
		        jsobj.put("viewCount", viewCount);
		        
		        String json = jsobj.toString();
		          
		        request.setAttribute("json", json);
		          
		        super.setRedirect(false);
		        super.setViewPage("/WEB-INF/jsonview.jsp");
				///////////////////////////////////////////////////////////////////////////////////////////
				// 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임. 
				
			
		        
		        
				
			}
		
		
		}

}

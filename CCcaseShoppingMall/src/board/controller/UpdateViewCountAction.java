package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import board.model.FaqDAO;
import board.model.FaqVO;
import board.model.InterFaqDAO;
import common.controller.AbstractController;

public class UpdateViewCountAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

	
		String method = request.getMethod();
		
		
		if("POST".equalsIgnoreCase(method)) {
			
			String faqno = request.getParameter("faqno");
			
			InterFaqDAO fdao = new FaqDAO();
			
				int n = fdao.updateViewCount(faqno);
				String viewCount = fdao.selectViewCount(faqno);
				
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



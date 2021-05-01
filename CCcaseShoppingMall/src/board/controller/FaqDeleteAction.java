package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import board.model.FaqDAO;
import board.model.FaqVO;
import board.model.InterFaqDAO;
import common.controller.AbstractController;

public class FaqDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String faqno =request.getParameter("faqno");
		
		FaqVO fvo = new FaqVO();
		fvo.setFaqno(Integer.parseInt(faqno));
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			
			InterFaqDAO fdao = new FaqDAO();
			
			int n = fdao.faqDeleteOne(fvo);
			//n==1이라면 정삭적으로 삭제
			
			String message = "";
			
			
			if(n==1) {
				//delete가 성공되어지면
				message = "해당 글이 삭제되었습니다.";
	   	    	
			}
			else {
				//delete가 실패되어지면
				message = "글삭제가 실패되었습니다.";
	   	    	
				
			}
		
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("message",message);
			
			
			String json =jsonObj.toString();
			request.setAttribute("json", json);
	        
	         
	        super.setRedirect(false);
		    super.setViewPage("/WEB-INF/jsonview.jsp");
			
			
		}

	}
}

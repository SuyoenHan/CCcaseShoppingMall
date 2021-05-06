package admin.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import admin.model.*;
import board.model.*;
import common.controller.AbstractController;

public class ChangeRefundAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		AdminVO avo = (AdminVO)session.getAttribute("adminUser");

		
		if(avo!=null) { // 로그인을 했을경우
			
			String method = request.getMethod();
			
			if(!"post".equalsIgnoreCase(method)) { //get방식일때
			
				// DB에서 테이블 4개를 조인하여 해당정보만 뽑아오자.
				InterChRefundDAO icrdao =new ChRefundDAO(); 
				List<Map<String,String>> chRefundList =icrdao.selectchRefundList();
				
				if(chRefundList.size()==0) {
					String message = "조회된 결과가 존재하지 않습니다.";
					request.setAttribute("message", message);
				}
				else {
				request.setAttribute("chRefundList", chRefundList);
				}
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/admin/changeRefund.jsp");
			}
			else {//POST방식일때
				
				String fk_odetailno = request.getParameter("odetailno");
				
				int shipstatus;
				System.out.println(request.getParameter("sortno"));
				if("0".equalsIgnoreCase(request.getParameter("sortno"))) {
					shipstatus = 6;
				}
				else {
					shipstatus = 7;
				}
				
				System.out.println(shipstatus);
				
				InterChRefundDAO icrdao =new ChRefundDAO();
				int n = icrdao.deleteView(fk_odetailno,shipstatus);
				
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("n", n);
				
				String json = jsonObj.toString();
				
				request.setAttribute("json", json);
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/jsonview.jsp");
				
			}
			
			
		}
		else { // 로그인을 안했을 경우
			String message = "로그인 후 이용가능합니다.";
			String loc= request.getContextPath()+"/admin.cc";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/adminMsg.jsp");
			
		}
		
		
		
		
	}

}

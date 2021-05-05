package admin.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.*;
import board.model.*;
import common.controller.AbstractController;

public class ChangeRefundAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		AdminVO avo = (AdminVO)session.getAttribute("adminUser");

		
		if(avo!=null) { // 로그인을 했을경우
			
			
			// DB에서 테이블 4개를 조인하여 해당정보만 뽑아오자.
			InterChRefundDAO icrdao =new ChRefundDAO(); 
			List<Map<String,String>> chRefundList =icrdao.selectchRefundList();
			
			request.setAttribute("chRefundList", chRefundList);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/admin/changeRefund.jsp");
			
			
			
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

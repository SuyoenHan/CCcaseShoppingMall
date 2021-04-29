package admin.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.*;
import common.controller.AbstractController;
import product.model.*;

public class ProductmanageAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		AdminVO avo = (AdminVO)session.getAttribute("adminUser");
		
		
		if(avo == null) {
			String message = "로그인 후 이용가능합니다.";
			String loc = request.getContextPath()+"/admin.cc";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/adminMsg.jsp");
		}
		
		else {
			
			InterProductDetailDAO pddao = new ProductDetailDAO();
			List<Map<String,String>> proList = pddao.selectProInfo();
			
			request.setAttribute("proList", proList);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/admin/productManage.jsp");
			
		}
		
	}

}

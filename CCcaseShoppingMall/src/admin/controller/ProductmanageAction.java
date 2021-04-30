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
			
			// 일단 내가 보고있는 페이지 no가필요
			// 한페이지당 몇개 보여줄지가 필요한데 나는 10개 5개 3개를 이렇게 보여주기 위해서 또 selece태그에서 받아와야한다.
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			String sizePerPage = request.getParameter("sizePerPage");
			
			
			// 맨처음 url로 들어왔을때 get방식이니깐 위의 값들은 없다 따라서 if문써서 기본값필요
			if(sizePerPage==null ||!("3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage)) ) {
					sizePerPage="10";
				}
			if(currentShowPageNo==null) {
				currentShowPageNo="1";
			}
	
			
			request.setAttribute("sizePerPage", sizePerPage);
			
			InterProductDAO pdao = new ProductDAO();
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("sizePerPage", sizePerPage);
			paraMap.put("currentShowPageNo", currentShowPageNo);
			int totalPage = pdao.getTotalPage(paraMap);
			
			
			InterProductDetailDAO pddao = new ProductDetailDAO();
			List<Map<String,String>> proList = pddao.selectProInfo(paraMap);
			
			request.setAttribute("proList", proList);
			
			String pageBar= "";
			int blockSize= 5;  // 토막당 보여지는 페이지 개수
			int loop=1;
			int pageNo= ((Integer.parseInt(currentShowPageNo)-1)/blockSize) * blockSize + 1;  // 페이지바에서 처음으로 보여지는 번호 (1,6,11..)
			
			
			if(pageNo != 1) {
				pageBar += "&nbsp;<a href='productmanage.cc?currentShowPageNo=1&sizePerPage="+sizePerPage+"'>[맨처음]</a>&nbsp;"; 
				pageBar += "&nbsp;<a href='productmanage.cc?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"'>[이전]</a>&nbsp;";
			}
			
			while(!(loop>blockSize || pageNo > totalPage) ) {
				if(pageNo == Integer.parseInt(currentShowPageNo)) {
					pageBar += "&nbsp;<span style='padding:2px 4px; font-weight: bold; background-color: #ffff99;'>"+pageNo+"</span>&nbsp;";
				}
				else {
					pageBar += "&nbsp;<a href='productmanage.cc?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>"+pageNo+"</a>&nbsp;";
				}
				
				loop++;
				pageNo++; 
				
			}// end of while-----------------------------
			
			if(pageNo <= totalPage) {
				pageBar += "&nbsp;<a href='productmanage.cc?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>[다음]</a>&nbsp;";
				pageBar += "&nbsp;<a href='productmanage.cc?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"'>[마지막]</a>&nbsp;";
			}
			
			request.setAttribute("pageBar", pageBar);

			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/admin/productManage.jsp");
			
		}
		
	}

}

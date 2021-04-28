package admin.controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import admin.model.*;
import common.controller.AbstractController;
import product.model.*;

public class ProductRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		
		HttpSession session = request.getSession();
		AdminVO avo = (AdminVO)session.getAttribute("adminUser");
		
		if(avo == null) { // 관리자로 로그인을 안했을 경우
			
			String message = "로그인 후 이용가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/adminMsg.jsp");
			
		}
		else { // 관리자로 로그인을 했을경우
			
			String method = request.getMethod();
			
			if(!"POST".equalsIgnoreCase(method)) {
				
				// 카테고리 목록 조회해오기
				InterCategoryDAO cdao = new CategoryDAO();
				List<CategoryVO> categoryList = cdao.selectCategory();
				
				request.setAttribute("categoryList", categoryList);
				
				// 스펙목록 조회해오기
				InterSpecDAO sdao = new SpecDAO();
				List<HashMap<String,String>> specList = sdao.selectSpec();
				
				request.setAttribute("specList", specList);
				
				// 회사목록 조회해오기
				InterMobileCompanyDAO codao = new MobileCompanyDAO();
				List<MobileCompanyVO> companyList = codao.selectCompany();
				
				request.setAttribute("companyList", companyList);
				
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/admin/productRegister.jsp");
					
			} else {
				
				MultipartRequest mtrRequest = null;
				session = request.getSession();
				ServletContext svlCtx =  request.getServletContext();
				
				String imagesDir = svlCtx.getRealPath("/images");
				// System.out.println(imagesDir);
				imagesDir = "C:\\Users\\BAEK\\git\\CCcaseShoppingMall\\CCcaseShoppingMall\\WebContent\\jquery-ui-1.11.4.custom\\images";
				
				try {
					mtrRequest = new MultipartRequest(request, imagesDir, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
				} catch (IOException e) {
					request.setAttribute("message", "업로드 되어질 경로가 잘못되었거나 또는 최대용량 10MB를 초과했으므로 파일업로드 실패함!!");
	                request.setAttribute("loc", request.getContextPath()+"/shop/admin/productRegister.up");
	                
	                super.setViewPage("/WEB-INF/adminMsg.jsp");
	                return; // 종료
				}
				
			}
			
			
			
			
		}
		
	}

}

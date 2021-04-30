package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.*;

public class ModelListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String cnum= request.getParameter("cnum");
		
		// 카테고리 코드에 해당하는 카테고리명
		InterCategoryDAO cdao= new CategoryDAO();
		String cname= cdao.getCname(cnum);
		request.setAttribute("cname", cname);
		
		// 카테고리별 + 회사별 케이스 모델 기종명  
		InterProductDAO pdao= new ProductDAO();
		List<String> modelSam= pdao.getModelName("1000", cnum); // 카테고리명에 해당하는 삼성 케이스 모델 종류
		List<String> modelApp= pdao.getModelName("2000", cnum); // 카테고리명에 해당하는 애플 케이스 모델 종류
		List<String> modelLg= pdao.getModelName("3000", cnum); // 카테고리명에 해당하는 Lg 케이스 모델 종류
		
		request.setAttribute("modelSam", modelSam);
		request.setAttribute("modelApp", modelApp);
		request.setAttribute("modelLg", modelLg);
		
		
		
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/modelList.jsp");
		
		
	}

}

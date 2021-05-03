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
		request.setAttribute("cnum", cnum);
		
		// 카테고리별 + 회사별 케이스 모델 기종명 및 케이스 개수
		InterProductDAO pdao= new ProductDAO();
		List<Map<String,String>> cntSamList= pdao.getCntByModel("1000", cnum); // 삼성 cnum 모델기종명 및 케이스 개수
		List<Map<String,String>> cntAppList= pdao.getCntByModel("2000", cnum); // 애플 cnum 모델기종명 및 케이스 개수
		List<Map<String,String>> cntLgList= pdao.getCntByModel("3000", cnum); // Lg cnum 모델기종명 및 케이스 개수
		
		request.setAttribute("cntSamList", cntSamList);
		request.setAttribute("cntAppList", cntAppList);
		request.setAttribute("cntLgList", cntLgList);
		
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/modelList.jsp");
		
		
	}

}

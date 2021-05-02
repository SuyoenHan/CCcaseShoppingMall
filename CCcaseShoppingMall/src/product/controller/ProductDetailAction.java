package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.*;

public class ProductDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String productid= request.getParameter("productid");
		
		
		// 제품번호를 이용하여 상세정보페이지에서 필요한 정보 가져오기 
		
		InterProductDAO pdao= new ProductDAO();
		InterProductDetailDAO pddao= new ProductDetailDAO();
		InterImageFileDAO idao= new ImageFileDAO();
		
		Map<String,String> onePInfo= pdao.getOnePInfo(productid);
		request.setAttribute("onePInfo", onePInfo); 
		
		List<Map<String, String>> onePDetailInfoList= pddao.getOnePDetailInfo(productid);
		request.setAttribute("onePDetailInfoList", onePDetailInfoList);
		
		// List<Map<String, String>> imgFileByPnum= idao.selectImgFileByPnum(pnum);
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/productDetail.jsp");
	}

}

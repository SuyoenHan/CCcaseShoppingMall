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
		
		List<String> primePlusImgFile= new ArrayList<>();
		List<String> extraPlusImgFile= new ArrayList<>();
		
		for(Map<String, String> pDetailInfoMap : onePDetailInfoList) {
			
			String pnum= pDetailInfoMap.get("pnum");
			List<Map<String, String>> imgFileByPnum= idao.selectImgFileByPnum(pnum);
			
			for(int i=0;i<imgFileByPnum.size();i++) {
				
				for(int j=0;j<imgFileByPnum.get(i).size();j++) {
					String imgName= imgFileByPnum.get(i).get("imgplus"+(j+1));
					
					if(j==0) primePlusImgFile.add(imgName);
					else  extraPlusImgFile.add(imgName);
				}
			}
		} // end of for(Map<String, String> pDetailInfoMap : onePDetailInfoList) {---
		
		
		for(int i=0;i<extraPlusImgFile.size();i++) {
			if("noimage.png".equalsIgnoreCase(extraPlusImgFile.get(i))) {
				extraPlusImgFile.remove(i);
				i--;
			}
		}
		
		
		request.setAttribute("extraPlusImgFile", extraPlusImgFile);
		request.setAttribute("primePlusImgFile", primePlusImgFile);
		
		String goBackURL= request.getParameter("goBackURL");
		request.setAttribute("goBackURL", goBackURL);
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/productDetail.jsp");
	}

}

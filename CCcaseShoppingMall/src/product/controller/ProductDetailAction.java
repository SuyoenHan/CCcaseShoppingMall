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
		
		// pnum에 따라 이미지가 다르지만, 같은 productid이므로 pnum에 따라 이미지를 구분하지 않고 합쳐서 사용
		List<String> primePlusImgFile= new ArrayList<>(); // 추가이미지 중  imgplus1 담을 list (필수입력)
		List<String> extraPlusImgFile= new ArrayList<>(); // 추가이미지 중  imgplus2, imgplus2  담을 list (선택입력)
		
		for(Map<String, String> onePDetailInfoMap : onePDetailInfoList) {
			
			String pnum= onePDetailInfoMap.get("pnum");
			List<Map<String, String>> imgFileByPnumList= idao.selectImgFileByPnum(pnum);
			
			for(int i=0;i<imgFileByPnumList.size();i++) {

				for(int j=0;j<imgFileByPnumList.get(i).size();j++) {
					String imgFileName= imgFileByPnumList.get(i).get("imgplus"+(j+1));
					if(j==0)  primePlusImgFile.add(imgFileName);
					else extraPlusImgFile.add(imgFileName);
					// System.out.println(imgFileName);	
				}
			}
		} // end of for(Map<String, String> onePDetailInfoMap : onePDetailInfoList) {---------------------
		
		// 존재하지 않는 파일은 리스트에서 제거 
		for(int i=0;i<extraPlusImgFile.size();i++) {
			if("noimage.png".equalsIgnoreCase(extraPlusImgFile.get(i))){
				extraPlusImgFile.remove(i);
				i--;
			}
		}
		
		request.setAttribute("primePlusImgFile", primePlusImgFile);
		request.setAttribute("extraPlusImgFile", extraPlusImgFile);
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/productDetail.jsp");
	}

}

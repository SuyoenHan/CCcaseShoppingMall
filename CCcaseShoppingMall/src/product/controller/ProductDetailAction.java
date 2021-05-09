package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.*;

public class ProductDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 현재페이지 유지를 위함. 
		super.goBackURL(request);
		
		InterProductDAO pdao= new ProductDAO();
		InterProductDetailDAO pddao= new ProductDetailDAO();
		InterImageFileDAO idao= new ImageFileDAO();
		
		String productid= request.getParameter("productid");
		List<String> productList= pdao.getProductId();	
		
		boolean flag= false;
		for(int i=0;i<productList.size();i++) {
			if(productList!=null) {
				if(productList.get(i).equals(productid)) {
					flag=true;
					break;
				}
			}
		}
		if(!flag) {
			productid="1000-1-1"; // 맨 첫 제품으로!
		}
		
		// member/mycart.cc에서 넘어온 cartno, pnum, cinputcnt를 받아온다
		String cartno= request.getParameter("cartno");
		String pnum= request.getParameter("pnum");
		String cinputcnt= request.getParameter("cinputcnt");
		
		if(cartno==null) {
			cartno="null";
			pnum="null";
			cinputcnt="null";
		}
		
		request.setAttribute("cartno", cartno);
		request.setAttribute("pnum", pnum);
		request.setAttribute("cinputcnt", cinputcnt);
		
		

		// home.cc에서 넘어온 경우 snum 또는 doption값을 받아온다
		String snum= request.getParameter("snum");
		String doption= request.getParameter("doption");
		
		String pnumFromHome="null";
		int dOption= -1;
		if(snum==null) {
			snum="null";
		}
		else {
			pnumFromHome= pddao.getPnumBySnum(productid, snum);
			dOption= pddao.getDOptionByPnum(pnumFromHome);
		}
		
		if(doption==null) {
			doption="null";
		}
		else {
			pnumFromHome= pddao.getPnumByDoption(productid, doption);
			dOption= pddao.getDOptionByPnum(pnumFromHome);
		}
	
		request.setAttribute("pnumFromHome", pnumFromHome);
		request.setAttribute("dOption", dOption);

		
		// 제품번호를 이용하여 상세정보페이지에서 필요한 정보 가져오기 
		// 제품명, 모델명, 대표이미지, 정가, 할인가, 할인율, 카테고리명
		Map<String,String> onePInfo= pdao.getOnePInfo(productid); 
		request.setAttribute("onePInfo", onePInfo); 

		// 제품상세번호, 색상, 제품상세소개, 배송옵션
		List<Map<String, String>> onePDetailInfoList= pddao.getOnePDetailInfo(productid);
		request.setAttribute("onePDetailInfoList", onePDetailInfoList);
		
		List<String> primePlusImgFile= new ArrayList<>();
		List<String> extraPlusImgFile= new ArrayList<>();
		
		for(Map<String, String> pDetailInfoMap : onePDetailInfoList) {
			
			pnum= pDetailInfoMap.get("pnum");
			
			// 제품상세별 이미지
			List<Map<String, String>> imgFileByPnum= idao.selectImgFileByPnum(pnum);
			
			for(int i=0;i<imgFileByPnum.size();i++) {
				
				for(int j=0;j<imgFileByPnum.get(i).size();j++) {
					String imgName= imgFileByPnum.get(i).get("imgplus"+(j+1));
					
					if(j==0) primePlusImgFile.add(imgName); // 추가이미지1 (not null)
					else  extraPlusImgFile.add(imgName); // 추가이미지 2, 추가이미지 3 (null허용)
				}
			}
		} // end of for(Map<String, String> pDetailInfoMap : onePDetailInfoList) {---
		
		
		for(int i=0;i<extraPlusImgFile.size();i++) { // 추가이미지2, 추가이미지 3이 null인 경우 삭제
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

package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.*;

public class ProductListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// =========================== 한수연 시작 ======================================
		String method= request.getMethod();
		
		String mnum= request.getParameter("mnum");
		String cnum= request.getParameter("cnum");
		String modelName= request.getParameter("modelName"); // null인 경우 존재
		
		Map<String,String> paraMap= new HashMap<>();
		paraMap.put("mnum", mnum);
		paraMap.put("cnum", cnum);
		paraMap.put("modelName", modelName);
		
		InterMobileCompanyDAO mcdao= new MobileCompanyDAO();
		String mname= mcdao.getMname(mnum); // mnum에 해당하는 mname 알아오는 메소드
		
		/*
		 	mname==null 인 경우 mnum에 해당하는 회사명이 존재하지 않음
		 	mname!=null 인 경우 mnum에 해당하는 회사명 존재
		*/
		
		InterCategoryDAO cdao= new CategoryDAO();
		String cname= cdao.getCname(cnum); // cnum에 해당하는 cname 알아오는 메소드
		
		/*
		 	cname==null 인 경우 cnum에 해당하는 카테고리명이 존재하지 않음
		 	cname!=null 인 경우 cnum에 해당하는 카테고리명 존재
	    */

		request.setAttribute("mname", mname);
		request.setAttribute("mnum", mnum);
		request.setAttribute("cname", cname);
		request.setAttribute("cnum", cnum);
		request.setAttribute("modelName", modelName); // select 태그 값 고정하기 위한 용도
		
		InterProductDAO pdao= new ProductDAO();

		// mnum, cnum, modelName에 해당하는 필요한 제품 정보들을 map과 list에 담아서 requestScope에 저장 => modelName이 넘어오지 않은 경우는 ProductDAO에서 if절로 처리
	    //                  (제품번호, 제품명, 기종명, 대표이미지파일명, 제품정가, 할인판매가, 스펙번호, 할인율 )
		//List<Map<String,String>> pInfoList= pdao.getProductInfo(paraMap);
	     
		/* 
	 		일치하는 제품이 하나도 없는 경우: pInfoList.size() == 0
	 		일치하는 제품이 하나이상 있는 경우: pInfoList.size() > 0  
		*/
		
		//request.setAttribute("pInfoList", pInfoList);		
			

		
		// mnum과 cnum에 해당하는 기종명을 (중복되는 기종명은 1번만 사용) list에 담아서 requestScope에 저장
		// List<String> modelNameList= pdao.getModelName(mnum, cnum);
		/* 
	 		해당회사와 카테고리에 일치하는 기종명이 하나도 없는 경우: modelNameList.size() == 0
	 		해당회사와 카테고리에 일치하는 기종명이 하나이상 있는 경우: modelNameList.size() > 0  
		*/
		//request.setAttribute("modelNameList", modelNameList);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/productList.jsp");

		
/*		
		// ***** 제품 페이징바 구현
		
		String currentShowPageNo= "1";  // 현재 페이지번호
		String sizePerPage= "15";  // 한페이지당 보여줄 개수
		
		Map<String,String> pageMap= new HashMap<>();
		pageMap.put("currentShowPageNo", currentShowPageNo);
		pageMap.put("sizePerPage", sizePerPage);
		pageMap.put("cnum",cnum);
		pageMap.put("mnum",mnum);
		pageMap.put("modelName",modelName);

		int totalPage = pdao.selectTotalPage(pageMap); // 총페이지 개수
		
		
		// get방식으로 url 조작하는 경우의 수 고려
		if(Integer.parseInt(currentShowPageNo) > totalPage) {
			currentShowPageNo = "1";
			pageMap.put("currentShowPageNo", currentShowPageNo);
		}
		
		if(!"15".equals(sizePerPage)) {
			sizePerPage="15";
			pageMap.put("sizePerPage", sizePerPage);
		};
		
		
		List<Map<String,String>> memberList= pdao.selectPagingProduct(pageMap); 
*/		
		
		
		// =========================== 한수연 끝 ======================================
		

	}

}

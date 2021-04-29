package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import my.util.Myutil;
import product.model.*;

public class ProductListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// =========================== 한수연 시작 ======================================
		String method= request.getMethod();
		
		String mnum= request.getParameter("mnum");
		String cnum= request.getParameter("cnum");
		String modelName= request.getParameter("modelName"); // null인 경우 존재
		
		
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

		// mnum과 cnum에 해당하는 기종명을 (중복되는 기종명은 1번만 사용) list에 담아서 requestScope에 저장
		List<String> modelNameList= pdao.getModelName(mnum, cnum);
		
		/* 
	 		해당회사와 카테고리에 일치하는 기종명이 하나도 없는 경우: modelNameList.size() == 0
	 		해당회사와 카테고리에 일치하는 기종명이 하나이상 있는 경우: modelNameList.size() > 0  
		*/
		
		request.setAttribute("modelNameList", modelNameList);
		
		
		// ********************* 제품 페이징바 구현
		
		String currentShowPageNo= request.getParameter("currentShowPageNo");  // 현재 페이지번호
		String sizePerPage= "12";  // 한페이지당 보여줄 개수
		
		if(currentShowPageNo == null) {
			currentShowPageNo="1";
		}
		
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
		
		if(!"12".equals(sizePerPage)) {
			sizePerPage="12";
			pageMap.put("sizePerPage", sizePerPage);
		};
		
		// 한페이지에 보여줄 제품정보 메소드
		List<Map<String,String>> pInfoList= pdao.selectPagingProduct(pageMap); 
		request.setAttribute("pInfoList", pInfoList);
		
		
		String pageBar= "";
		int blockSize= 5;  // 토막당 보여지는 페이지 개수
		int loop=1;
		int pageNo= ((Integer.parseInt(currentShowPageNo)-1)/blockSize) * blockSize + 1;  // 페이지바에서 처음으로 보여지는 번호 (1,6,11..)
		
		if(modelName==null) {
			modelName="";
		}
		
		if(pageNo != 1) {
			pageBar += "&nbsp;<a href='productList.cc?currentShowPageNo=1&sizePerPage="+sizePerPage+"&mnum="+mnum+"&cnum="+cnum+"&modelName="+modelName+"'>[맨처음]</a>&nbsp;"; 
			pageBar += "&nbsp;<a href='productList.cc?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&mnum="+mnum+"&cnum="+cnum+"&modelName="+modelName+"'>[이전]</a>&nbsp;";
		}
		
		while(!(loop>blockSize || pageNo > totalPage) ) {
			if(pageNo == Integer.parseInt(currentShowPageNo)) {
				pageBar += "&nbsp;<span style='padding:2px 4px; font-weight: bold; background-color: #ffff99;'>"+pageNo+"</span>&nbsp;";
			}
			else {
				pageBar += "&nbsp;<a href='productList.cc?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&mnum="+mnum+"&cnum="+cnum+"&modelName="+modelName+"'>"+pageNo+"</a>&nbsp;";
			}
			
			loop++;
			pageNo++; 
			
		}// end of while-----------------------------
		
		if(pageNo <= totalPage) {
			pageBar += "&nbsp;<a href='productList.cc?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&mnum="+mnum+"&cnum="+cnum+"&modelName="+modelName+"'>[다음]</a>&nbsp";
			pageBar += "&nbsp;<a href='productList.cc?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&mnum="+mnum+"&cnum="+cnum+"&modelName="+modelName+"'>[마지막]</a>&nbsp";
		}
		
		request.setAttribute("pageBar", pageBar);
		
		
		// goBackURL 주소지정
		String currentURL= Myutil.getCurrentURL(request);
		currentURL= currentURL.replaceAll("&", " ");
		
		request.setAttribute("goBackURL", currentURL);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/productList.jsp");
		
		// =========================== 한수연 끝 ======================================
		

	}

}

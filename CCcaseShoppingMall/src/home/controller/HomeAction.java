package home.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import product.model.*;

public class HomeAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// =========================== 한수연 시작 ======================================
		InterProductDAO pdao= new ProductDAO();
		InterProductDetailDAO pddao= new ProductDetailDAO();
		
		// 회사+카테고리 별 제품 수 맵에 담아서 session에 저장
		Map<String,Integer> paraMap= new HashMap<>();
		
		int hardSamCnt= pdao.calCntByCompany(1000, 1);   // 삼성 하드케이스 개수
		// System.out.println(hardSamCnt);
		int jellySamCnt= pdao.calCntByCompany(1000, 2);  // 삼성 젤리케이스 개수
		int bumpSamCnt= pdao.calCntByCompany(1000, 3);   // 삼성 범퍼케이스 개수
		
		int hardAppCnt= pdao.calCntByCompany(2000, 1);   // 애플 하드케이스 개수
		int jellyAppCnt= pdao.calCntByCompany(2000, 2);  // 애플 젤리케이스 개수
		int bumpAppCnt= pdao.calCntByCompany(2000, 3);   // 애플 범퍼케이스 개수
		
		int hardLgCnt= pdao.calCntByCompany(3000, 1);    // LG 하드케이스 개수
		int jellyLgCnt= pdao.calCntByCompany(3000, 2);   // LG 젤리케이스 개수
		int bumpLgCnt= pdao.calCntByCompany(3000, 3);    // LG 범퍼케이스 개수
		
		paraMap.put("hardSamCnt", hardSamCnt);
		paraMap.put("jellySamCnt", jellySamCnt);
		paraMap.put("bumpSamCnt", bumpSamCnt);
		paraMap.put("hardAppCnt", hardAppCnt);
		paraMap.put("jellyAppCnt", jellyAppCnt);
		paraMap.put("bumpAppCnt", bumpAppCnt);
		paraMap.put("hardLgCnt", hardLgCnt);
		paraMap.put("jellyLgCnt", jellyLgCnt);
		paraMap.put("bumpLgCnt", bumpLgCnt);
		
		HttpSession session=request.getSession();
		session.setAttribute("paraMap", paraMap);
		
		
		// 회사+카테고리별 기종명 세션에 저장(중복되는 기종명은 1번만 사용)
		List<String> modelListSH= pdao.getModelName("1000", "1");  // 삼성 하드케이스 모델명 
		List<String> modelListSJ= pdao.getModelName("1000", "2");  // 삼성 젤리케이스 모델명 
		List<String> modelListSB= pdao.getModelName("1000", "3");  // 삼성 범퍼케이스 모델명 
		
		session.setAttribute("modelListSH", modelListSH);
		session.setAttribute("modelListSJ", modelListSJ);
		session.setAttribute("modelListSB", modelListSB);
		
		List<String> modelListAH= pdao.getModelName("2000", "1");  // 애플 하드케이스 모델명 
		List<String> modelListAJ= pdao.getModelName("2000", "2");  // 애플 젤리케이스 모델명 
		List<String> modelListAB= pdao.getModelName("2000", "3");  // 애플 범퍼케이스 모델명 
		
		session.setAttribute("modelListAH", modelListAH);
		session.setAttribute("modelListAJ", modelListAJ);
		session.setAttribute("modelListAB", modelListAB);
		
		List<String> modelListLH= pdao.getModelName("3000", "1");  // LG 하드케이스 모델명 
		List<String> modelListLJ= pdao.getModelName("3000", "2");  // LG 젤리케이스 모델명 
		List<String> modelListLB= pdao.getModelName("3000", "3");  // LG 범퍼케이스 모델명 
		
		session.setAttribute("modelListLH", modelListLH);
		session.setAttribute("modelListLJ", modelListLJ);
		session.setAttribute("modelListLB", modelListLB);
		
		
		// 스펙번호별 (snum) 제품 정보를 requestScope에 저장
		List<Map<String,String>> pInfoListBest= pdao.selectPInfoBySpec("0"); // BEST 상품정보
		List<Map<String,String>> pInfoListNew= pdao.selectPInfoBySpec("1"); // NEW 상품 정보
		
		int pBestCnt= pInfoListBest.size(); // BEST 상품 개수
		int pNewCnt= pInfoListNew.size(); // NEW 상품 개수
		
		request.setAttribute("pInfoListBest",pInfoListBest);
		request.setAttribute("pInfoListNew",pInfoListNew);
		request.setAttribute("pBestCnt",pBestCnt);
		request.setAttribute("pNewCnt",pNewCnt);
		
		
		// 무료배송인 제품 정보를 requestScope에 저장 (색상도 고려)
		List<Map<String,String>> pInfoListDFree= pddao.SelectPInfoByDelivery("0"); // 무료배송 상품정보
		int pFreeCnt= pInfoListDFree.size(); // 무료배송 상품 개수
		
		request.setAttribute("pInfoListDFree",pInfoListDFree);
		request.setAttribute("pFreeCnt",pFreeCnt);
		
				
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/home/homeMain.jsp");
		// =========================== 한수연 끝 ======================================
	}

}

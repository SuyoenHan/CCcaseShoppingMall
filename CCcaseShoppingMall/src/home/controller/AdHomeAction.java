package home.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.*;
import board.model.InterQnaDAO;
import board.model.QnaDAO;
import common.controller.AbstractController;
import product.model.*;

public class AdHomeAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		InterAdminDAO adao = new AdminDAO();
		
		//전일 총판매량 알아오기
		int yesterdayPdQty = adao.getYesterdayPdQty();
		session.setAttribute("yesterdayPdQty", yesterdayPdQty);
		//금일 총판매량 알아오기
		int todayPdQty = adao.getTodayPdQty();
		session.setAttribute("todayPdQty", todayPdQty);

		//전일 총판매액 알아오기
		List<Map<String,Integer>> getYesterProfitList = new ArrayList<>();
		getYesterProfitList = adao.getYesterProfitList();
		
		int yProfit = 0;
		
		for(Map<String,Integer> getYesterProfitMap : getYesterProfitList) {
			yProfit += getYesterProfitMap.get("yPrice") * getYesterProfitMap.get("yOdqty");
		}

	
		session.setAttribute("yProfit", yProfit);
		
		// 금일 총 판매액 알아오기
		List<Map<String,Integer>> getTodayProfitList = new ArrayList<>();
		getTodayProfitList = adao.getTodayProfitList();
		
		int tProfit = 0;
		
		for(Map<String,Integer> getTodayProfitMap : getTodayProfitList) {
			tProfit += getTodayProfitMap.get("tPrice") * getTodayProfitMap.get("tOdqty");
		}
		
		session.setAttribute("tProfit", tProfit);
		
		
		// 금일 케이스별 판매량 알아오기.
		InterCategoryDAO cdao = new CategoryDAO();
		
		List<CategoryVO> coList = cdao.selectCategory();
		
		for(CategoryVO cvo : coList) {
			
			int cnum = cvo.getCnum();
			
			if(cnum==1) {
				
				int hardSaleQty =  adao.getCaseSaleQty(cnum);
				session.setAttribute("hardSaleQty", hardSaleQty);
				
			}
			else if(cnum==2) {
				int jellySaleQty =  adao.getCaseSaleQty(cnum);
				session.setAttribute("jellySaleQty", jellySaleQty);
				
			}
			else {
				
				int bumpperSaleQty =  adao.getCaseSaleQty(cnum);
				session.setAttribute("bumpperSaleQty", bumpperSaleQty);
				
			}
		}
		
		/*
		 1	하드케이스
		 2	젤리케이스
		 3	범퍼케이스
		*/
		
		

		// 총회원수 알아오기      
		// 활동회원수   
		// 휴먼회원수   
		// 탈퇴회원수   
		// 금일가입회원수
		String sAllMemberCnt ="";
		int allMemberCnt = adao.getCntMember(sAllMemberCnt);
		session.setAttribute("allMemberCnt", allMemberCnt);
		
		String sActiveMemberCnt= " where idle = 0 ";
		int activeMemberCnt = adao.getCntMember(sActiveMemberCnt);	
		session.setAttribute("activeMemberCnt", activeMemberCnt);
		
		String sHumanMemberCnt= " where idle = 1 ";
		int humanMemberCnt = adao.getCntMember(sHumanMemberCnt);	
		session.setAttribute("humanMemberCnt", humanMemberCnt);
		
		String sOutMemberCnt= " where status = 0 ";
		int outMemberCnt = adao.getCntMember(sOutMemberCnt);	
		session.setAttribute("outMemberCnt", outMemberCnt);
		
		
		String sTodayRegisterCnt = " where registerday between sysdate-1 and sysdate ";
		int todayRegisterCnt = adao.getCntMember(sTodayRegisterCnt);
		session.setAttribute("todayRegisterCnt", todayRegisterCnt);
		
		// QNA미답변 글 수
		InterQnaDAO qdao = new QnaDAO();
		
		String sCntQna = " from tbl_qna ";
		int cntQna = qdao.getCntQnaCmt(sCntQna);
		
		String sCntCmt = " from tbl_qna join tbl_qnacmt on qnano = fk_qnano ";
		int cntCmt = qdao.getCntQnaCmt(sCntCmt);
		
		int noCmtCnt = cntQna - cntCmt;
		
		session.setAttribute("noCmtCnt", noCmtCnt);
		
		
		
		// ========================== 한수연 시작 ========================================
		// admin 홈페이지에서 main 홈페이지로 넘어오는 경우 homeAction.java를 거치지 않으므로 아래의 내용 추가
		
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
		List<Map<String,String>> pInfoListDFree= pddao.selectPInfoByDelivery("0"); // 무료배송 상품정보
		int pFreeCnt= pInfoListDFree.size(); // 무료배송 상품 개수
		
		request.setAttribute("pInfoListDFree",pInfoListDFree);
		request.setAttribute("pFreeCnt",pFreeCnt);
	
		
		// ========================== 한수연 끝 ========================================
		
		
	 // super.setRedirect(false);
		super.setViewPage("/WEB-INF/home/adHomeMain.jsp");
		
	}

}

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
		
		
		
		
		
		
	 // super.setRedirect(false);
		super.setViewPage("/WEB-INF/home/adHomeMain.jsp");
		
	}

}

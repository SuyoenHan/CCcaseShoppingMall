package home.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class HomeAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// =========================== 한수연 시작 ======================================
		InterProductDAO pdao= new ProductDAO();
		
		// 회사+카테고리 별 제품 수 맵에 담아서 session에 저장
		Map<String,Integer> paraMap= new HashMap<>();
		
		try {
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
			
		} catch(SQLException e) {
			System.out.println(">> ProductDAO의 calCntByCompany() 에서 SQL오류 발생");
		}
		
		HttpSession session=request.getSession();
		session.setAttribute("paraMap", paraMap);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/home/homeMain.jsp");
		// =========================== 한수연 끝 ======================================
	}

}

package member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;

public class MemberListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("회원조회 전용 페이지");
		
		// == 관리자(admin)로 로그인 했을 때만 조회가 가능하도록 한다. == //
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		// 관리자(admin)로 로그인 했을 경우
		if(loginuser != null && "admin".equals(loginuser.getUserid())) {
				
			InterMemberDAO mdao = new MemberDAO();
			
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			// currentShowPageNo 은 사용자가 보고자하는 페이지바의 페이지번호 이다.
			
			String sizePerPage = request.getParameter("sizePerPage");
			// 한 페이지당 화면상에 보여줄 회원의 개수
			
			if(currentShowPageNo == null) {
				currentShowPageNo = "1";
			}
			
			if(sizePerPage == null	|| "페이지 보기설정".equals(sizePerPage) 
			|| !("3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage) ) )  { // 사용자 임의로 보여지는 목록 개수를 조절하지 못하도록 막는 것
				sizePerPage = "10";
			}
			
			try {
					Integer.parseInt(currentShowPageNo);
			} catch (NumberFormatException e) {
				currentShowPageNo = "1";
			}
			
			///////////////////////////////////////////////////////////
			//	 ==== 검색어가 들어온 경우 ==== //
			String searchType = request.getParameter("searchType");
			String searchWord = request.getParameter("searchWord");
			
			/////////////////////////////////////////////////////////////////
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("currentShowPageNo", currentShowPageNo);
			paraMap.put("sizePerPage", sizePerPage);
			
			// 검색어가 들어온 경우
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);
			
			///////////////////////////////////////////////////////////
			// 페이징처리를 위해서 전체회원에 대한 총페이지 개수 알아오기(select)
			int totalPage = mdao.selectTotalPage(paraMap);
			
			
			
			
			
		}
		
	}

}

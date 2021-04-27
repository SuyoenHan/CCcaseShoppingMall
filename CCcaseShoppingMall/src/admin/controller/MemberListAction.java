package admin.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.*;
import common.controller.AbstractController;
import member.model.*;

public class MemberListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		// == 관리자(admin)로 로그인 했을 때만 조회가 가능하도록 한다. == //
		HttpSession session = request.getSession();
		AdminVO aloginuser = (AdminVO) session.getAttribute("admin");
		
		// 관리자(admin)로 로그인 했을 경우
		if(aloginuser == null) {
			
			InterMemberDAO mdao = new MemberDAO();
			
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			// currentShowPageNo 은 사용자가 보고자하는 페이지바의 페이지번호 이다.
			
			String sizePerPage = request.getParameter("sizePerPage");
			// 한 페이지당 화면상에 보여줄 회원의 개수
			
			if(currentShowPageNo == null) {
				currentShowPageNo = "1";
			}
			
			if(sizePerPage == null	|| "페이지 목록설정".equals(sizePerPage) 
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
			

			// 페이징처리를 위해서 전체회원에 대한 총페이지 개수 알아오기(select)
			int totalPage = mdao.selectTotalPage(paraMap);
			
			if( Integer.parseInt(currentShowPageNo)   > totalPage ) {
				currentShowPageNo = "1";
				paraMap.put("currentShowPageNo", currentShowPageNo);
			}
			
			List<MemberVO> memberList = mdao.selectPagingMember(paraMap);
			request.setAttribute("memberList", memberList);
			request.setAttribute("sizePerPage", sizePerPage);
			
			request.setAttribute("searchType", searchType);
			request.setAttribute("searchWord", searchWord);
			
			// **** ========= 페이지바 만들기 ========= **** //
			String pageBar = "";
			
			int blockSize = 10;
			int loop = 1;
			int pageNo = 0;
			
			pageNo = ( (Integer.parseInt(currentShowPageNo)- 1)/blockSize ) * blockSize + 1;
			
			if(searchType == null) {	// url 상에 null이 보이지 않게 만들기 (1) 
				searchType = "";
			}
			if(searchWord == null) { // url 상에 null이 보이지 않게 만들기 (2)
				searchWord = "";
			}
			
			// **** [맨처음][이전] 만들기 **** //
			if(pageNo != 1) {
				pageBar += "&nbsp;<a href='memberList.cc?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[맨처음]</a>&nbsp;"; 
				pageBar += "&nbsp;<a href='memberList.cc?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+ "' >[이전]</a>&nbsp;";
			}
			
			while( !(loop > blockSize || pageNo > totalPage) ) {
			
				if( pageNo == Integer.parseInt(currentShowPageNo)) {
					pageBar += "&nbsp;<span style='border:solid 1px gray; color:red; padding:2px 4px;'>" +pageNo + "</span>&nbsp;";
					}
				else {
				pageBar += "&nbsp;<a href='memberList.cc?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"' >" + pageNo + "</a>&nbsp;";
				}
				
				loop++;
				
				pageNo++;	
				
			}// end of while()---------------------------------------------------
			
			// **** [다음][마지막] 만들기 **** //
			if( pageNo <= totalPage ) {
				pageBar += "<a href='memberList.cc?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"' >[다음]</a>&nbsp;";
				pageBar += "<a href='memberList.cc?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"' >[마지막]</a>&nbsp;";
			}
			
			request.setAttribute("pageBar", pageBar);
			
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/admin/memberList.jsp");
		}
	else {
			
			String message = "로그인 후 이용 가능합니다.";
			String loc = "javascript:history.back()";
			
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	      //   super.setRedirect(false);
	         super.setViewPage("/WEB-INF/adminMsg.jsp");
		}

	}

}		




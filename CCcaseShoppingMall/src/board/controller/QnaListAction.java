package board.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.AdminVO;
import board.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;
import my.util.Myutil;


public class QnaListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 1.
		// *** 로그인 했을 때만 QNA 글 조회가 가능하도록 한다.
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		AdminVO adminUser = (AdminVO)session.getAttribute("adminUser");
		
		if( loginuser != null || adminUser!=null ) { // 로그인 했을 경우

			InterQnaDAO qdao = new QnaDAO();
			
			// 2.
			// *** 한 페이지당 보여줄 QNA 글 수 설정 
			String currentShowPageNo = request.getParameter("currentShowPageNo"); // 사용자가 보고자하는 페이지바의 페이지번호			
			String sizePerPage = request.getParameter("sizePerPage"); // 한 페이지당 화면상에 보여줄 qna 글의 개수
			
			if(currentShowPageNo == null) {
				currentShowPageNo = "1";
			}			
			if( sizePerPage == null ){ // 기본 default 값은 10
					sizePerPage = "10";
			}	
			
			// === 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자 아닌 문자를 입력한 경우 또는 int 범위를 초과한 숫자를 입력한 경우 
			try {
				Integer.parseInt(currentShowPageNo);
			} catch(NumberFormatException e) {
				currentShowPageNo = "1";
			}
			
			// === 검색어가 들어온 경우 
			String searchType = request.getParameter("searchType");
			String searchWord = request.getParameter("searchWord");
			
			// === 검색어가 null 값인 경우
			if("null".equals(searchType)) {
				searchType=" ";
			}			
			if("null".equals(searchWord)) {
				searchWord=" ";
			}
			
			// 3.
			// ***** 페이지바 시작 ******
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("currentShowPageNo", currentShowPageNo);
			paraMap.put("sizePerPage", sizePerPage);
			
			// 검색어가 들어온 경우
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);
			
			// === 페이징처리를 위해서 전체 qna 글에 대한 총페이지 개수 알아오기
			int totalPage = qdao.selectTotalPage(paraMap);
			
			// 현재 페이지가 토탈페이지보다 큰 오류방지
			if( Integer.parseInt(currentShowPageNo) > totalPage ) {  
				currentShowPageNo = "1";
				paraMap.put("currentShowPageNo", currentShowPageNo);
			}

			List<QnaVO> qnaList = qdao.selectPagingQna(paraMap);
			
			request.setAttribute("qnaList", qnaList);
			request.setAttribute("sizePerPage", sizePerPage);
			
			request.setAttribute("searchType", searchType);
			request.setAttribute("searchWord", searchWord);
			
			
			// *** 페이지바 생성 
			String pageBar = "";
			
			int blockSize = 10; // blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수		
			int loop=1; // loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도 			
			int pageNo=0; // pageNo 는 페이지바에서 보여지는 첫번째 번호
			   
			pageNo = ( ( Integer.parseInt(currentShowPageNo) -1)/blockSize)*blockSize+1 ; // 페이지바 구하는 공식
			
			// *** [처음][이전] 만들기 *** //
			if(pageNo != 1) {
				pageBar += "&nbsp;<a href='qnaList.cc?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[처음]</a>&nbsp;"; 						
				pageBar += "&nbsp;<a href='qnaList.cc?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[이전]</a>&nbsp;";
			}
			
			
			while(!(loop > blockSize || pageNo > totalPage)) {
				
				if( pageNo == Integer.parseInt(currentShowPageNo) ) {
					pageBar += "&nbsp;<span style='color:gray; padding:2px 4px;'>"+pageNo+"</span>&nbsp;"; 						
				}
				else {
					pageBar += "&nbsp;<a href='qnaList.cc?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a>&nbsp;"; 						
				}
				loop++;				
				pageNo++; 
				
			}// end of while --------------------------------------------
			
			// *** [다음][마지막] 만들기 *** //
			if(pageNo <= totalPage) {
				pageBar += "&nbsp;<a href='qnaList.cc?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[다음]</a>&nbsp;"; 						
				pageBar += "&nbsp;<a href='qnaList.cc?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[마지막]</a>&nbsp;";
			}
			
			request.setAttribute("pageBar", pageBar);

			// 4.
			// *** 현재 페이지를 돌아갈 페이지( goBackURL)로 지정하기 *** //
			String currentURL = Myutil.getCurrentURL(request);
			// 회원조회를 했을시 현재 그 페이지로 그대로 되돌아가기 위한 용도로 쓰인다.

			currentURL = currentURL.replaceAll("&", " ");

			request.setAttribute("goBackURL", currentURL);
			
			if(loginuser!=null) {
				//super.setRedirect(false);
				super.setViewPage("/WEB-INF/board/qnaList.jsp");
			}
			else if(adminUser != null) {
				super.setViewPage("/WEB-INF/board/adminQnaList.jsp");
			}
		}
		else {
			// 로그인을 안한 경우
			String message = "로그인 후 이용가능합니다.";
	        String loc = "javascript:history.back()";
	         
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	         
	  //   super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp");
		}	
		
	}

}

package board.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;
import my.util.Myutil;

public class ReviewListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser"); 
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
		
		InterReviewDAO rdao = new ReviewDAO();
		
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		// currentShowPageNo 은 사용자가 보고자하는 페이지바의 페이지번호 이다.
		
		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		
		request.setAttribute("currentShowPageNo", currentShowPageNo);
		
		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자 아닌 문자를 입력한 경우 또는 
        //     int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
		try { //사용자가 장난치는경우 INT값을 넘기는 경우 1페이지10개로 나타나게 해준다.
			Integer.parseInt(currentShowPageNo);
		}catch(NumberFormatException e) {
			currentShowPageNo ="1";
		}
		
		//	==== 검색어가 들어온 경우 ==== //
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("currentShowPageNo", currentShowPageNo);
		
		// 검색어가 들어온 경우
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		
		// 리뷰 총 개수 알아오기
		int rtotalCnt = rdao.selectRevCnt();
		request.setAttribute("rtotalCnt", rtotalCnt);
		
		// 페이징처리를 위해서 전체리뷰에 대한 총페이지 개수 알아오기(select)
		int totalPage = rdao.selectTotalPage(paraMap);
		
		if( Integer.parseInt(currentShowPageNo)   > totalPage ) {
			currentShowPageNo = "1";
			paraMap.put("currentShowPageNo", currentShowPageNo);
		}
		
		// 페이징 처리를 한 모든 리뷰 또는 검색한 리뷰 목록 보여주기
		List<ReviewVO> revList= rdao.selectPagingReview(paraMap);
		request.setAttribute("revList", revList);
		
		request.setAttribute("searchWord", searchWord);
		request.setAttribute("searchType", searchType);
		
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
			pageBar += "&nbsp;<a href='reviewList.cc?currentShowPageNo=1&searchType="+searchType+"&searchWord="+searchWord+"'>[맨처음]</a>&nbsp;"; 
			pageBar += "&nbsp;<a href='reviewList.cc?currentShowPageNo="+(pageNo-1)+"&searchType="+searchType+"&searchWord="+searchWord+ "' >[이전]</a>&nbsp;";
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if( pageNo == Integer.parseInt(currentShowPageNo)) {
				pageBar += "&nbsp;<span id='pagination' >" +pageNo + "</span>&nbsp;";
			}
			else {
				pageBar += "&nbsp;<a href='reviewList.cc?currentShowPageNo="+pageNo+"&searchType="+searchType+"&searchWord="+searchWord+"' >" + pageNo + "</a>&nbsp;";
			}
			
			loop++;
			
			pageNo++;	
			
		}// end of while()---------------------------------------------------
		
		// **** [다음][마지막] 만들기 **** //
		if( pageNo <= totalPage ) {
			
			pageBar += "<a href='reviewList.cc?currentShowPageNo="+pageNo+"&searchType="+searchType+"&searchWord="+searchWord+"' >[다음]</a>&nbsp;";
			pageBar += "<a href='reviewList.cc?currentShowPageNo="+totalPage+"&searchType="+searchType+"&searchWord="+searchWord+"' >[마지막]</a>&nbsp;";
		}
		
		request.setAttribute("pageBar", pageBar);
		
		String goBackURL= Myutil.getCurrentURL(request);
		 goBackURL= goBackURL.replaceAll("&", " ");
		 request.setAttribute("goBackURL", goBackURL);
		
		// super.setRedirect(false);
		super.setViewPage("/WEB-INF/board/reviewList.jsp");
		
	}
	
		
}		
}

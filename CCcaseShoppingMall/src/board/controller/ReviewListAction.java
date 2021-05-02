package board.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.*;
import common.controller.AbstractController;
import my.util.Myutil;

public class ReviewListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
		
		InterReviewDAO rdao = new ReviewDAO();
		
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		// currentShowPageNo 은 사용자가 보고자하는 페이지바의 페이지번호 이다.
		
		String sizePerPage = request.getParameter("sizePerPage");
		// 한 페이지당 화면상에 보여줄 리뷰의 개수
		
		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		
		if(sizePerPage == null) {
			sizePerPage = "10";
		}
		
		request.setAttribute("currentShowPageNo", currentShowPageNo);
		request.setAttribute("sizePerPage", sizePerPage);
		
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
		paraMap.put("sizePerPage", sizePerPage);
		
		// 검색어가 들어온 경우
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		// 조회수 증가시키기
		String reviewno = request.getParameter("reviewno");
		
		InterReviewDAO rdao2 = new ReviewDAO();
		
		if(reviewno != null) {
			rdao2.updateViewCount(reviewno);
		}
		else if(reviewno == null) {
			
		}
		
		request.setAttribute("reviewno", reviewno);
		
		
		// 페이징처리를 위해서 전체리뷰에 대한 총페이지 개수 알아오기(select)
		int totalPage = rdao.selectTotalPage(paraMap);
		
		if( Integer.parseInt(currentShowPageNo)   > totalPage ) {
			currentShowPageNo = "1";
			paraMap.put("currentShowPageNo", currentShowPageNo);
		}
		
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
			pageBar += "&nbsp;<a href='reviewList.cc?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[맨처음]</a>&nbsp;"; 
			pageBar += "&nbsp;<a href='reviewList.cc?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+ "' >[이전]</a>&nbsp;";
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if( pageNo == Integer.parseInt(currentShowPageNo)) {
				pageBar += "&nbsp;<span id='pagination' >" +pageNo + "</span>&nbsp;";
			}
			else {
				pageBar += "&nbsp;<a href='reviewList.cc?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"' >" + pageNo + "</a>&nbsp;";
			}
			
			loop++;
			
			pageNo++;	
			
		}// end of while()---------------------------------------------------
		
		// **** [다음][마지막] 만들기 **** //
		if( pageNo <= totalPage ) {
			
			pageBar += "<a href='reviewList.cc?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"' >[다음]</a>&nbsp;";
			pageBar += "<a href='reviewList.cc?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"' >[마지막]</a>&nbsp;";
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
